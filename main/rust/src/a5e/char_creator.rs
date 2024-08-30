use godot::{classes::{control::MouseFilter, Button, Control, HBoxContainer, IControl, IItemList, ItemList, Json, Label, Panel, RandomNumberGenerator, TabContainer, VBoxContainer}, prelude::*};
use super::heritage_gift::Gift;
use std::collections::HashMap;
use crate::utils::tooltip_label::TooltipLabel;

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

impl Into<String> for Heritage {
    fn into(self) -> String {
        match self {
            Self::None => String::from("none"),
            Self::Dragonborn => String::from("dragonborn"),
            Self::Dwarf => String::from("dwarf"),
            Self::Elf => String::from("elf"),
            Self::Gnome => String::from("gnome"),
            Self::Halfling => String::from("halfling"),
            Self::Human => String::from("human"),
            Self::Orc => String::from("orc"),
            Self::Planetouched => String::from("planetouched")
        }
    }
}

impl Heritage {
    pub fn get_localization_str(&self) -> &'static str {
        match self {
            Self::None => "",
            Self::Dragonborn => "HERITAGE_DRAG",
            Self::Dwarf => "HERITAGE_DWAR",
            Self::Elf => "HERITAGE_ELF",
            Self::Gnome => "HERITAGE_GNOM",
            Self::Halfling => "HERITAGE_HALF",
            Self::Human => "HERITAGE_HUMA",
            Self::Orc => "HERITAGE_ORC",
            Self::Planetouched => "HERITAGE_PLAN"
        }
    }
}

#[derive(GodotClass)]
#[class(base=Control)]
pub struct CharCreatorA5E {
    heritage: Heritage,
    heritage_gift: Option<i32>,
    culture: Option<i32>,
    #[export]
    tabs: Option<Gd<TabContainer>>,
    base: Base<Control>,
    current_tab: i32,
    heritage_gifts: HashMap<String, Vec<Gift>>,
}

#[godot_api]
impl IControl for CharCreatorA5E {
    fn init(base: Base<Control>) -> Self {
        Self {
            heritage: Heritage::default(),
            heritage_gift: None,
            culture: None,
            tabs: None,
            base,
            current_tab: 0,
            heritage_gifts: HashMap::new()
        }
    }

    fn ready(&mut self) {
        self.tabs = Some(self.base().get_node_as(GString::from("TabbedPanel/TabContainer")));
        let heritage_gifts: Gd<Json> = load("res://char_creator_a5e/heritage_gifts.tres");
        let gift_data: Dictionary = heritage_gifts.get_data().to();

        for heritage in &["dragonborn", "dwarf", "elf", "gnome", "halfling", "human", "orc", "planetouched"] {
            let data: Vec<Variant> = gift_data.get(*heritage).unwrap().to();
            let mut gifts = Vec::new();

            for gift in &data {
                gifts.push(Gift::from(gift.clone()))
            }

            self.heritage_gifts.insert(String::from(*heritage), gifts);
        }

        let mut hp_label = self.base().tr_n("MAX_HP_LABEL".into(), "MAX_HP_LABEL".into(), 1).to_string();
        hp_label += ": 12";
        self.base_mut().get_node_as::<Label>(GString::from("StatPanel/HPLabel")).set_text(GString::from(hp_label));
    }

