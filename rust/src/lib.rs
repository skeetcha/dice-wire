use godot::prelude::*;

mod a5e;
mod pf2e;
mod utils;

struct Varhaven {}

#[gdextension]
unsafe impl ExtensionLibrary for Varhaven {}