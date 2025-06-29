BINDING_HEADER_ZMOBDB = "ZMobDB Advanced";
BINDING_NAME_ZMOBDB_CONFIG = "Config Window";
BINDING_NAME_ZMOBDB_REFRESH = "Refresh Models";
BINDING_NAME_ZMOBDB_COPY = "Copy Window";
BINDING_NAME_ZMOBDB_TESTBOX = "Animation Test";


ZMobDB_Unit_table = { 
"player",
"target",
"party",
"pet",
"targettarget",
"pettarget",
"partytarget",
"focus",
"focustarget",
"partypet",
};

ZMobDB_Unittype_table = { 
"player",
"target",
"party1",
"party2",
"party3",
"party4",
"pet",
"targettarget",
"pettarget",
"party1target",
"party2target",
"party3target",
"party4target",
"focus",
"party1pet",
"party2pet",
"party3pet",
"party4pet",
"focustarget",
};

ZMobDB_Unit_word = {
	["player"] = "player",
	["target"] = "target",
	["party1"] = "party",
	["party2"] = "party",
	["party3"] = "party",
	["party4"] = "party",
	["pet"] = "pet",
	["targettarget"] = "targettarget",
	["pettarget"] = "pettarget",
	["party1target"] = "partytarget",
	["party2target"] = "partytarget",
	["party3target"] = "partytarget",
	["party4target"] = "partytarget",
	["focustarget"] = "focustarget",
	["focus"] = "focus",
	["party1pet"] = "partypet",
	["party2pet"] = "partypet",
	["party3pet"] = "partypet",
	["party4pet"] = "partypet",
};

ZMobDB_ID_table = {
	[0] = "player",
	[1] = "target",
	[2] = "party1",
	[3] = "party2",
	[4] = "party3",
	[5] = "party4",
	[6] = "pet",
	[7] = "targettarget",
	[8] = "pettarget",
	[9] = "player",
	[10] = "party1target",
	[11] = "party2target",
	[12] = "party3target",
	[13] = "party4target",
	[14] = "focus",
	[15] = "party1pet",
	[16] = "party2pet",
	[17] = "party3pet",
	[18] = "party4pet",
	[19] = "focustarget",
	[20] = "target",
};


ZMobDB_Avatar_table = {
	["player"] = { ["unit"] = 0, ["target"] = 1, ["pet"] = 6, ["focus"] = 14 },
	["target"] = { ["unit"] = 1, ["target"] = 7, ["pet"] = nil, ["focus"] = nil },
	["party1"] = { ["unit"] = 2, ["target"] = 10, ["pet"] = 15, ["focus"] = nil },
	["party2"] = { ["unit"] = 3, ["target"] = 11, ["pet"] = 16, ["focus"] = nil },
	["party3"] = { ["unit"] = 4, ["target"] = 12, ["pet"] = 17, ["focus"] = nil },
	["party4"] = { ["unit"] = 5, ["target"] = 13, ["pet"] = 18, ["focus"] = nil },
	["pet"] = { ["unit"] = 6, ["target"] = 8, ["pet"] = nil, ["focus"] = nil },
	["targettarget"] = { ["unit"] = 7, ["target"] = nil, ["pet"] = nil, ["focus"] = nil },
	["pettarget"] = { ["unit"] = 8, ["target"] = nil, ["pet"] = nil, ["focus"] = nil },
	["partytarget1"] = { ["unit"] = 10, ["target"] = nil, ["pet"] = nil, ["focus"] = nil },
	["partytarget2"] = { ["unit"] = 11, ["target"] = nil, ["pet"] = nil, ["focus"] = nil },
	["partytarget3"] = { ["unit"] = 12, ["target"] = nil, ["pet"] = nil, ["focus"] = nil },
	["partytarget4"] = { ["unit"] = 13, ["target"] = nil, ["pet"] = nil, ["focus"] = nil },
	["focustarget"] = { ["unit"] = 19, ["target"] = nil, ["pet"] = nil, ["focus"] = nil },
	["focus"] = { ["unit"] = 14, ["target"] = 19, ["pet"] = nil, ["focus"] = nil },
	["partypet1"] = { ["unit"] = 15, ["target"] = nil, ["pet"] = nil, ["focus"] = nil },
	["partypet2"] = { ["unit"] = 16, ["target"] = nil, ["pet"] = nil, ["focus"] = nil },
	["partypet3"] = { ["unit"] = 17, ["target"] = nil, ["pet"] = nil, ["focus"] = nil },
	["partypet4"] = { ["unit"] = 18, ["target"] = nil, ["pet"] = nil, ["focus"] = nil },
};

