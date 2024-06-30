extends Control

var heritage: int = 0
var culture: int = 0
var class_val: int = 0
var background: int = 0
var panel: int = 0

signal class_changed(idx: int)
signal heritage_changed(idx: int)
signal background_changed(idx: int)
signal culture_changed(idx: int)

var heritage_features: Dictionary = {
	"dragonborn": [
		{
			"name": "Speed",
			"desc": "Your walking speed is 30 feet."
		},
		{
			"name": "Dragon Breath",
			"desc": "You can use your dragon breath as an action.\nChoose the type of damage dealt by your breath weapon from the following list: acid, cold, fire, force, lightning, necrotic, poison, psychic, radiant, or thunder.\nAdditionally, choose between a 30-foot line that is 5 feet wide or a 15-foot cone for the area that your breath weapon affects. Each creature in the breath's area makes a Dexterity saving throw. If your breath weapon deals psychic damage, a Wisdom saving throw is made instead of Dexterity; if cold, necrotic, poison, radiant, or thunder, a Constitution saving throw. The DC is 8 + your Constitution modifier + your proficiency bonus.\nA creature takes 2d6 damage on a failed saving throw, or half damage on a success. The damage increases to 3d6 at 4th level, 4d6 at 9th level, 5d6 at 14th level, and 6d6 at 19th level.\nAfter you use your dragon breath, you can't use it again until you finish a rest."
		}
	],
	"dwarf": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 25 feet. Your Speed is not reduced by wearing heavy armor or wielding tower shields."
		},
		{
			"name": "Darkvision",
			"desc": "You have darkvision to 60 feet."
		},
		{
			"name": "Creator's Blessing",
			"desc": "You gain proficiency with one set of artisan's tools (either brewer's supplies or mason's tools) or smith's tools. During a long rest, you can use these tools for crafting instead of sleeping and still receive the full benefits of the long rest."
		},
		{
			"name": "Tough",
			"desc": "Your character level is added to your hit point maximum."
		}
	],
	"elf": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 30 feet."
		},
		{
			"name": "Darkvision",
			"desc": "You have darkvision to 60 feet."
		},
		{
			"name": "Fey Ancestry",
			"desc": "You gain an expertise die on saving throws against being charmed, and you are immune to magical effects that would put you to sleep."
		},
		{
			"name": "Trance",
			"desc": "Instead of sleeping, elves enter a trance state. When you take a long rest, you spend 4 hours in your trance state (instead of sleeping for 6 hours). During the trance you suffer no penalty to passive Perception. A long rest remains 8 hours for you as normal, and the remainder of the time must be filled only with light activity."
		}
	],
	"gnome": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 25 feet."
		},
		{
			"name": "Darkvision",
			"desc": "You have darkvision to 60 feet."
		},
		{
			"name": "Gnome Cunning",
			"desc": "You gain an expertise die on Intelligence, Wisdom, and Charisma saving throws made against spells and magical effects."
		},
		{
			"name": "Gnomish Magic",
			"desc": "You know the [i]minor illusion[/i] cantrip. Your spellcasting ability for this spell is Intelligence, Wisdom, or Charisma (whichever is highest)."
		}
	],
	"halfling": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 25 feet."
		},
		{
			"name": "Fearless",
			"desc": "You are immune to the effects of the frightened condition."
		},
		{
			"name": "Nimble Steps",
			"desc": "If a creature is at least one size larger than you, you can move through its space."
		},
		{
			"name": "Halfling's Luck",
			"desc": "When you make an ability check, attack roll, or saving throw and roll a 1, you can choose to roll again, taking the second result."
		}
	],
	"human": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 30 feet."
		},
		{
			"name": "Fast Learner",
			"desc": "You gain proficiency in one additional skill of your choice. In addition, you require half as much time as normal to train yourself in the use of a suit of armor, tool, or weapon during downtime."
		},
		{
			"name": "Intrepid",
			"desc": "Once between rests, when you make an ability check, attack roll, or saving throw, you can choose to gain an expertise die on that roll."
		}
	],
	"orc": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 30 feet."
		},
		{
			"name": "Darkvision",
			"desc": "You have darkvision to 60 feet."
		},
		{
			"name": "Heavy Lifter",
			"desc": "When determining your carrying capacity and the weight that you can push, drag, or lift, your size is considered to be Large."
		},
		{
			"name": "Mighty Attacks",
			"desc": "When you critically hit with a melee weapon attack, roll one of the weapon's damage dice again and add the result to the attack's damage."
		}
	],
	"planetouched": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 30 feet."
		},
		{
			"name": "Darkvision",
			"desc": "You have darkvision to 60 feet."
		},
		{
			"name": "Immortal Blessing",
			"desc": "Once between long rests, when damage would reduce you to 0 hit points, you are instead reduced to 1 hit point."
		}
	]
}

