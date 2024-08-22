use godot::prelude::*;

#[derive(Clone)]
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

impl Gift {
    pub fn get_features_as_gstring(&self) -> GString {
        let s = serde_json::to_string(&self.features).unwrap();
        s.into()
    }

    pub fn get_features_from_gstring(features: GString) -> Vec<GiftFeature> {
        serde_json::from_str(features.to_string().as_ref()).unwrap()
    }
}

#[derive(serde::Serialize, serde::Deserialize, Clone)]
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