ZMobDB_table_default = { 
	default = { 
	scale = 1,
	zoom = 0,
	position = {0,0},
	rotation = 0,
 } };

function ZMobDB_SetupDefaultProfile(ZMobDBPlayerIndex,Index)
--Set ALL needed variables to their default state.
	if Index=="default" then
		Table = ZMobDB_Options_4
	else
		Table = ZMobDB_Options_Temp
	end

	Table[ZMobDBPlayerIndex]={}
	Table[ZMobDBPlayerIndex]["Settings"]={}
	Table[ZMobDBPlayerIndex]["Settings"]["SlowMode"]="off"
	Table[ZMobDBPlayerIndex]["Settings"]["HideInRaid"]="off"
	Table[ZMobDBPlayerIndex]["Settings"]["TargetData"]="No Target"
	Table[ZMobDBPlayerIndex]["Settings"]["CopyEntry"]=""
	Table[ZMobDBPlayerIndex]["Settings"]["TempEntry"]=""
	Table[ZMobDBPlayerIndex]["Settings"]["HoldBox"]="off"
	Table[ZMobDBPlayerIndex]["Settings"]["Mouseoverthrough"]="off"
	Table[ZMobDBPlayerIndex]["Settings"]["PvPMode"]="off"
--	Table[ZMobDBPlayerIndex]["Settings"]["SimpleMode"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["ModelMode"]="off"
	Table[ZMobDBPlayerIndex]["Settings"]["DropDown"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["PainRate"]=30
	Table[ZMobDBPlayerIndex]["Settings"]["AlphaRate"]=50
	Table[ZMobDBPlayerIndex]["Settings"]["Symbol"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Tooltip"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Tooltip_Unit"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Tooltip_onlyconfig"]="off"
	Table[ZMobDBPlayerIndex]["Settings"]["Random_IsNotCombat"]="off"
	Table[ZMobDBPlayerIndex]["Settings"]["Strata"]="LOW"
	Table[ZMobDBPlayerIndex]["Settings"]["Ghost_Model_name"]="tombstone"
	Table[ZMobDBPlayerIndex]["Settings"]["Border"]="default"
	Table[ZMobDBPlayerIndex]["Settings"]["Reflesh_control"]="mouseright"
	Table[ZMobDBPlayerIndex]["Settings"]["NoticeNewData"]="off"
	Table[ZMobDBPlayerIndex]["Settings"]["ResetSwitch"]="off"
	Table[ZMobDBPlayerIndex]["Settings"]["SelectUnit"]="player"
	Table[ZMobDBPlayerIndex]["Settings"]["SelectUnit_Animation"]="target"
	Table[ZMobDBPlayerIndex]["Settings"]["Select_Animation"]="Normal"
	Table[ZMobDBPlayerIndex]["Settings"]["SelectBox"]="player"
	Table[ZMobDBPlayerIndex]["Settings"]["Random_Wave"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Random_Rude"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Random_Roar"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Random_Kiss"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Random_Chicken"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Random_Applause"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Random_Flex"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Random_Point"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Random_Shout"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Random_Run"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Hit_Flinch"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Hit_Flinch2"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Hit_Spell"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Hit_Spell2"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Hit_Run"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Hit_WalkBack"]="on"
	Table[ZMobDBPlayerIndex]["Settings"]["Hit_Channeling"]="on"

	for index,value in ipairs(ZMobDB_Unit_table) do
		if 
			value == "player" or 
			value == "pet" 
		then
			Table[ZMobDBPlayerIndex][value]={}
			Table[ZMobDBPlayerIndex][value]["Show"]="on"
			Table[ZMobDBPlayerIndex][value]["Port"]="off"
			Table[ZMobDBPlayerIndex][value]["Strata"]="LOW"
			Table[ZMobDBPlayerIndex][value]["Specific"]="on"
			Table[ZMobDBPlayerIndex][value]["EnableMouse"]="on"
			Table[ZMobDBPlayerIndex][value]["FixFace"]="off"
			Table[ZMobDBPlayerIndex][value]["RaidIcon"]="on"
			Table[ZMobDBPlayerIndex][value]["PvPIcon"]="on"
			Table[ZMobDBPlayerIndex][value]["RaidIcon_Position"]="TOPLEFT"
			Table[ZMobDBPlayerIndex][value]["PvPIcon_PositionX"]=0
			Table[ZMobDBPlayerIndex][value]["PvPIcon_PositionY"]=0
			Table[ZMobDBPlayerIndex][value]["RaidIcon_Size"]=20
			Table[ZMobDBPlayerIndex][value]["PvPIcon_Size"]=20
			Table[ZMobDBPlayerIndex][value]["EventAnimation"]="on"
			Table[ZMobDBPlayerIndex][value]["RandomAnimation"]="off"
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_ChangeView"]="off"
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_Interval"]=10
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_Interval_Combat"]=10
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_Rate"]=50
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_Rate_Combat"]=50
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_IsFriend"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Ghost"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Dead"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Rest"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Pain"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_AFK"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Stealth"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Ice"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Shackle"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Fear"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Cyclone"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Seduce"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Banish"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Sleep"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Shield"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Bandage"]="on"
		elseif 
			value == "pettarget" or 
			value == "partytarget" or 
			value == "partypet" or 
			value == "focus" or 
			value == "focustarget" 
		then
			Table[ZMobDBPlayerIndex][value]={}
			Table[ZMobDBPlayerIndex][value]["Show"]="off"
			Table[ZMobDBPlayerIndex][value]["Port"]="off"
			Table[ZMobDBPlayerIndex][value]["Strata"]="LOW"
			Table[ZMobDBPlayerIndex][value]["Specific"]="off"
			Table[ZMobDBPlayerIndex][value]["EnableMouse"]="on"
			Table[ZMobDBPlayerIndex][value]["FixFace"]="off"
			Table[ZMobDBPlayerIndex][value]["RaidIcon"]="on"
			Table[ZMobDBPlayerIndex][value]["PvPIcon"]="on"
			Table[ZMobDBPlayerIndex][value]["RaidIcon_Position"]="TOPLEFT"
			Table[ZMobDBPlayerIndex][value]["PvPIcon_PositionX"]=0
			Table[ZMobDBPlayerIndex][value]["PvPIcon_PositionY"]=0
			Table[ZMobDBPlayerIndex][value]["RaidIcon_Size"]=20
			Table[ZMobDBPlayerIndex][value]["PvPIcon_Size"]=20
			Table[ZMobDBPlayerIndex][value]["EventAnimation"]="on"
			Table[ZMobDBPlayerIndex][value]["RandomAnimation"]="off"
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_ChangeView"]="off"
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_Interval"]=10
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_Interval_Combat"]=10
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_Rate"]=50
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_Rate_Combat"]=50
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_IsFriend"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Ghost"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Dead"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Rest"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Pain"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_AFK"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Stealth"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Ice"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Shackle"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Fear"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Cyclone"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Seduce"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Banish"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Sleep"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Shield"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Bandage"]="on"
		else
			Table[ZMobDBPlayerIndex][value]={}
			Table[ZMobDBPlayerIndex][value]["Show"]="on"
			Table[ZMobDBPlayerIndex][value]["Port"]="off"
			Table[ZMobDBPlayerIndex][value]["Strata"]="LOW"
			Table[ZMobDBPlayerIndex][value]["Specific"]="off"
			Table[ZMobDBPlayerIndex][value]["EnableMouse"]="on"
			Table[ZMobDBPlayerIndex][value]["FixFace"]="off"
			Table[ZMobDBPlayerIndex][value]["RaidIcon"]="on"
			Table[ZMobDBPlayerIndex][value]["PvPIcon"]="on"
			Table[ZMobDBPlayerIndex][value]["RaidIcon_Position"]="TOPLEFT"
			Table[ZMobDBPlayerIndex][value]["PvPIcon_PositionX"]=0
			Table[ZMobDBPlayerIndex][value]["PvPIcon_PositionY"]=0
			Table[ZMobDBPlayerIndex][value]["RaidIcon_Size"]=20
			Table[ZMobDBPlayerIndex][value]["PvPIcon_Size"]=20
			Table[ZMobDBPlayerIndex][value]["EventAnimation"]="on"
			Table[ZMobDBPlayerIndex][value]["RandomAnimation"]="off"
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_ChangeView"]="off"
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_Interval"]=10
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_Interval_Combat"]=10
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_Rate"]=50
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_Rate_Combat"]=50
			Table[ZMobDBPlayerIndex][value]["RandomAnimation_IsFriend"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Ghost"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Dead"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Rest"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Pain"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_AFK"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Stealth"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Ice"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Shackle"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Fear"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Cyclone"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Seduce"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Banish"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Sleep"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Shield"]="on"
			Table[ZMobDBPlayerIndex][value]["Animation_Bandage"]="on"
		end
	end
end

function ZMobDB_SetupAnimationStats(Table,Index)
--Set ALL needed variables to their default state.
	Table[Index]={}
	Table[Index]["UnitName"]="NoData"
	Table[Index]["DataSelect"]="default"
	Table[Index]["stats"]="Normal"
	Table[Index]["pre_stats"]="Normal"
	Table[Index]["ghost_model"]="tombstone"
end


ZMobDB_Event_Animation = {
	["Dead"] = { ["No"] = 1, ["Frames"] = nil, ["nextNo"] = nil },
	["Pain"] = { ["No"] = 14, ["Frames"] = nil, ["nextNo"] = nil },
	["Rest"] = { ["No"] = 96, ["Frames"] = nil, ["nextNo"] = nil },
	["AFK"] = { ["No"] = 96, ["Frames"] = nil, ["nextNo"] = nil },
	["Stealth"] = { ["No"] = 119, ["Frames"] = nil, ["nextNo"] = nil },
	["Run"] = { ["No"] = 5, ["Frames"] = 2500, ["nextNo"] = nil },
	["WalkBack"] = { ["No"] = 13, ["Frames"] = 2500, ["nextNo"] = nil },
	["Channeling"] = { ["No"] = 124, ["Frames"] = 2500, ["nextNo"] = nil },
	["CreateMotion"] = { ["No"] = 63, ["Frames"] = 4000, ["nextNo"] = nil },
	["Flinch"] = { ["No"] = 10, ["Frames"] = 750, ["nextNo"] = nil, },
	["Flinch2"] = { ["No"] = 36, ["Frames"] = 750, ["nextNo"] = nil, },
	["Spell"] = { ["No"] = 52, ["Frames"] = 2000, ["nextNo"] = nil, },
	["Spell2"] = { ["No"] = 53, ["Frames"] = 1500, ["nextNo"] = nil, },
	["Wave"] = { ["No"] = 67, ["Frames"] = 2500, ["nextNo"] = nil },
	["Rude"] = { ["No"] = 73, ["Frames"] = 2500, ["nextNo"] = nil },
	["Roar"] = { ["No"] = 74, ["Frames"] = 3000, ["nextNo"] = nil },
	["Kiss"] = { ["No"] = 76, ["Frames"] = 2400, ["nextNo"] = nil },
	["Chicken"] = { ["No"] = 78, ["Frames"] = 3800, ["nextNo"] = nil },
	["Applause"] = { ["No"] = 80, ["Frames"] = 3000, ["nextNo"] = nil },
	["Flex"] = { ["No"] = 82, ["Frames"] = 4000, ["nextNo"] = nil },
	["Point"] = { ["No"] = 84, ["Frames"] = 3000, ["nextNo"] = nil },
	["Shout"] = { ["No"] = 81, ["Frames"] = 3000, ["nextNo"] = nil },
	["tombstone"] = { ["id"] = 1, ["File"] = "World\\Environment\\doodad\\naxxramas\\icyrune01.m2" },
	["skull"] = { ["id"] = 2, ["File"] = "World\\Generic\\passivedoodads\\skeletons\\lightskeletonsitting01.m2" },
	["gas"] = { ["id"] = 3, ["File"] = "Spells\\Purpleghost_state.m2" },
	["spirit"] = { ["id"] = 4, ["File"] = "Spells\\Manafunnel_impact_chest.m2" },
	["Horde_Flag"] = { ["id"] = 5, ["File"] = "World\\Generic\\pvp\\battlefieldbanners\\battlefieldbannerhorde.m2" },
	["Alliance_Flag"] = { ["id"] = 6, ["File"] = "World\\Generic\\pvp\\battlefieldbanners\\battlefieldbanneralliance.m2" },
	["Shackle"] = { ["id"] = 7, ["File"] = "Spells\\Unholyshackles_state_base.m2", ["scale"] = 1,["zoom"] = 0,["position"] = {0,0},["rotation"] = 0 },
	["Ice"] = { ["id"] = 8, ["File"] = "Spells\\Icebarrier_state.m2", ["scale"] = 1,["zoom"] = 0,["position"] = {0,0},["rotation"] = 0 },
	["Fear"] = { ["id"] = 9, ["File"] = "Spells\\Shadowbolt_missile.m2", ["scale"] = 4.25,["zoom"] = 0,["position"] = {0,0},["rotation"] = 0 },
	["Cyclone"] = { ["id"] = 10, ["File"] = "Spells\\Cyclone_state.m2", ["scale"] = 1,["zoom"] = 0,["position"] = {0,0},["rotation"] = 0 },
	["Seduce"] = { ["id"] = 11, ["File"] = "Spells\\Seduction_state_head.m2", ["scale"] = 2,["zoom"] = 0,["position"] = {0,0},["rotation"] = 0 },
	["Banish"] = { ["id"] = 12, ["File"] = "Spells\\Banish_chest.m2", ["scale"] = 1,["zoom"] = 0,["position"] = {0,0},["rotation"] = 0 },
	["Sleep"] = { ["id"] = 13, ["File"] = "Spells\\Beastsoothe_state_head.m2", ["scale"] = 2,["zoom"] = 0,["position"] = {0,0},["rotation"] = 0 },
	["Shield"] = { ["id"] = 14, ["File"] = "Spells\\Holydivineshield_state_base.m2", ["scale"] = 2,["zoom"] = 0,["position"] = {0,0},["rotation"] = 0 },
	["Bandage"] = { ["id"] = 15, ["File"] = "Spells\\Invisibility_impact_base.m2", ["scale"] = 2,["zoom"] = 0,["position"] = {0,0},["rotation"] = 0 },
};

ZMobDB_RandomAnimation_Table = {
"Wave",
"Rude",
"Roar",
"Kiss",
"Chicken",
"Applause",
"Flex",
"Point",
"Shout",
"Run",
};

ZMobDB_HitAnimation_Table = {
"Flinch",
"Flinch2",
"Spell",
"Spell2",
"Run",
"WalkBack",
"Channeling",
};

ZMobDBStealth_Table = { 
"Ghost Wolf",
"Prowl",
"Shadowmeld",
"Shadowform",
"Ancestor Invisibility",
"Arcane Invisibility",
"Bombing Run: Invisibility",
"Drunk Invisibility (Pink)",
"Elemental Spirit Invisibility",
"Eranikus the Chained Invisiibility",
"Garm Wolfbrother: Invisibility",
"Greater Invisibility",
"Head of the Horseman Invisible",
"Lesser Invisibility",
"Phasing Invisibility",
"Quest Invisibility",
"Rift Spawn Invisibility",
"Sai'kkal Invisibility",
"Shadowmoon Ghost Invisibility",
"Target Invisibility",
"Triangulation Point One Invisibility",
"Triangulation Point Two Invisibility",
"Phase Shift",
};

ZMobDBStealth_Name = { 
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
"Invisi",
};

ZMobDBGhost_Name = { 
"tombstone",
"skull",
"flag",
"gas",
"spirit",
};

ZMobDBBuff_Table = {
"Eat",
"Food",
"Drink",
"Watar",
"Ice Block",
"First Aid",
"Bandage",
"Divine Shield",
"Divine Protection",
"Blessing of Protection",
};

ZMobDBBuff_Name = {
"Rest",
"Rest",
"Rest",
"Rest",
"Ice",
"Bandage",
"Bandage",
"Shield",
"Shield",
"Shield",
};


ZMobDBDebuff_Table = {
"Fear",
"Fleeing in Terror",
"Howl of Terror",
"Death Coil",
"Psychic Scream",
"Seduction",
"Anesthetic",
"Bad Poetry",
"Bone Bore",
"Crystalline Slumber",
"Dreamless Sleep",
"Druid's Slumber",
"Enchanting Lullaby",
"Gas Bomb",
"Greater Dreamless Sleep",
"Hibernate",
"Major Dreamless Sleep",
"Naralex's Nightmare",
"Sablemane's Sleeping Powder",
"Sleep",
"Tunnel Bore",
"Wyvern Sting",
"Freezing Trap",
"Shackle",
"Cyclone",
"Banish",
};

ZMobDBDebuff_Name = {
"Fear",
"Fear",
"Fear",
"Fear",
"Fear",
"Seduce",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Sleep",
"Ice",
"Shackle",
"Cyclone",
"Banish",
};

ZMobDBForm_Table = { 
"Cat Form",
"Aquatic Form",
"Travel Form",
"Tree of Life",
"Snowman",
"Bear Form",
"Moonkin Form",
"Ghost Wolf",
"Skeleton Costume",
"Flip Out",
"Yaaarrrr",
"Lament",
"Winter Wondervolt",
"Gnome Costume",
"Wisp Costume",
"Bat Costume",
"Human Illusion",
"Flight Form"
};

ZMobDBForm_Name = { 
"Cat_form",
"Aqua_form",
"Travel_form",
"Trent_form",
"SnowMan",
"Bear_form",
"Moonkin_form",
"Wolf_Form",
"Skelton_form",
"Pirate_form",
"Pirate_form",
"Lament",
"Gnome_Santa",
"Gnome_form",
"Wisp_Form",
"Bat_Form",
"Human_Form",
"Flight_form"
};

function ZMobDB_Settings_CreateProfile()
	return {
		[0]  = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[1]  = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[2]  = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[3]  = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[4]  = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[5]  = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[6]  = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[7]  = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[8]  = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[9]  = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[10] = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[11] = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[12] = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[13] = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[14] = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[15] = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[16] = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[17] = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[18] = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[19] = ZMobDB_Settings_CreateProfile_BoundingBox(),
		[20] = ZMobDB_Settings_CreateProfile_BoundingBox(),
	};
end

function ZMobDB_Settings_CreateProfile_BoundingBox()
	return {
		["isEnabled"] = false,
		["title"] = "Untitled",
		["scale"] = {
			["width"] = 200,
			["height"] = 200,
		},
		["anchor"] = {
			["x"] = 200,
			["y"] = 200,
		},
		["bgColor"] = {
			["red"] = 0,
			["green"] = 0,
			["blue"] = 0,
			["alpha"] = 0,
		},
		["avatar"] = {
			["unitType"] = "target",
			["isRendered"] = false,
			["camera"] = ZMobDB_Settings_CreateCamera(),
		},
		["cursorControls"] = ZMobDB_Settings_CreateProfile_CursorControls(),
	};
end

function ZMobDB_Settings_CreateProfile_CursorControls()
	return {
		["isEnabled"] = true,
		["active"] = nil,
		["count"] = 0,
		["LeftButton"]   = ZMobDB_Settings_CreateProfile_CursorControlButton(),
		["RightButton"]  = ZMobDB_Settings_CreateProfile_CursorControlButton(),
		["MiddleButton"] = ZMobDB_Settings_CreateProfile_CursorControlButton(),
		["ScrollWheel"]  = ZMobDB_Settings_CreateProfile_CursorControlButton(),
	};
end

function ZMobDB_Settings_CreateProfile_CursorControlButton()
	return {
		["NOKEY"] = nil,
		["ALT"]   = nil,
		["CTRL"]  = nil,
		["SHIFT"] = nil,
	};
end


--
-- Camera Settings
--

function ZMobDB_Settings_RefreshCamera(avatar)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	camera = ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera;
	avatar:SetModelScale(camera.scale);
	avatar:SetPosition(camera.zoom, camera.position.panH, camera.position.panV);
	avatar:SetRotation(camera.rotation);
	--avatar:SetLight(camera.light.isEnabled, camera.light.omni, camera.light.zoom,
	--	camera.light.position.panH, camera.light.position.panV, camera.light.ambient.alpha,
	--	camera.light.ambient.red, camera.light.ambient.green, camera.light.ambient.blue,
	--	camera.light.direct.alpha, camera.light.direct.red, camera.light.direct.green,
	--	camera.light.direct.blue);
end

function ZMobDB_Settings_CreateCamera(copyFrom)
	return {
		["scale"] = 1,
		["zoom"]  = 0,
		["position"] = {
			["panH"] = 0,
			["panV"] = 0,
		},
		["rotation"] = 0,
		["light"] = {
			["isEnabled"] = false,
			["omni"] = 1,
			["zoom"] = 0,
			["position"] = {
				["panH"] = 0,
				["panV"] = 0,
			},
			["ambient"] = {
				["red"]   = 0,
				["green"] = 0,
				["blue"]  = 0,
				["alpha"] = 0,
			},
			["direct"] = {
				["red"]   = 0,
				["green"] = 0,
				["blue"]  = 0,
				["alpha"] = 0,
			},
		},
	};
end
-- ---------------------------------------------------------
-- DropDown Menu Setting
-- ---------------------------------------------------------

ZMobDB_StrataList = {
"BACKGROUND",
"LOW",
"MEDIUM",
"HIGH",
"DIALOG",
"FULLSCREEN_DIALOG",
"TOOLTIP",
};

ZMobDB_GhostModelList = {
"TOMBSTONE",
"SKULL",
"GAS",
"SPIRIT",
"FLAG",
"RANDOM",
"RANDOM_BG",
};

ZMobDB_SlowModeList = {
"OFF",
"ALL",
"PARTY",
"RAID",
};

ZMobDB_BorderList = {
"DEFAULT",
"BLACK",
"EDGE",
"TOOLTIP",
};

ZMobDB_RefreshControlList = {
"MOUSERIGHT",
"ALT_MOUSERIGHT",
};

ZMobDB_SelectUnitList = {
"PLAYER",
"TARGET",
"PARTY",
"PET",
"TARGETTARGET",
"PETTARGET",
"PARTYTARGET",
"FOCUS",
"FOCUSTARGET",
"PARTYPET",
};

ZMobDB_SelectBoxList = {
"PLAYER",
"TARGET",
"PARTY1",
"PARTY2",
"PARTY3",
"PARTY4",
"PET",
"TARGETTARGET",
"PETTARGET",
"PARTY1TARGET",
"PARTY2TARGET",
"PARTY3TARGET",
"PARTY4TARGET",
"FOCUS",
"PARTY1PET",
"PARTY2PET",
"PARTY3PET",
"PARTY4PET",
"FOCUSTARGET",
};

ZMobDB_RaidIconPositionList = {
"TOPLEFT",
"TOPRIGHT",
"BOTTOMLEFT",
"BOTTOMRIGHT",
};

ZMobDB_SelectAnimationList = {
"Normal",
"Dead",
"Pain",
"Rest",
"AFK",
"Stealth",
"Random",
"Ghost",
"Shackle",
"Ice",
"Fear",
"Cyclone",
"Seduce",
"Banish",
"Sleep",
"Shield",
"Bandage",
};

function ZMobDB_DropDownStrataInitiation_player()
	for index,value in ipairs(ZMobDB_StrataList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownStrataplayerOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownStrataInitiation_target()
	for index,value in ipairs(ZMobDB_StrataList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownStratatargetOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownStrataInitiation_party()
	for index,value in ipairs(ZMobDB_StrataList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownStratapartyOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownStrataInitiation_pet()
	for index,value in ipairs(ZMobDB_StrataList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownStratapetOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownStrataInitiation_targettarget()
	for index,value in ipairs(ZMobDB_StrataList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownStratatargettargetOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownStrataInitiation_pettarget()
	for index,value in ipairs(ZMobDB_StrataList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownStratapettargetOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownStrataInitiation_focus()
	for index,value in ipairs(ZMobDB_StrataList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownStratafocusOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownStrataInitiation_partytarget()
	for index,value in ipairs(ZMobDB_StrataList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownStratapartytargetOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownStrataInitiation_partypet()
	for index,value in ipairs(ZMobDB_StrataList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownStratapartypetOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownStrataInitiation_focustarget()
	for index,value in ipairs(ZMobDB_StrataList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownStratafocustargetOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownGhost_ModelInitiation()
	for index,value in ipairs(ZMobDB_GhostModelList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownGhost_ModelOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownSlowModeInitiation()
	for index,value in ipairs(ZMobDB_SlowModeList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownSlowModeOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownBorderInitiation()
	for index,value in ipairs(ZMobDB_BorderList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownBorderOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDownReflesh_controlInitiation()
	for index,value in ipairs(ZMobDB_RefreshControlList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownReflesh_controlOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDown_SelectUnitInitiation()
	for index,value in ipairs(ZMobDB_SelectUnitList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownSelectUnitOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDown_SelectBoxInitiation()
	for index,value in ipairs(ZMobDB_SelectBoxList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownSelectBoxOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDown_RaidIconPositionInitiation()
	for index,value in ipairs(ZMobDB_RaidIconPositionList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownRaidIconPositionOnClick
		UIDropDownMenu_AddButton(info)
	end
end


function ZMobDB_DropDown_SelectUnitAnimationInitiation()
	for index,value in ipairs(ZMobDB_SelectUnitList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownSelectUnitAnimationOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_DropDown_SelectAnimationInitiation()
	for index,value in ipairs(ZMobDB_SelectAnimationList) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = value
		info.func = ZMobDB_DropDownSelectAnimationOnClick
		UIDropDownMenu_AddButton(info)
	end
end
function ZMobDB_GetIDFromList(id,list)
	for index,value in ipairs(list) do
		if value == id then
			return index
		end
	end
	return 1
end