var heritage_gifts: Dictionary = {
	"dragonborn": [
		{
			"name": "Draconic Armor",
			"features": [
				{
					"name": "Claws",
					"desc": "You grow retractable claws from the tips of your fingers. Extending or retracting the claws requires no action. The claws are natural weapons, which you can use to make unarmed strikes that deal slashing damage equal to 1d4 + your Strength modifier."
				}
			]
		},
		{
			"name": "Draconic Fins",
			"features": [
				{
					"name": "Swimmer",
					"desc": "You have a swimming speed of 30 feet and you can hold your breath for up to 15 minutes at a time."
				},
				{
					"name": "Deep Darkvision",
					"desc": "You have darkvision to 60 feet. In addition, your eyes are perfectly adapted for spotting movement at depth, and the radius of your darkvision increases to 120 feet while underwater."
				},
				{
					"name": "Hard to Hit",
					"desc": "While you aren't wearing armor or your only armor is a shield, your AC is 12 + your Dexterity modifier."
				}
			]
		},
		{
			"name": "Draconic Wings",
			"features": [
				{
					"name": "Flight",
					"desc": "You have a fly speed of 30 feet. To use this speed, you can't be wearing medium or heavy armor. Whenever you spend 3 full consecutive rounds airborne without landing, you gain a level of fatigue. Any fatigue gained in this way is removed upon finishing a rest."
				}
			]
		}
	],
	"dwarf": [
		{
			"name": "Dwarven Stability",
			"features": [
				{
					"name": "Dwarven Stability",
					"desc": "You gain an expertise die on saving throws against effects that would knock you prone, and on saving throws made to resist being shoved."
				}
			]
		},
		{
			"name": "Dwarven Toughness",
			"features": [
				{
					"name": "Dwarven Toughness",
					"desc": "As a bonus action, you gain a number of temporary hit points equal to 1d10 plus your level. These temporary hit points last for 1 minute. You can't use this trait again until after you finish a long rest.\nYou gain an expertise die on saving throws against poison, and you have resistance against poison damage."
				}
			]
		}
	],
	"elf": [
		{
			"name": "Mystic Rapport",
			"features": [
				{
					"name": "Arcane Sensitivity",
					"desc": "You gain proficiency with Arcana."
				},
				{
					"name": "Arcane Empathy",
					"desc": "You can speak telepathically to a creature within 30 feet of you that you can see. Though this grants the creature no ability to respond telepathically, they can understand you if you share a language. You can speak in this way to one creature at a time."
				}
			]
		},
		{
			"name": "Prescient Vision",
			"features": [
				{
					"name": "Glance the Future",
					"desc": "Your eyes can see a few moments into the future, and your mind apprehends the divergent possibilities. Once between rests you can use a bonus action to roll a d20 and record the result. Before the end of your next rest, when a creature you can see within 60 feet makes an ability check, attack roll, or saving throw, you can use your reaction to replace their roll with your recorded result. When the creature is also rolling an expertise die, only the d20 roll is replaced. When the creature is rolling more than one d20, such as when it has advantage or when a halfling is using their Halfling's Luck trait, the replacement applies to the creature's final roll."
				}
			]
		},
		{
			"name": "Preternatural Awareness",
			"features": [
				{
					"name": "Keen Senses",
					"desc": "You gain proficiency in Perception."
				},
				{
					"name": "Prophetic Instincts",
					"desc": "Your ability to detect danger is nearly supernatural. You gain a bonus to initiative rolls equal to your Wisdom modifier (minumum 1), and you can't be surprised while conscious (including during your Trance)."
				}
			]
		}
	],
	"gnome": [
		{
			"name": "Gnomish Agility",
			"features": [
				{
					"name": "Gnomish Agility",
					"desc": "You gain +1 to your Armor Class against creatures of a size category larger than your own."
				}
			]
		},
		{
			"name": "Into Mist",
			"features": [
				{
					"name": "Into Mist",
					"desc": "Once between rests, as a bonus action or as a reaction immediately after taking damage, you can turn invisible. The invisibility lasts until the end of your next turn, and it ends early if you attack, deal damage, or cast a spell."
				}
			]
		}
	],
	"halfling": [
		{
			"name": "Burrowing Claws",
			"features": [
				{
					"name": "Burrow",
					"desc": "You have a burrowing speed of 10 feet. You can use your burrowing speed to move through nonmagical sand, loose earth, loamy soil, mud, or snow, but not solid rock. You do not naturally leave any sort of tunnel behind but you can attempt to create a 5-foot by 5-foot wide tunnel in earth, soil, or snow by spending extra time and effort shoring it up and adding support. This reduces your burrowing speed to 5 feet every 15 minutes."
				},
				{
					"name": "Claws",
					"desc": "Your nails grow into strong shovel-like claws. The claws are natural weapons, which you can use to make unarmed strikes that deal slashing damage equal to 1d4 + your Strength modifier."
				}
			]
		},
		{
			"name": "Tuft Feet",
			"features": [
				{
					"name": "Big Feet",
					"desc": "You gain an expertise die on checks and saving throws made to resist being knocked prone."
				},
				{
					"name": "Thick Soles",
					"desc": "You are immune to damage from sharp terrain hazards (such as caltrops, broken glass, or the [i]spike growth[/i] spell) and ignore difficult terrain caused by them. Additionally, other kinds of difficult terrain reduce your movement speed by 5 feet instead of halving it."
				}
			]
		},
		{
			"name": "Twilight-Touched",
			"features": [
				{
					"name": "Darkvision",
					"desc": "You have darkvision to 60 feet."
				},
				{
					"name": "Telepathy",
					"desc": "You can speak telepathically to a creature within 30 feet of you that you can see. Though this grants the creature no ability to respond telepathically, they can understand you if you share a language. You can speak in this way to one creature at a time."
				}
			]
		}
	],
	"human": [
		{
			"name": "Diehard Survivor",
			"features": [
				{
					"name": "Feast and Famine",
					"desc": "You can go a number of days equal to your Constitution modifier without suffering any fatigue from lack of Supply. Afterwards you require twice as much Supply for as many days as you went without."
				},
				{
					"name": "Radical Perserverance",
					"desc": "You only die after failing 4 death saving throws instead of 3."
				}
			]
		},
		{
			"name": "Ingenious Focus",
			"features": [
				{
					"name": "Inexorable Concentration",
					"desc": "When you fail a Constitution saving throw to maintain concentration, you can immediately reroll it, taking the new result. You may use this trait a number of times equal to your Intelligence modifier (minimum 1), and regain all expended uses after a long rest."
				},
				{
					"name": "Resident Expert",
					"desc": "Choose two tools with which you are proficient, or a skill with which you are proficient from Animal Handling, Arcana, Culture, Engineering, History, Medicine, Nature, or Religion. When you make a check with that tool or skill and the d20 shows a natural result of less than 10, you can count the d20 result as being 10."
				}
			]
		},
		{
			"name": "Spirited Traveler",
			"features": [
				{
					"name": "Desperate Dash",
					"desc": "Once between rests, when you take the Dash action, your movement this turn does not provoke opportunity attacks. During this movement, you gain an expertise die on Acrobatics checks made to avoid hazards and Dexterity saving throws."
				},
				{
					"name": "Marathon Runner",
					"desc": "The first time between each long rest you would gain a level of fatigue, you do not gain that level of fatigue. You still suffer a level of fatigue from finishing a long rest without any Supply."
				}
			]
		}
	],
	"orc": [
		{
			"name": "Just Like Home",
			"features": [
				{
					"name": "Just Like Home",
					"desc": "Choose one type of terrain, reflecting the area from which your family hails: arctic, desert, mountain, or swamp. You ignore all naturally created difficult terrain of that type. Additionally, you gain an expertise die on Survival checks made within this terrain type, and gain a type of damage resistance related to your chosen terrain: arctic—cold, desert—fire, mountain—lightning, swamp—poison."
				}
			]
		},
		{
			"name": "Ancestral Blessing",
			"features": [
				{
					"name": "Divine Protection",
					"desc": "You have resistance to radiant damage."
				},
				{
					"name": "Touch of Divinity",
					"desc": "You know the [i]resistance[/i] cantrip. In addition, you can cast the [i]shield[/i] spell once per long rest."
				}
			]
		},
		{
			"name": "Magic Adept",
			"features": [
				{
					"name": "Magic Adept",
					"desc": "You are born with magic coursing through your veins, and are able to utilize it in a number of ways. You learn one cantrip of your choice from the wizard spell list. At 3rd level, choose one 1st- or 2nd-level spell from the wizard spell list. Once between long rests, you can cast the chosen spell without any material components. A 1st-level spell chosen this way can be cast at 2nd-level using this trait, if the spell allows. Your spellcasting ability for this trait is the same as the ability score used in the spellcasting class in which you have the highest level, or Charisma if you have no levels in a spellcasting class."
				}
			]
		}
	],
	"planetouched": [
		{
			"name": "Aasimar",
			"features": [
				{
					"name": "Celestial Legacy",
					"desc": "You know the [i]guidance[/i] cantrip. In addition, once between long rests you can use an action to touch a willing creature and restore a number of hit points equal to your level."
				},
				{
					"name": "Divine Protection",
					"desc": "You have resistance to radiant damage."
				},
				{
					"name": "Language",
					"desc": "You have an innate ability to recognize Celestial, and are able to speak, read, write, and sign it."
				}
			]
		},
		{
			"name": "Tiefling",
			"features": [
				{
					"name": "Hellish Resistance",
					"desc": "You have resistance to fire damage."
				},
				{
					"name": "Infernal Legacy",
					"desc": "You know the [i]produce flame[/i] cantrip. Once you reach 3rd level, you can cast [i]arcane riposte[/i] (fire damage only) once between long rests. At 5th level, you can cast [i]heat metal[/i] without material components once between long rests. Charisma is your spellcasting ability for these spells."
				}
			]
		}
	]
}

