use godot::prelude::*;

pub struct Gift {
    pub name: String,
    pub features: Vec<GiftFeature>
}

impl From<Variant> for Gift {
    fn from(value: Variant) -> Self {
        let valdic: Dictionary = value.to();
        let name: GString = valdic.get("name").unwrap().to();
        let featureval: Vec<Variant> = valdic.get("features").unwrap().to();
        let features: Vec<GiftFeature> = featureval.iter().map(|val| GiftFeature::from(val.clone())).collect();

        Self {
            name: name.to_string(),
            features
        }
    }
}

pub struct GiftFeature {
    pub name: String,
    pub desc: String
}

impl From<Variant> for GiftFeature {
    fn from(value: Variant) -> Self {
        let valdic: Dictionary = value.to();
        let name: GString = valdic.get("name").unwrap().to();
        let desc: GString = valdic.get("desc").unwrap().to();

        Self {
            name: name.to_string(),
            desc: desc.to_string()
        }
    }
}