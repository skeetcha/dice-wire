use godot::{classes::{ILabel, Label, Object, RichTextLabel, VBoxContainer}, prelude::*};

#[derive(GodotClass)]
#[class(base=Label)]
pub struct TooltipLabel {
    base: Base<Label>
}

#[godot_api]
impl ILabel for TooltipLabel {
    fn init(base: Base<Label>) -> Self {
        Self {
            base
        }
    }

    fn make_custom_tooltip(&self, for_text: GString) -> Option<Gd<Object>> {
        let scene = load::<PackedScene>("res://tooltip/tooltip.tscn").instantiate_as::<VBoxContainer>();
        scene.get_node_as::<RichTextLabel>(GString::from("Body")).set_text(for_text);
        Some(scene.upcast())
    }
}