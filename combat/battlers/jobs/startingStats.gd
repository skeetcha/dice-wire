extends Resource
class_name StartingStats

enum SIZES {TINY, SMALL, MEDIUM, LARGE, HUGE, GARGANTUAN}
enum TYPES {ABBERATION, BEAST, CELESTIAL, CONSTRUCT, DRAGON, ELEMENTAL, FEY, FIEND, GIANT, HUMANOID, MONSTROSITY, OOZE, PLANT, UNDEAD}

@export var job_name : String = "Job"
@export var size : SIZES
@export var type : TYPES
@export var subtype : String
# Only used for overrides on monsters
@export var ac : int
@export var speeds : Dictionary = {"walking": 0, "climbing": 0, "flying": 0, "swimming": 0}
@export var abilityScores : Dictionary = {"str": 0, "dex": 0, "con": 0, "int": 0, "wis": 0, "cha": 0}
@export var currentHP : float
@export var hitDice : Dictionary = {"amount": 0, "size": 0, "bonus": 0}