    fn process(&mut self, _delta: f64) {
        let next_button_vis = self.base().get_node_as::<Button>("NextButton").is_visible();

        if self.current_tab == 0 {
            if self.heritage != Heritage::None && !next_button_vis {
                self.base_mut().get_node_as::<Button>("NextButton").set_visible(true);
            }
        } else if self.current_tab == 1 {
            if let Some(_) = self.heritage_gift {
                if !next_button_vis {
                    self.base_mut().get_node_as::<Button>(GString::from("NextButton")).set_visible(true);
                }
            }
        } else if self.current_tab == 2 {
            if let Some(_) = self.culture {
                if !next_button_vis {
                    self.base_mut().get_node_as::<Button>(GString::from("NextButton")).set_visible(true);
                }
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
        let heritage_gifts_id = self.base().get_node_as::<CharCreatorA5EItemList>(GString::from("TabbedPanel/TabContainer/Heritage Gifts")).instance_id();
        let culture_id = self.base().get_node_as::<CharCreatorA5EItemList>(GString::from("TabbedPanel/TabContainer/Culture")).instance_id();
        let class_id = self.base().get_node_as::<CharCreatorA5EItemList>(GString::from("TabbedPanel/TabContainer/Class")).instance_id();
        let instance = InstanceId::from_i64(instance_id);

        if instance == heritage_id {
            match Heritage::try_from(Variant::from(index)) {
                Ok(heritage) => {
                    self.heritage = heritage;
                    self.base_mut().emit_signal("heritage_changed".into(), &[heritage.into()]);
                    let heritages = vec!["dragonborn", "dwarf", "elf", "gnome", "halfling", "human", "orc", "planetouched"];
                    let item_num = self.base().get_node_as::<CharCreatorA5EItemList>(GString::from("TabbedPanel/TabContainer/Heritage Gifts")).get_item_count();

                    for i in 0..item_num {
                        self.base_mut().get_node_as::<CharCreatorA5EItemList>(GString::from("TabbedPanel/TabContainer/Heritage Gifts")).remove_item(i);
                    }

                    let gifts = self.heritage_gifts[heritages[index as usize]].clone();
                    let gift_names = gifts.iter().map(|gift| gift.name.clone()).collect::<Vec<String>>();

                    for gift in gift_names.iter() {
                        let name = self.base().tr_n(gift.clone().into(), gift.clone().into(), 1);
                        self.base_mut().get_node_as::<CharCreatorA5EItemList>(GString::from("TabbedPanel/TabContainer/Heritage Gifts")).add_item(name);
                    }

                    let heritage_text = self.base().tr_n(heritage.get_localization_str().into(), heritage.get_localization_str().into(), 1);
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/HeritageLabel")).set_text(heritage_text);
                },
                Err(e) => godot_error!("{}", e)
            }
        } else if instance == culture_id {
            self.culture = Some(index as i32);
            let cultures = vec!["CULTURE_CARA", "CULTURE_CIRC", "CULTURE_COLL", "CULTURE_COSM", "CULTURE_DEDW", "CULTURE_DEGN", "CULTURE_DRBN", "CULTURE_DRCT", "CULTURE_ELAD", "CULTURE_FORE", "CULTURE_FORG", "CULTURE_FORS", "CULTURE_GODB", "CULTURE_HIGH", "CULTURE_HILL", "CULTURE_IMPE", "CULTURE_ITIN", "CULTURE_KITH", "CULTURE_LONE", "CULTURE_MOUN", "CULTURE_MIST", "CULTURE_NOMA", "CULTURE_SETT", "CULTURE_SHAD", "CULTURE_STEA", "CULTURE_STOI", "CULTURE_STON", "CULTURE_STOU", "CULTURE_TINK", "CULTURE_TUNN", "CULTURE_TYRA", "CULTURE_VILL", "CULTURE_WARH", "CULTURE_WILD", 
            "CULTURE_WOOD"];
            let culture_text = self.base().tr_n(cultures[index as usize].into(), cultures[index as usize].into(), 1);
            self.base_mut().get_node_as::<Label>(GString::from("StatPanel/CultureLabel")).set_text(culture_text);
        } else if instance == heritage_gifts_id {
            self.heritage_gift = Some(index as i32);
            let heritage_gifts = self.heritage_gifts.clone();
            let heritage = self.heritage.clone();
            let heritage_key: String = heritage.into();
            self.base_mut().emit_signal("heritage_gift_changed".into(), &[Variant::from(index)]);
            let gift = heritage_gifts.get(&heritage_key).unwrap().get(index as usize).unwrap();
            let child_num = self.base().get_node_as::<VBoxContainer>(GString::from("FeaturePanel/FeatureContainer")).get_child_count();

            for i in (0..child_num).rev() {
                let child = self.base().get_node_as::<VBoxContainer>(GString::from("FeaturePanel/FeatureContainer")).get_child(i).unwrap();
                self.base_mut().get_node_as::<VBoxContainer>(GString::from("FeaturePanel/FeatureContainer")).remove_child(child);
            }

            for feature in gift.features.iter() {
                let mut new_label = TooltipLabel::new_alloc();
                new_label.set_text(GString::from(&feature.name));
                new_label.set_tooltip_text(GString::from(&feature.desc));
                new_label.set_mouse_filter(MouseFilter::STOP);
                self.base_mut().get_node_as::<VBoxContainer>(GString::from("FeaturePanel/FeatureContainer")).add_child(new_label);
            }

            self.base_mut().get_node_as::<Panel>("FeaturePanel").set_visible(true);
        } else if instance == class_id {
            let stats = self.gen_stats();
            let star_label = GString::from("⭐");
            let labels: Vec<&'static str>;
            let classes = vec!["CLASS_ADEP", "CLASS_BARD", "CLASS_BERS", "CLASS_HERA", "CLASS_DRUI", "CLASS_FIGH", "CLASS_MARS", "CLASS_RANG", "CLASS_ROGU", "CLASS_SORC", "CLASS_WARL", "CLASS_WIZA"];
            let hp: i32;
            let mut con = 0i32;
        
            for i in 0..6 {
                self.base_mut().get_node_as::<HBoxContainer>(GString::from("StatPanel/StatStarBox")).get_child(i).unwrap().try_cast::<Label>().unwrap().set_text(GString::from(""));
                self.base_mut().get_node_as::<HBoxContainer>(GString::from("StatPanel/StatNumberBox")).get_child(i).unwrap().try_cast::<Label>().unwrap().set_text(GString::from(""));
            }

            match index {
                0 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/DexLabel")).set_text(star_label);
                    labels = vec!["Dex", "Con", "Wis", "Str", "Cha", "Int"];
                    hp = 8;
                },
                1 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/ChaLabel")).set_text(star_label);
                    labels = vec!["Cha", "Dex", "Con", "Int", "Wis", "Str"];
                    hp = 8;
                },
                2 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/StrLabel")).set_text(star_label);
                    labels = vec!["Str", "Con", "Dex", "Wis", "Cha", "Int"];
                    hp = 12;
                },
                3 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/WisLabel")).set_text(star_label);
                    labels = vec!["Wis", "Str", "Con", "Cha", "Dex", "Int"];
                    hp = 8;
                },
                4 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/WisLabel")).set_text(star_label);
                    labels = vec!["Wis", "Dex", "Con", "Cha", "Str", "Int"];
                    hp = 8;
                },
                5 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/StrLabel")).set_text(star_label);
                    labels = vec!["Str", "Con", "Dex", "Wis", "Int", "Cha"];
                    hp = 10;
                },
                6 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/StrLabel")).set_text(star_label);
                    labels = vec!["Str", "Cha", "Con", "Dex", "Wis", "Int"];
                    hp = 10;
                },
                7 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/StrLabel")).set_text(star_label);
                    labels = vec!["Str", "Con", "Dex", "Wis", "Int", "Cha"];
                    hp = 10;
                },
                8 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/DexLabel")).set_text(star_label);
                    labels = vec!["Dex", "Wis", "Con", "Str", "Cha", "Int"];
                    hp = 10;
                },
                9 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/DexLabel")).set_text(star_label);
                    labels = vec!["Dex", "Con", "Int", "Wis", "Cha", "Str"];
                    hp = 8;
                },
                10 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/ChaLabel")).set_text(star_label);
                    labels = vec!["Cha", "Con", "Dex", "Int", "Wis", "Str"];
                    hp = 6;
                },
                11 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/ChaLabel")).set_text(star_label);
                    labels = vec!["Cha", "Con", "Dex", "Int", "Wis", "Str"];
                    hp = 8;
                },
                12 => {
                    self.base_mut().get_node_as::<Label>(GString::from("StatPanel/StatStarBox/IntLabel")).set_text(star_label);
                    labels = vec!["Int", "Con", "Dex", "Cha", "Wis", "Str"];
                    hp = 6;
                },
                _ => panic!("This shouldn't be here and if it is, well, then the panic is deserved")
            }

            for (i, label) in labels.iter().enumerate() {
                self.base_mut().get_node_as::<Label>(GString::from(format!("StatPanel/StatNumberBox/{}Label", label))).set_text(GString::from(stats[i].to_string()));

                if *label == "Con" {
                    con = stats[i];
                }
            }

            let mut class_label = self.base().tr_n("LEVEL_LABEL".into(), "LEVEL_LABEL".into(), 1).to_string();
            class_label += " 1 ";
            class_label += &self.base().tr_n(classes[index as usize].into(), classes[index as usize].into(), 1).to_string();
            self.base_mut().get_node_as::<Label>(GString::from("StatPanel/ClassLabel")).set_text(GString::from(class_label));
            let mut hp_label = self.base().tr_n("MAX_HP_LABEL".into(), "MAX_HP_LABEL".into(), 1).to_string();
            hp_label += ": ";
            hp_label += &(hp + ((con - 10) / 2)).to_string();
            self.base_mut().get_node_as::<Label>(GString::from("StatPanel/HPLabel")).set_text(GString::from(hp_label));
            self.base_mut().emit_signal("class_changed".into(), &[Variant::from(index)]);
        }
    }

    #[signal]
    pub fn heritage_changed(&mut self, heritage: Variant);

    #[signal]
    pub fn culture_changed(&mut self, culture: Variant);

    #[signal]
    pub fn heritage_gift_changed(&mut self, gift: i32);

    #[signal]
    pub fn class_changed(&mut self, class: i32);

    #[func]
    pub fn next_button(&mut self) {
        match self.current_tab {
            0 => {
                self.current_tab = 1;
                self.base_mut().get_node_as::<TabContainer>(GString::from("TabbedPanel/TabContainer")).set_current_tab(1);
                self.base_mut().get_node_as::<Button>(GString::from("NextButton")).set_visible(false);
                self.base_mut().get_node_as::<Button>(GString::from("BackButton")).set_visible(true);
                let gift = self.heritage_gift;
                self.base_mut().get_node_as::<Panel>(GString::from("FeaturePanel")).set_visible(gift.is_some());
            },
            1 => {
                self.current_tab = 2;
                self.base_mut().get_node_as::<TabContainer>(GString::from("TabbedPanel/TabContainer")).set_current_tab(2);
                self.base_mut().get_node_as::<Button>(GString::from("NextButton")).set_visible(false);
                self.base_mut().get_node_as::<Panel>(GString::from("FeaturePanel")).set_visible(false);
            },
            2 => {
                self.current_tab = 3;
                self.base_mut().get_node_as::<TabContainer>(GString::from("TabbedPanel/TabContainer")).set_current_tab(3);
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
                self.base_mut().get_node_as::<TabContainer>(GString::from("TabbedPanel/TabContainer")).set_current_tab(0);
                let heritage = self.heritage;
                self.base_mut().get_node_as::<Button>(GString::from("NextButton")).set_visible(heritage != Heritage::None);
                self.base_mut().get_node_as::<Button>(GString::from("BackButton")).set_visible(false);
                self.base_mut().get_node_as::<Panel>(GString::from("FeaturePanel")).set_visible(false);
            },
            2 => {
                self.current_tab = 1;
                self.base_mut().get_node_as::<TabContainer>(GString::from("TabbedPanel/TabContainer")).set_current_tab(1);
                let gift = self.heritage_gift;
                self.base_mut().get_node_as::<Button>(GString::from("NextButton")).set_visible(gift.is_some());
                self.base_mut().get_node_as::<Panel>(GString::from("FeaturePanel")).set_visible(true);
            },
            3 => {
                self.current_tab = 2;
                self.base_mut().get_node_as::<TabContainer>(GString::from("TabbedPanel/TabContainer")).set_current_tab(2);
                let culture = self.culture;
                self.base_mut().get_node_as::<Button>(GString::from("NextButton")).set_visible(culture.is_some());
            },
            _ => ()
        }
    }

    fn gen_stats(&self) -> Vec<i32> {
        let mut stats: Vec<i32> = Vec::new();
        let mut rand = RandomNumberGenerator::new_gd();

        for _ in 0..6 {
            let mut numbers = Vec::new();

            for _ in 0..4 {
                numbers.push(rand.randi_range(1, 6));
            }

            numbers.sort();
            numbers.remove(0);
            stats.push(numbers.iter().fold(0, |acc, x| acc + x));
        }

        stats.sort();
        stats = stats.iter().rev().map(|val| *val).collect();
        stats.to_owned()
    }
}

#[derive(GodotClass)]
#[class(base=ItemList, init)]
pub struct CharCreatorA5EItemList {
    base: Base<ItemList>,
    #[export]
    use_tooltip: bool
}

#[godot_api]
impl IItemList for CharCreatorA5EItemList {
    fn ready(&mut self) {
        let item_num = self.base().get_item_count();

        for i in 0..item_num {
            let item_text = self.base().get_item_text(i);
            let translated_text = self.base().tr_n(item_text.clone().into(), item_text.into(), 1);
            self.base_mut().set_item_text(i, translated_text);
        }
    }
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