var culture_features: Dictionary = {
	"caravanner": [
		{
			"name": "Caravanner",
			"desc": "You are proficient in Animal Handling and with land vehicles."
		},
		{
			"name": "Long Hauler",
			"desc": "You have proficiency in Survival. In addition, you have advantage on checks made to avoid fatigue from a forced march."
		},
		{
			"name": "Mobile Living",
			"desc": "You can create a ramshackle version of a cart or wagon with 30 minutes of work if you have access to raw or reclaimed materials. Ramshackle vehicles created in this way function identically to their normal counterparts, except their gold piece value is always 0, they have half as many hit points as their normal counterparts, and they break and become useless if they are hit by any attack roll with a result of natural 20."
		},
		{
			"name": "Trampling Charge",
			"desc": "When you or a mount you're riding uses the Dash action or a vehicle you're driving uses the Ahead Full action, you can move through spaces occupied by creatures with a size category smaller than you, or your mount, or the vehicle. Creatures moved through in this way make a Dexterity saving throw (DC equal to 8 + your Dexterity modifier + your proficiency bonus). On a failed save, creatures are knocked prone and take an amount of bludgeoning damage equal to your level. Creatures cannot be damaged twice from the same trampling charge. Once you use this trait, you cannot do so again until you finish a short or rest."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and one other language."
		}
	],
	"circusfolk": [
		{
			"name": "Rapid Escape",
			"desc": "You can use the Disengage action as a bonus action."
		},
		{
			"name": "Slapstick",
			"desc": "You are proficient with improvised weapons, and improvised weapons you use can deal 1d6 damage rather than the damage they normally deal. You can use Dexterity instead of Strength for the attack and damage rolls of your improvised weapons."
		},
		{
			"name": "Trickster's Veil",
			"desc": "You can cast [i]disguise self[/i] once per rest. Your spellcasting ability for this spell is Intelligence, Wisdom, or Charisma (whichever is highest)."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common."
		}
	],
	"collegiate": [
		{
			"name": "Philosophic Mind",
			"desc": "Once between rests, at the start of your turn you can suppress the effects of an enchantment spell you are under for 1 round as your logic overrides it."
		},
		{
			"name": "Practiced Artisan",
			"desc": "You are proficient with calligrapher's supplies and two other artisan's tools."
		},
		{
			"name": "Studied Discipline",
			"desc": "You have extensive knowledge in certain fields. For all skill proficiencies gained through this trait, you always choose which ability score to use for these rolls (Intelligence, Wisdom, or Charisma)."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and three additional languages."
		}
	],
	"cosmopolitan": [
		{
			"name": "Discreetly Armed",
			"desc": "You gain an expertise die on checks made to persuade others to let you remain armed or to conceal weapons or items about your person."
		},
		{
			"name": "Fashion Sense",
			"desc": "After you spend at least 1 minute observing a creature within 60 feet, you can use an action to make either an Insight or History check against a DC equal to the creature's passive Deception check score. On a success, you learn the following information about that creature:\n\n[ul bullet=*]* Whether the creature has a lower Charisma score than yourself.\n* The creature's culture and national origin (if any).\n* The creature's social standing in the local majority culture.[/ul]"
		},
		{
			"name": "Skill Versatility",
			"desc": "You gain proficiency in Culture and one other skill of your choice."
		},
		{
			"name": "Urban Denizen",
			"desc": "You can make an Investigation check to learn the location of (or at the Narrator's discretion gain a helpful clue to the trail of) a person by discreetly asking around in the right places. The difficulty of the check is DC 15 if the individual is not hiding, or DC 20 if they are trying to conceal their location."
		},
		{
			"name": "Well-Connected",
			"desc": "You gain an extra connection, selected from a background of your choice. This person is of a different heritage or national origin than yourself."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign in Common and two additional languages."
		}
	],
	"deepdwarf": [
		{
			"name": "Superior Darkvision",
			"desc": "You have darkvision to 60 feet, or the range of your existing darkvision increases by 60 feet."
		},
		{
			"name": "Deep Magic",
			"desc": "You know the [i]resistance[/i] cantrip. Once you reach 3rd level, you can cast [i]jump[/i] once per rest. At 5th level, you can cast [i]enlarge/reduce[/i] once per rest. You don't need material components for these spells, but you can't cast them while you're in direct sunlight (although sunlight has no effect on them once cast). Intelligence is your spellcasting ability for these spells."
		},
		{
			"name": "Deep Suspicion",
			"desc": "You gain an expertise die on Wisdom saving throws against illusions and against being charmed or frightened."
		},
		{
			"name": "Underground Combat Training",
			"desc": "You are proficient with hand crossbows, short swords, and war picks."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common, Dwarvish, and Undercommon."
		}
	],
	"deepgnome": [
		{
			"name": "Superior Darkvision",
			"desc": "You have darkvision to 60 feet, or the range of your existing darkvision increases by 60 feet."
		},
		{
			"name": "Dark Gnome Magic",
			"desc": "You can cast [i]disguise self[/i] once per rest. Once you reach 3rd level, you can cast [i]blindness/deafness[/i] (blindness only) once per rest. At 5th level, you can cast [i]nondetection[/i] once per rest. You don't need material components for these spells, and when casting them your spellcasting ability is Intelligence, Wisdom, or Charisma (whichever is highest)."
		},
		{
			"name": "Subterranean Camouflage",
			"desc": "You gain an expertise die on Stealth checks made to hide in rocky terrain."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common, Gnomish, and Undercommon."
		}
	],
	"dragonbound": [
		{
			"name": "Draconic Diplomacy",
			"desc": "You gain an expertise die on Charisma checks made to influence dragon creatures."
		},
		{
			"name": "Dragonbound Teachings",
			"desc": "You know one cantrip of your choice from the cleric or wizard spell lists. Your spellcasting ability for this cantrip is Intelligence or Wisdom (whichever is highest)."
		},
		{
			"name": "Progenitor's Boon",
			"desc": "Choose a type of boon.\n\n[b]Chromatic Dragon's Boon[/b]\nYou can cast [i]fear[/i] without the need for material components once per rest. Until you reach 5th level, the area of this casting of the spell is limited to a 15-foot cone. Your spellcasting ability for this spell is Charisma.\n\n[b]Essence Dragon's Boon[/b]\nYou know the [i]druidcraft[/i] cantrip. In addition, your diplomatic understanding extends towards the creatures of the land and the spirits within it. You gain an expertise die on Charisma checks made to influence beast and celestial creatures.\n\n[b]Gem Dragon's Boon[/b]\nYou know the [i]message[/i] cantrip. Once you reach 3rd level, you can cast [i]illusory script[/i] once per rest. At 5th level, you can cast [i]invisibility[/i] once per rest. You don't need material components for these spells, and when casting them your spellcasting ability is Intelligence or Charisma (whichever is highest).\n\n[b]Metallic Dragon's Boon[/b]\nChoose a skill from among Arcana, History, Medicine, Nature, or Religion. You have proficiency in the chosen skill and you gain an expertise die on ability checks you make using it."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and Draconic."
		}
	],
	"dragoncult": [
		{
			"name": "Draconic Umbra",
			"desc": "As a bonus action, you can cause draconic power to course around you in a draconic umbra. This draconic umbra lasts for 1 minute or until you use a bonus action to end it. Once you have used this trait, you cannot use it again until after you finish a rest."
		},
		{
			"name": "Secrets of the Wyrm",
			"desc": "Choose two skills from among Arcana, Deception, Persuasion, Religion, or Stealth. You have proficiency in the chosen skills."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and Draconic."
		}
	],
	"eladrin": [
		{
			"name": "Eladrin Weapon Training",
			"desc": "You have proficiency with longswords and rapiers."
		},
		{
			"name": "Fey Sublimation",
			"desc": "In addition to being humanoid, you also have the fey creature type."
		},
		{
			"name": "Invocation of the Eladrin Lords",
			"desc": "You know one cantrip based on the aspect of nature you wish to manifest or that of your liege. Your spellcasting ability for this cantrip is Intelligence, Wisdom, or Charisma (whichever is highest).\nAt the end of a rest, you can change your selected aspect.\n\n[b]Autumn[/b]: [i]resistance[/i]\n[b]Hiding[/b]: [i]minor illusion[/i]\n[b]Respite[/b]: [i]mending[/i]\n[b]Rot[/b]: [i]chill touch[/i]\n[b]Spring[/b]: [i]druidcraft[/i]\n[b]Stars[/b]: [i]dancing lights[/i]\n[b]Storm[/b]: [i]shocking grasp[/i]\n[b]Summer[/b]: [i]produce flame[/i]\n[b]Toxicity[/b]: [i]pestilence[/i]\n[b]Winter[/b]: [i]ray of frost[/i]"
		},
		{
			"name": "Knowledge of the Faerie Courts",
			"desc": "You are proficient in one of the following skills: Arcana, Culture, Deception, History, Insight, Persuasion, Survival."
		},
		{
			"name": "Twilight Step",
			"desc": "You can forego your movement on your turn to teleport 30 feet to an unoccupied space you can see. Once you have used this trait, you cannot do so again until you finish a rest."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign in Common, Elvish, and Sylvan."
		}
	],
	"forestgnome": [
		{
			"name": "Artistic Pursuits",
			"desc": "You have proficiency with one type of artisans' tools of your choice."
		},
		{
			"name": "Natural Illusionist",
			"desc": "You can cast [i]disguise self[/i] once per rest. Once you reach 3rd level, you can cast [i]blur[/i] once per rest. At 5th level, you can cast [i]major image[/i] once per rest. You don't need material components for these spells, and when casting them your spellcasting ability is Intelligence or Wisdom (whichever is higher)."
		},
		{
			"name": "Small Beast Speech",
			"desc": "You have an innate ability to communicate simple thoughts and ideas with beasts of size Small or smaller."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and Gnomish."
		}
	],
	"forgottenfolx": [
		{
			"name": "Eyes Everywhere",
			"desc": "As long as an ally is within 60 feet of you, you always know their general location even if you cannot see or otherwise sense them. This effect is blocked by 1 foot of lead or iron and magical effects like the [i]nondetection[/i] spell."
		},
		{
			"name": "It Takes a Village",
			"desc": "You can use the Help action as a bonus action. Additionally, when you do so, the range at which you can Help an ally increases to 15 feet. Once per rest when you Help an ally, in addition to granting advantage you may also choose for your ally to gain an expertise die."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common, Gnomish, and one other language."
		}
	],
	"forsaken": [
		{
			"name": "Eat Like a Bird",
			"desc": "You can go a number of days equal to half your Constitution modifier without suffering any fatigue from lack of Supply."
		},
		{
			"name": "Fleet of Foot",
			"desc": "Your Speed increases by 5 feet."
		},
		{
			"name": "Improvised Tools",
			"desc": "During a rest, when you have access to raw materials you can jury-rig an improvised tool kit. If you roll a 1 while making a check using the improvised tools or the next time you take a rest, they break."
		},
		{
			"name": "Pack Rat",
			"desc": "You count as one size larger when determining your carrying capacity."
		},
		{
			"name": "Roll With the Punches",
			"desc": "After you fail an ability check, you have advantage on your next ability check. You can't use this trait again until you finish a short or rest."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common, and two additional languages."
		}
	],
	"godbound": [
		{
			"name": "Arts of Worship",
			"desc": "You are proficient with your choice of either Performance, two musical instruments, or two artisan's tools."
		},
		{
			"name": "Bonus Connection",
			"desc": "You have one additional connection, selected from the Acolyte background."
		},
		{
			"name": "Detect Faith",
			"desc": "After you speak with a person for at least 1 minute, you can use an action to make either an Insight or Religion check opposed by their Deception check. On a success, you learn the following information about them:\n[ul bullet=*]* Whether they have a lower Wisdom score than yourself.\n* Whether they are religious; if so, you also learn their faith.\n* Whether they have class levels in the cleric or herald class.[/ul]"
		},
		{
			"name": "Devotion",
			"desc": "You gain an expertise die on saving throws made to resist being charmed or frightened."
		},
		{
			"name": "Religious Education",
			"desc": "You are proficient in the Religion skill and know one cantrip of your choice from the cleric, druid, or herald spell list. Your spellcasting ability score for this cantrip is Intelligence, Wisdom, or Charisma (whichever is highest)."
		},
		{
			"name": "Siblings in Faith",
			"desc": "You have advantage on checks made to socially interact with members of your current or former faith, such as when requesting services or gathering information."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign in Common and one other language."
		}
	],
	"highelf": [
		{
			"name": "Cunning Diplomat",
			"desc": "You can always choose to use Intelligence when making a Deception, Insight, Intimidation, or Persuasion check."
		},
		{
			"name": "High Elf Education",
			"desc": "You are proficient in Culture and one additional skill of your choice."
		},
		{
			"name": "High Elf Weapon Training",
			"desc": "You have proficiency with rapiers and longswords."
		},
		{
			"name": "Magical Versatility",
			"desc": "You know a cantrip of your choice, which can be chosen from any spell list. Your spellcasting ability score for this cantrip is Intelligence, Wisdom, or Charisma (whichever is highest)."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign in Common, Elvish, and one other language."
		}
	],
	"hilldwarf": [
		{
			"name": "Community Magic",
			"desc": "You know the [i]friends[/i] cantrip. Once you reach 3rd level, you can cast [i]charm person[/i] once per rest. At 5th level, you can cast [i]suggestion[/i] once per rest. You don't need material components for these spells, and when casting them your spellcasting ability is Charisma."
		},
		{
			"name": "Friendly",
			"desc": "You are proficient in either Deception or Persuasion."
		},
		{
			"name": "Wagoner",
			"desc": "You are either proficient in either Animal Handling or with land vehicles."
		},
		{
			"name": "Ways of the Land",
			"desc": "You are proficient in Survival and gain an expertise die on checks using it."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common, Dwarvish, and two additional languages."
		}
	],
	"imperial": [
		{
			"name": "Conscript",
			"desc": "You are proficient with light armor, spears, and light crossbows."
		},
		{
			"name": "Learned Teachers",
			"desc": "You gain proficiency in History and one other skill of your choice."
		},
		{
			"name": "Local Healers",
			"desc": "Whenever your hit point maximum or one of your ability scores would be reduced, it is reduced by half as much instead (minimum 1)."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and one other language."
		}
	],
	"itinerant": [
		{
			"name": "Blending In",
			"desc": "You gain proficiency with the disguise kit."
		},
		{
			"name": "Conscientious Socializer",
			"desc": "The first time you interact with strangers in an unfamiliar land or region, you gain an expertise die to the first Charisma check you make. This trait does not work on groups if at least one person in a group knows you."
		},
		{
			"name": "I Know Someone",
			"desc": "You gain one additional connection, which you can choose from any background other than your own."
		},
		{
			"name": "Many Cultures",
			"desc": "You gain proficiency in Culture. In addition, choose Intelligence or Wisdom. You gain an expertise die on ability checks using the chosen ability score that are made to understand the social customs of, interact with, or recall knowledge about individuals, objects, or environments associated with any culture or society you have been surrounded by for a month or longer."
		},
		{
			"name": "Motive and Reason",
			"desc": "Choose one of the following:\n\n[b]Homeland Seeker[/b]\nYou gain proficiency in Arcana and History.\n\n[b]Labor Migrant[/b]\nYou are proficient with a set of artisan's tools and one skill of your choice.\n\n[b]Shadow Exile[/b]\nYou are proficient in Deception or Stealth. If you pick Stealth, once between rests you can make a Stealth check to replace a Perception check. If you pick Deception, once between rests you can make a Deception check to replace an Insight check.\n\n[b]Refugee[/b]\nYou are proficient in Survival, and when in an urban environment can roll Survival checks when using Intimidation or Persuasion."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and three additional languages."
		}
	],
	"kithbainhalfling": [
		{
			"name": "Superior Darkvision",
			"desc": "You have darkvision to 60 feet, or the range of your existing darkvision increases by 60 feet."
		},
		{
			"name": "Sunlight Sensitivity",
			"desc": "You have disadvantage on attack rolls and on Perception checks that rely on sight when you, the target of your attack, or whatever you are trying to perceive is in direct sunlight."
		},
		{
			"name": "The Ken",
			"desc": "You can cast [i]telepathic bond[/i] without the need for material components once per rest."
		},
		{
			"name": "Without Secrets",
			"desc": "You are proficient in Insight, and you gain an expertise die on checks made with it."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common, Halfling, and Sylvan."
		}
	],
	"lonewanderer": [
		{
			"name": "Culture of My Own",
			"desc": "You gain four skill or tool proficiencies of your choice."
		},
		{
			"name": "Heirloom",
			"desc": "Choose one weapon worth 100 gold or less. You begin play with a masterwork version of that weapon."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and two additional languages."
		}
	],
	"mountaindwarf": [
		{
			"name": "Dwarven Weapon Training",
			"desc": "You have proficiency with the battleaxe, handaxe, light hammer, and warhammer."
		},
		{
			"name": "Dwarven Armor Training",
			"desc": "You have proficiency with light and medium armor."
		},
		{
			"name": "Heart of the Forge",
			"desc": "You have resistance to fire damage. In addition, you have proficiency in Engineering."
		},
		{
			"name": "Mountain Born",
			"desc": "You're acclimated to high and low altitudes, including elevations above 20,000 feet or depths below 20,000 feet. You're also naturally adapted to cold climates."
		},
		{
			"name": "Stonecunning",
			"desc": "Whenever you make a History check related to the origin of stonework, you are considered proficient in the History skill and gain an expertise die."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common, Dwarvish, and one other language."
		}
	],
	"mustbairnhalfling": [
		{
			"name": "Child of the Soil",
			"desc": "You ignore difficult terrain caused by any form of earth or soil, such as mud, or mountainous terrain. In addition, you know the [i]druidcraft[/i] cantrip."
		},
		{
			"name": "Earthspeak",
			"desc": "You can attempt to divine the earth's wisdom (as the [i]augury[/i] spell) by submerging your feet or hands into mud or soil. You can't use this trait again until after you finish a rest."
		},
		{
			"name": "Wild and Unshackled",
			"desc": "You have the Chaotic alignment for the purposes of any spell or ability that would detect or affect Chaotic creatures. In addition, you gain proficiency in two of the following skills: Acrobatics, Animal Handling, Nature, Religion, or Survival."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common, Halfling, and Terran."
		}
	],
	"nomad": [
		{
			"name": "Nature Minded",
			"desc": "You are proficient in Animal Handling and Survival, and either Medicine, Nature, or Perception."
		},
		{
			"name": "On the Road Again",
			"desc": "You are proficient with land vehicles and tinker's tools. You can use tinker's tools to repair a land vehicle you have travelled in for at least 1 month, and gain an expertise die on any checks made to do so. Additionally, you gain an expertise die on checks made to control or navigate a land vehicle."
		},
		{
			"name": "Sense Weather",
			"desc": "After observing an outside area for 1 minute, you can predict the weather within the next 24 hours. You cannot foresee magical changes, but you can use an action to make an Insight or Perception check to notice them."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and two additional languages."
		}
	],
	"settler": [
		{
			"name": "Claim Staker",
			"desc": "Whenever you begin a rest, you can choose to spend the first hour of that rest making the area into a fortified position for the duration. While resting in a fortified position, the ground in a 60-foot radius area around you is considered difficult terrain for any creatures other than those you consider allies. In addition, the first time a hidden creature enters the fortified area, it makes a Dexterity saving throw (DC 8 + your Wisdom modifier + your proficiency bonus). On a failed save, the creature inadvertently makes loud noises and is no longer hidden."
		},
		{
			"name": "Frontier Survival",
			"desc": "You are proficient in the Insight and Survival skills."
		},
		{
			"name": "Strange Forager",
			"desc": "You gain an expertise die on any check made to determine if something is poisonous."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common, and two additional languages."
		}
	],
	"shadowelf": [
		{
			"name": "Superior Darkvision",
			"desc": "You have darkvision to 60 feet, or the range of your existing darkvision increases by 60 feet."
		},
		{
			"name": "Shadow Elf Weapon Training",
			"desc": "You have proficiency with rapiers and hand crossbows."
		},
		{
			"name": "Shadow Lore",
			"desc": "You know a cantrip: either [i]dancing lights[/i] or [i]minor illusion[/i]. Once you reach 3rd level, you can cast [i]faerie fire[/i] once per rest. At 5th level, you can cast [i]darkness[/i] once per rest. You don't need material components for these spells, and when casting them your spellcasting ability is Intelligence, Wisdom, or Charisma (whichever is highest)."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common, Elvish, and Undercommon."
		}
	],
	"steamforged": [
		{
			"name": "Mind Like a Steel Trap",
			"desc": "You have proficiency in either History, Investigation, or Nature, and you gain an expertise die on checks made using the chosen skill."
		},
		{
			"name": "Tech Savvy",
			"desc": "You have proficiency with tinker's tools and Engineering, plus one other artisan's tool of your choice."
		},
		{
			"name": "War Scholar",
			"desc": "Choose one of the following:\n\n[b]Student of Martial Arts[/b]\nWhen you replace an attack or use an action to Disarm, Grapple, Overrun, Shove, or Tumble, you gain an expertise die.\n\n[b]Student of Martial Science[/b]\nChoose one 1st degree combat maneuver from any tradition. You can use this combat maneuver once without spending exertion. You can't use it again until you finish a rest."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign in Common and one other language."
		}
	],
	"stoicorc": [
		{
			"name": "Clarity of Mind",
			"desc": "You have advantage on saving throws made to resist being charmed or frightened."
		},
		{
			"name": "Stoic Traditions",
			"desc": "You gain proficiency in one of the following skills: Arcana, History, Insight, Medicine, Nature, or Religion."
		},
		{
			"name": "Ritualistic Focus",
			"desc": "You know two 1st-level spells of your choice. These spells must have the ritual tag and you may only cast them as rituals. Wisdom is your spellcasting ability for these spells. In addition, you may cast other spells you learn as rituals if those spells have the ritual tag."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and Orc."
		}
	],
	"stoneworthy": [
		{
			"name": "Focused Patience",
			"desc": "Once between rests, you can do one of the following:\n\n[b]Concentrate[/b]\nYou gain an expertise die on a Constitution saving throw made to maintain concentration.\n\n[b]Persist[/b]\nYou may reattempt a failed ability check."
		},
		{
			"name": "Natural Barterer",
			"desc": "When bartering, haggling, or negotiating an exchange of goods, you gain an expertise die on Intimidation and Persuasion checks, and you may always choose which ability score to use for these rolls (Intelligence, Wisdom, or Charisma)."
		},
		{
			"name": "Natural Survivalist",
			"desc": "You gain proficiency in Survival."
		},
		{
			"name": "Temporary Expert",
			"desc": "Each time you gain a level, you may choose to lose proficiency in one skill or tool and gain proficiency in a different skill or tool in its place. You cannot trade a skill proficiency for a tool proficiency, and vice versa."
		},
		{
			"name": "Versatile Crafter",
			"desc": "You may spend 4 hours between rests crafting one non-metal tool or simple weapon, or five pieces of ammunition, provided you have access to the materials needed and the final cost of the items does not exceed 5 gold."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and one other language."
		}
	],
	"stouthalfling": [
		{
			"name": "Borough Cooking",
			"desc": "Whenever you begin a rest, you and up to 6 allies can each consume 1 Supply to partake in your borough cooking, gaining 1d6 temporary hit points."
		},
		{
			"name": "Home Gardening",
			"desc": "You gain proficiency in either Animal Handling or Nature."
		},
		{
			"name": "Memoirist",
			"desc": "You gain proficiency with calligrapher's supplies. In addition, you gain an expertise die on Intelligence checks to recall details about past events you took part in by first checking your journals."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common, Halfling, and one other language."
		}
	],
	"tinkergnome": [
		{
			"name": "Cunning Creative",
			"desc": "You gain proficiency with tinker's tools, Engineering, and either Arcana or History. You gain an expertise die whenever you use them to make a check related to alchemical, magical, or technological items.\nBy spending 1 hour and 10 gold worth of materials, you may build a clockwork device that has an AC of 5 and 1 hit point. The device will cease to function after 24 hours, or if you choose to dismantle it, unless you spend an hour maintaining it. An hour can be spent to repair a device that has ceased to function. You can have up to three devices functioning at a time.\n\n[b]Audiophone[/b]\nWhen started, this device plays a pre-recorded sound at a moderate volume. The device stops playing when it reaches the end of the recording, or when shut off. You can use your action to record any 1 minute of audio, and can use a bonus action to start and shut off the device.\n\n[b]Clockwork Figure[/b]\nThis figure can be a Tiny animal, monster, or even a humanoid. When placed on the ground, you can use a bonus action to direct the figure to march up to 10 feet in a direction of your choice. You can choose to have the figure make a noise that is appropriate to the creature it represents, or to have it be silent. If you choose for the figure to be silent, you can instead equip it with a small flame that sheds dim light 5 feet in front of the figure.\n\n[b]Flame Box[/b]\nWhen a bonus action is used to activate this device it creates a small flame that can be used to light a candle, torch, or campfire. Alternatively, you can use a bonus action to shoot a small ball of fire from the device as a ranged weapon attack with a range of 30 feet, dealing 1d6 + 1 fire damage. You are considered proficient with the flame box. Using the device this way damages it, and it must be repaired over the course of a rest before it can be used again.\n\n[b]Sensor[/b]\nThis device can be attached to a wall or any smooth, sturdy surface. When placed, it begins monitoring the area around it. Choose one sort of activity to monitor: noise or movement. The device detects these things up to 30 feet around it, including through openings, but cannot sense through total cover. The device relays the information back to you telepathically, and can share either clips of sound (limited to 30 seconds at a time, with a minimum of 10 minutes in between relays) or information on the size and number of creatures moving in the area."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common, Gnomish, and one other language."
		}
	],
	"tunnelhalfling": [
		{
			"name": "Fleet of Foot",
			"desc": "Your speed increases by 5 feet."
		},
		{
			"name": "Rebellious Tactics",
			"desc": "You gain proficiency with one of the following skills: Acrobatics, Deception, Nature, or Stealth."
		},
		{
			"name": "Slippery",
			"desc": "When you are grappled, you can use your reaction to automatically escape that grapple. Once you have used this trait, you cannot do so again until you finish a rest."
		},
		{
			"name": "Trained Filcher",
			"desc": "You gain proficiency in Sleight of Hand, and you gain an expertise die when picking a pocket or otherwise taking an item without notice."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and Halfling."
		}
	],
	"tyrannized": [
		{
			"name": "All Hail the Tyrant",
			"desc": "You gain proficiency in either Deception or Intimidation."
		},
		{
			"name": "Defiant Will",
			"desc": "You gain an expertise die on saving throws made to resist being charmed, frightened, paralyzed, poisoned, stunned, or put to sleep."
		},
		{
			"name": "Saving Face",
			"desc": "If you miss with an attack roll or fail an ability check, you can gain a bonus to the roll equal to the number of allies you can see within 30 feet of you (maximum +3), possibly changing a failure into a success. Once you use this trait, you can't use it again until you finish a short or rest."
		},
		{
			"name": "Scars of the Scourge",
			"desc": "Choose either scars or scourge, and then choose one of the following damage types: acid, cold, fire, force, lightning, necrotic, poison, psychic, radiant, or thunder.\n\n[b]Scars[/b]\nYou have resistance to the chosen damage type.\n\n[b]Scourge[/b]\nAs a bonus action, you can enhance the next attack you make this turn. If that attack hits, it deals extra damage of the chosen type equal to your proficiency bonus. However, the sting of the scourge lessens after the initial strike, so after you deal this extra damage to a creature, this trait cannot deal extra damage to it during the same combat."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and one other language."
		}
	],
	"villager": [
		{
			"name": "Farm Life",
			"desc": "You gain proficiency in Animal Handling."
		},
		{
			"name": "Sharpened Tools",
			"desc": "You are proficient with improvised weapons."
		},
		{
			"name": "Tall Tales",
			"desc": "You may always choose to use Wisdom when making History, Nature, or Religion checks. However, the Narrator may decide that the results of a check made in this way are distorted or exaggerated forms of the truth."
		},
		{
			"name": "Village Watch",
			"desc": "You gain an expertise die on Perception checks made while keeping watch during a rest."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, sign, and write Common and one other language."
		}
	],
	"warhordling": [
		{
			"name": "Aggressive",
			"desc": "As a bonus action, you can move up to your Speed towards an enemy that you can see or hear."
		},
		{
			"name": "Menacing",
			"desc": "You gain proficiency in Intimidation."
		},
		{
			"name": "War Horde Weapon Training",
			"desc": "You are proficient with two martial weapons of your choice and with light armor. You are also able to cobble together functional if somewhat ramshackle weapons from whatever you have on hand. You can create a ramshackle version of any simple weapon (except crossbows) with 10 minutes of work if you have access to simple materials such as common household items, the rusted scraps found among battlefields, or the bounty of the forest. Ramshackle weapons created in this way function identically to their normal counterparts, except their gold value is always 0 and they break and become useless if you critically fumble."
		},
		{
			"name": "Wartime Scrounger",
			"desc": "Once per rest, you can spend 4 hours of time to locate Supply for yourself and one other creature while traveling through urban environments, warzones, and battlefields."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and one other language."
		}
	],
	"wildling": [
		{
			"name": "Enhanced Vision",
			"desc": "You gain proficiency in Perception. Choose one of the following.\n\n[b]Nightwalker[/b]\nYou gain an expertise die on Investigation and Perception checks made in moonlight or starlight.\n\n[b]Sunseeing[/b]\nYou gain an expertise die on Investigation and Perception checks made in daylight."
		},
		{
			"name": "Expert Forager",
			"desc": "Once per rest, you can spend 4 hours of time to locate Supply for yourself and one other creature, or magical reagents worth up to 5 gold."
		},
		{
			"name": "Internal Clock",
			"desc": "By observing the environment when on your home plane, you can estimate the time of year down to within a week of the actual date. When you are outdoors, you know the time of day."
		},
		{
			"name": "Living Off The Land",
			"desc": "You gain proficiency in Nature, and can always choose to use Wisdom when making a Nature check. Choose one of the following.\n\n[b]Agriculturalist[/b]\nYou gain an expertise die on Persuasion checks made against farmers, horticulturalists, and those who cultivate for a living, and when making an ability check to use a land vehicle.\n\n[b]Beastwarden[/b]\nWhen you have a hunting animal such as a falcon or hunting dog assisting you, you gain an expertise die on checks made to hunt or track. In addition, you gain an expertise die on Animal Handling checks.\n\n[b]Land Hunter[/b]\nYou gain an expertise die on Intimidation and Stealth checks. Additionally, you can march up to 12 hours before you need to save against fatigue.\n\n[b]Water Drifter[/b]\nYou gain an expertise die when making an ability check to use a water vehicle. In addition, you gain an expertise die on Athletics checks, and you can hold your breath for up to 15 minutes by using an action to prepare to do so."
		},
		{
			"name": "Weather Sense",
			"desc": "Pick a terrain type. After observing the area for 1 minute, you can predict the weather in this terrain within the next 24 hours. You cannot foresee magical changes, but you can use an action to make an Insight or Perception check to notice them. When you have successfully predicted the weather, you gain an expertise die on saving throws made against its effects."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and one other language."
		}
	],
	"woodelf": [
		{
			"name": "Fleet of Foot",
			"desc": "Your Speed increases by 5 feet."
		},
		{
			"name": "Nature's Ally",
			"desc": "You can cast animal friendship without material components once per rest. Your spellcasting ability for this spell is Intelligence, Wisdom, or Charisma (whichever is highest)."
		},
		{
			"name": "Nature's Touch",
			"desc": "Choose one of the following.\n\n[b]Way with Animals[/b]\nYou gain proficiency with Animal Handling and with land vehicles.\n\n[b]Way with Plants[/b]\nYou gain proficiency in Nature and with herbalism kits."
		},
		{
			"name": "Treeborne Scout",
			"desc": "You gain a climb speed equal to your Speed."
		},
		{
			"name": "Wood Elf Weapon Training",
			"desc": "You are proficient with longbows and shortswords."
		},
		{
			"name": "Languages",
			"desc": "You can speak, read, write, and sign Common and Elvish."
		}
	]
}

