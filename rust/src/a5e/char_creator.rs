use godot::{classes::{Button, Control, IControl, ItemList, TabContainer}, prelude::*};

#[derive(Default, GodotConvert, Var, Debug, Copy, Clone, PartialEq)]
#[godot(via = GString)]
enum Heritage {
    #[default]
    None,
    Dragonborn,
    Dwarf,
    Elf,
    Gnome,
    Halfling,
    Human,
    Orc,
    Planetouched
}

impl TryFrom<Variant> for Heritage {
    type Error = String;

    fn try_from(value: Variant) -> Result<Self, Self::Error> {
        match value.try_to::<i64>() {
            Ok(idx) => match idx {
                -1 => Ok(Self::None),
                0 => Ok(Self::Dragonborn),
                1 => Ok(Self::Dwarf),
                2 => Ok(Self::Elf),
                3 => Ok(Self::Gnome),
                4 => Ok(Self::Halfling),
                5 => Ok(Self::Human),
                6 => Ok(Self::Orc),
                7 => Ok(Self::Planetouched),
                _ => Err(format!("Invalid index: {}", idx))
            },
            Err(e) => Err(e.to_string())
        }
    }
}

impl Into<Variant> for Heritage {
    fn into(self) -> Variant {
        match self {
            Self::None => Variant::from(-1),
            Self::Dragonborn => Variant::from(0),
            Self::Dwarf => Variant::from(1),
            Self::Elf => Variant::from(2),
            Self::Gnome => Variant::from(3),
            Self::Halfling => Variant::from(4),
            Self::Human => Variant::from(5),
            Self::Orc => Variant::from(6),
            Self::Planetouched => Variant::from(7)
        }
    }
}

#[derive(GodotClass)]
#[class(base=Control)]
pub struct CharCreatorA5E {
    heritage: Heritage,
    #[export]
    tabs: Option<Gd<TabContainer>>,
    base: Base<Control>,
    current_tab: i32,
}

#[godot_api]
impl IControl for CharCreatorA5E {
    fn init(base: Base<Control>) -> Self {
        Self {
            heritage: Heritage::default(),
            tabs: None,
            base,
            current_tab: 0
        }
    }

    fn ready(&mut self) {
        self.tabs = Some(self.base().get_node_as(GString::from("TabbedPanel/TabContainer")));
    }

    fn process(&mut self, _delta: f64) {
        let next_button_vis = self.base().get_node_as::<Button>("NextButton").is_visible();
        let _back_button_vis = self.base().get_node_as::<Button>("BackButton").is_visible();

        if self.current_tab == 0 {
            if self.heritage != Heritage::None && !next_button_vis {
                self.base_mut().get_node_as::<Button>("NextButton").set_visible(true);
            }
        }
    }
}

#[godot_api]
impl CharCreatorA5E {
    #[func]
    pub fn tab_pressed(&mut self, _tab: i64) {
        self.get_tabs().unwrap().set_current_tab(self.current_tab);
    }

    #[func]
    pub fn tab_val_selected(&mut self, instance_id: i64, index: i64) {
        let heritage_id = self.base().get_node_as::<CharCreatorA5EItemList>(GString::from("TabbedPanel/TabContainer/Heritage")).instance_id();
        let heritage_gifts_id = self.base().get_node_as::<CharCreatorA5EItemList>(GString::from("TabbedPanel/TabContainer/HeritageGifts")).instance_id();
        let culture_id = self.base().get_node_as::<CharCreatorA5EItemList>(GString::from("TabbedPanel/TabContainer/Culture")).instance_id();
        let instance = InstanceId::from_i64(instance_id);

        if instance == heritage_id {
            match Heritage::try_from(Variant::from(index)) {
                Ok(heritage) => {
                    self.heritage = heritage;
                    self.base_mut().emit_signal("heritage_changed".into(), &[heritage.into()]);
                },
                Err(e) => godot_error!("{}", e)
            }
        } else if instance == culture_id {
            // do something with that
        } else if instance == heritage_gifts_id {
            // do something with that
        }
    }

    #[signal]
    pub fn heritage_changed(&mut self, heritage: Variant);

    #[signal]
    pub fn culture_chagned(&mut self, culture: Variant);

    #[func]
    pub fn next_button(&mut self) {
        match self.current_tab {
            0 => {
                self.current_tab = 1;
                self.base_mut().get_node_as::<TabContainer>(GString::from("TabbedPanel/TabContainer")).set_current_tab(1);
                self.base_mut().get_node_as::<Button>(GString::from("NextButton")).set_visible(false);
            },
            _ => ()
        }
    }

    #[func]
    pub fn back_button(&mut self) {
        match self.current_tab {
            1 => {
                self.current_tab = 0;
            },
            _ => ()
        }
    }
}

#[derive(GodotClass)]
#[class(base=ItemList, init)]
pub struct CharCreatorA5EItemList {
    base: Base<ItemList>
}

#[godot_api]
impl CharCreatorA5EItemList {
    #[signal]
    pub fn item_selected_instance(&mut self, instance_id: InstanceId, index: i64);

    #[func]
    pub fn item_selected(&mut self, index: i64) {
        let instance_id = self.base().instance_id();
        self.base_mut().emit_signal("item_selected_instance".into(), &[Variant::from(instance_id.into_godot()), Variant::from(index)]);
    }
}