func heritage_button(toggle: bool, instance: Node):
	var index = instance.get_meta("index", -1)
	var key = instance.get_meta("key", "")
	
	if heritage == 0 and toggle:
		heritage = index
	elif heritage == index and not toggle:
		heritage = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		heritage = index
	
	heritage_changed.emit(heritage)
	features(key, toggle)

func culture_button(toggle: bool, instance: Node):
	var index = instance.get_meta("index", -1)
	var key = instance.get_meta("key", "")
	
	if culture == 0 and toggle:
		culture = index
	elif culture == index and not toggle:
		culture = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		culture = index
	
	cultures(key, toggle)

func class_button(toggle: bool, instance: Node):
	var index = instance.get_meta("index", -1)
	var key = instance.get_meta("key", "")
	
	if class_val == 0 and toggle:
		class_val = index
		$Grid/MiddlePanel/NextButton.visible = true
	elif class_val == index and not toggle:
		class_val = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		class_val = index
	
	class_changed.emit(class_val)

func background_button(toggle: bool, instance: Node):
	var index = instance.get_meta("index", -1)
	var key = instance.get_meta("key", "")
	
	if background == 0 and toggle:
		background = index
		$Grid/MiddlePanel/NextButton.visible = true
	elif background == index and not toggle:
		background = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		background = index
		
	background_changed.emit(background)

func _ready():
	for i in range($Grid/HeritagePanel/VBoxContainer/Grid.get_child_count()):
		$Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).toggled.connect(heritage_button.bind($Grid/HeritagePanel/VBoxContainer/Grid.get_child(i)))
		$Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).set_meta("index", i + 1)
		$Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).set_meta("key", $Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).name.to_lower().replace("button", ""))
	
	for i in range($Grid/CulturePanel/Scroll/Grid.get_child_count()):
		$Grid/CulturePanel/Scroll/Grid.get_child(i).toggled.connect(culture_button.bind($Grid/CulturePanel/Scroll/Grid.get_child(i)))
		$Grid/CulturePanel/Scroll/Grid.get_child(i).set_meta("index", i + 1)
		$Grid/CulturePanel/Scroll/Grid.get_child(i).set_meta("key", $Grid/CulturePanel/Scroll/Grid.get_child(i).name.to_lower().replace("button", ""))
	
	for i in range($Grid/ClassPanel/Grid.get_child_count()):
		$Grid/ClassPanel/Grid.get_child(i).toggled.connect(class_button.bind($Grid/ClassPanel/Grid.get_child(i)))
		$Grid/ClassPanel/Grid.get_child(i).set_meta("index", i + 1)
		$Grid/ClassPanel/Grid.get_child(i).set_meta("key", $Grid/ClassPanel/Grid.get_child(i).name.to_lower().replace("button", ""))
	
	for i in range($Grid/BackgroundPanel/GridContainer.get_child_count()):
		$Grid/BackgroundPanel/GridContainer.get_child(i).toggled.connect(background_button.bind($Grid/BackgroundPanel/GridContainer.get_child(i)))
		$Grid/BackgroundPanel/GridContainer.get_child(i).set_meta("index", i + 1)
		$Grid/BackgroundPanel/GridContainer.get_child(i).set_meta("key", $Grid/BackgroundPanel/GridContainer.get_child(i).name.to_lower().replace("button", ""))

func features(key: String, toggled: bool):
	if toggled:
		for i in len(heritage_features[key]):
			var feature: Dictionary = heritage_features[key][i]
			var label: Node = preload("res://char_creator_a5e/feature_label.tscn").instantiate()
			label.text = feature["name"]
			label.set_tooltip_text(JSON.stringify(feature))
			label.name = "FeatureLabel" + str(i)
			label.set_mouse_filter(MOUSE_FILTER_PASS)
			$Grid/HeritagePanel/VBoxContainer/Features/Container.add_child(label)
		
		for i in len(heritage_gifts[key]):
			var gift: Dictionary = heritage_gifts[key][i]
			$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftItems.add_item(gift["name"])
		
		$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftItems.ready.emit()
	else:
		for child in $Grid/HeritagePanel/VBoxContainer/Features/Container.get_children():
			$Grid/HeritagePanel/VBoxContainer/Features/Container.remove_child(child)
		
		$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftItems.clear()
		
		for child in $Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.get_children():
			$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.remove_child(child)

func _on_gift_items_item_selected(index):
	var keys: Array[String] = ["", "dragonborn", "dwarf", "elf", "gnome", "halfling", "human", "orc", "planetouched"]
	
	if heritage == 0:
		# Null
		pass
	else:
		# Others
		for child in $Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.get_children():
			$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.remove_child(child)
		
		for i in len(heritage_gifts[keys[heritage]][index]["features"]):
			var feature: Dictionary = heritage_gifts[keys[heritage]][index]["features"][i]
			var label: Node = preload("res://char_creator_a5e/feature_label.tscn").instantiate()
			label.text = feature["name"]
			label.set_tooltip_text(JSON.stringify(feature))
			label.name = "FeatureLabel" + str(i)
			label.set_mouse_filter(MOUSE_FILTER_PASS)
			$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.add_child(label)
		
		$Grid/MiddlePanel/NextButton.visible = true

func move_button(button_array: Array[Node], name_array: Array, button_name: String):
	var index: int = name_array.find(button_name)
	button_array[index].reparent($Grid/CulturePanel/SuggestedGrid)
	button_array.remove_at(index)
	name_array.remove_at(index)

func setup_culture_buttons(forward: bool):
	if forward:
		if len($Grid/CulturePanel/SuggestedGrid.get_children()) != 0:
			var old_buttons: Array[Node] = $Grid/CulturePanel/SuggestedGrid.get_children()
			
			for button in old_buttons:
				button.reparent($Grid/CulturePanel/Scroll/Grid)
		
		var culture_buttons: Array[Node] = $Grid/CulturePanel/Scroll/Grid.get_children()
		culture_buttons.sort_custom(func(a, b): return a.name.naturalnocasecmp_to(b.name))
		culture_buttons.reverse()
		var culture_names: Array = culture_buttons.map(func(x) -> String: return x.name.replace("Button", ""))
		assert(heritage != 0)
		
		if heritage == 2:
			# Dwarf
			# Deep Dwarf, Forsaken, Godbound, Hill Dwarf, Mountain Dwarf
			move_button(culture_buttons, culture_names, "DeepDwarf")
			move_button(culture_buttons, culture_names, "Forsaken")
			move_button(culture_buttons, culture_names, "Godbound")
			move_button(culture_buttons, culture_names, "HillDwarf")
			move_button(culture_buttons, culture_names, "MountainDwarf")
		elif heritage == 3:
			# Elf
			# Eladrin, High Elf, Shadow Elf, Wood Elf
			move_button(culture_buttons, culture_names, "Eladrin")
			move_button(culture_buttons, culture_names, "HighElf")
			move_button(culture_buttons, culture_names, "ShadowElf")
			move_button(culture_buttons, culture_names, "WoodElf")
		elif heritage == 5:
			# Halfling
			# Kithbáin Halfling, Mistbairn Halfling, Stout Halfling, Tunnel Halfling
			move_button(culture_buttons, culture_names, "KithbainHalfling")
			move_button(culture_buttons, culture_names, "MistbairnHalfling")
			move_button(culture_buttons, culture_names, "StoutHalfling")
			move_button(culture_buttons, culture_names, "TunnelHalfling")
		elif heritage == 6:
			# Human
			# Cosmopolitan, Imperial, Settler, Villager
			move_button(culture_buttons, culture_names, "Cosmopolitan")
			move_button(culture_buttons, culture_names, "Imperial")
			move_button(culture_buttons, culture_names, "Settler")
			move_button(culture_buttons, culture_names, "Villager")
		elif heritage == 1:
			# Dragonborn
			# Dragonbound, Dragoncult
			move_button(culture_buttons, culture_names, "Dragonbound")
			move_button(culture_buttons, culture_names, "Dragoncult")
		elif heritage == 4:
			# Gnome
			# Deep Gnome, Forest Gnome, Forgotten Folx, Tinker Gnome
			move_button(culture_buttons, culture_names, "DeepGnome")
			move_button(culture_buttons, culture_names, "ForestGnome")
			move_button(culture_buttons, culture_names, "ForgottenFolx")
			move_button(culture_buttons, culture_names, "TinkerGnome")
		elif heritage == 7:
			# Orc
			# Caravanner, Stoic Orc, Wildling
			move_button(culture_buttons, culture_names, "Caravanner")
			move_button(culture_buttons, culture_names, "StoicOrc")
			move_button(culture_buttons, culture_names, "Wildling")
	else:
		pass

func cultures(key: String, toggle: bool):
	if toggle:
		for i in len(culture_features[key]):
			var feature: Dictionary = culture_features[key][i]
			var label: Node = preload("res://char_creator_a5e/feature_label.tscn").instantiate()
			label.text = feature["name"]
			label.set_tooltip_text(JSON.stringify(feature))
			label.name = "FeatureLabel" + str(i)
			label.set_mouse_filter(MOUSE_FILTER_PASS)
			label.set_autowrap_mode(TextServer.AUTOWRAP_WORD_SMART)
			$Grid/CulturePanel/FeaturesScroll/VBoxContainer.add_child(label)
		
		$Grid/MiddlePanel/NextButton.visible = true
	else:
		for child in $Grid/CulturePanel/FeaturesScroll/VBoxContainer.get_children():
			$Grid/CulturePanel/FeaturesScroll/VBoxContainer.remove_child(child)

func _on_next_button_pressed():
	if panel == 0:
		assert(heritage != 0)
		$Grid/HeritagePanel.visible = false
		$Grid/CulturePanel.visible = true
		$Grid/MiddlePanel/NextButton.visible = false
		$Grid/MiddlePanel/BackButton.visible = true
		
		if culture != 0:
			$Grid/MiddlePanel/NextButton.visible = true
		
		setup_culture_buttons(true)
		panel = 1
	elif panel == 1:
		assert(culture != 0)
		$Grid/CulturePanel.visible = false
		$Grid/ClassPanel.visible = true
		$Grid/MiddlePanel/NextButton.visible = false
		
		if class_val != 0:
			$Grid/MiddlePanel/NextButton.visible = true
		
		panel = 2
	elif panel == 2:
		assert(class_val != 0)
		$Grid/ClassPanel.visible = false
		$Grid/BackgroundPanel.visible = true
		$Grid/MiddlePanel/NextButton.visible = false
		
		if background != 0:
			$Grid/MiddlePanel/NextButton.visible = true
		
		panel = 3
	elif panel == 3:
		assert(background != 0)
		$Grid/BackgroundPanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = false
		$Grid/SpacePanel.visible = true
		panel = 3

func _on_back_button_pressed():
	if panel == 0:
		assert(false) # this shouldn't be happening
	elif panel == 1:
		$Grid/HeritagePanel.visible = true
		$Grid/CulturePanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = true
		$Grid/MiddlePanel/BackButton.visible = false
		setup_culture_buttons(false)
		panel = 0
	elif panel == 2:
		$Grid/CulturePanel.visible = true
		$Grid/ClassPanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = true
		panel = 1
	elif panel == 3:
		$Grid/ClassPanel.visible = true
		$Grid/BackgroundPanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = true
		panel = 2
