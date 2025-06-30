local ZMobDBVar_CopiedProfile={}
local ZMobDBVar_CopiedProfile_2={}

function ZMobDB_reset(self)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	ZMobDB_Options_4[ZMobDBPlayerIndex]={}
	ZMobDB_Options_4[ZMobDBPlayerIndex]["Settings"]={}
	for index,value in ipairs(ZMobDB_Unit_table) do
		ZMobDB_Options_4[ZMobDBPlayerIndex][value]={}
	end
	ZMobDB_SetupDefaultProfile(ZMobDBPlayerIndex,"default")
end
function ZMobDB_SetOption(Table,Setting,Value)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	if(Value==nil)then
		Value="off";
	end
	ZMobDB_Options_4[ZMobDBPlayerIndex][Table][Setting]=Value;
end
function ZMobDB_GetOption(Table,Setting)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	if ZMobDB_Options_4[ZMobDBPlayerIndex][Table][Setting] ~= nil then
		return ZMobDB_Options_4[ZMobDBPlayerIndex][Table][Setting]
	else
		return ZMobDB_Options_Temp[ZMobDBPlayerIndex][Table][Setting]
	end
end
function ZMobDB_SetCheckButton(CheckButton,Table,Index)
	if ZMobDB_GetOption(Table,Index) == "off" then
		CheckButton:SetChecked(false);
	else
		CheckButton:SetChecked(true);
	end
end
function ZMobDB_GetCheckButton(CheckButton,Table,Index)
	local i="off";
	if CheckButton:GetChecked() then
		i="on"
	end
	ZMobDB_SetOption(Table,Index,i);
	ZMobDB_Option_Change();
end
function ZMobDB_PainRateSlider_OnLoad(self)
	_G[self:GetName().."High"]:SetText("100%");
	_G[self:GetName().."Low"]:SetText("0%");
	self:SetMinMaxValues(0,100);
	self:SetValueStep(5);
end
function ZMobDB_AlphaRateSlider_OnLoad(self)
	_G[self:GetName().."High"]:SetText("100%");
	_G[self:GetName().."Low"]:SetText("0%");
	self:SetMinMaxValues(0,100);
	self:SetValueStep(5);
end
function ZMobDB_RaidIcon_SizeSlider_OnLoad(self)
	_G[self:GetName().."High"]:SetText("50%");
	_G[self:GetName().."Low"]:SetText("0%");
	self:SetMinMaxValues(0,50);
	self:SetValueStep(1);
end
function ZMobDB_PvPIcon_SizeSlider_OnLoad(self)
	_G[self:GetName().."High"]:SetText("100");
	_G[self:GetName().."Low"]:SetText("0");
	self:SetMinMaxValues(0,100);
	self:SetValueStep(1);
end
function ZMobDB_RandomAnimationRateSlider_OnLoad(self)
	_G[self:GetName().."High"]:SetText("High");
	_G[self:GetName().."Low"]:SetText("Low");
	self:SetMinMaxValues(10,100);
	self:SetValueStep(10);
	_G[self:GetName().."Text"]:SetText("Animation Rate");
end
function ZMobDB_RandomAnimationRateCombatSlider_OnLoad(self)
	_G[self:GetName().."High"]:SetText("High");
	_G[self:GetName().."Low"]:SetText("Low");
	self:SetMinMaxValues(10,100);
	self:SetValueStep(10);
	_G[self:GetName().."Text"]:SetText("Combat Animation Rate");
end
function ZMobDB_RandomAnimationIntervalSlider_OnLoad(self)
	_G[self:GetName().."High"]:SetText("30s");
	_G[self:GetName().."Low"]:SetText("5s");
	self:SetMinMaxValues(5,30);
	self:SetValueStep(1);
end
function ZMobDB_RandomAnimationIntervalCombatSlider_OnLoad(self)
	_G[self:GetName().."High"]:SetText("30s");
	_G[self:GetName().."Low"]:SetText("5s");
	self:SetMinMaxValues(5,30);
	self:SetValueStep(1);
end
function ZMobDB_SetSlider(Slider,Table,Index)
	Slider:SetValue(ZMobDB_GetOption(Table,Index));
end
function ZMobDB_PainRateChanged(self)
	ZMobDB_SetOption("Settings","PainRate",self:GetValue());
	_G[self:GetName().."Text"]:SetText("Pain/Normal Rate:"..ZMobDB_GetOption("Settings","PainRate").."%");
end
function ZMobDB_RaidIcon_SizeChanged(self)
	ZMobDB_SetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RaidIcon_Size",self:GetValue());
	_G[self:GetName().."Text"]:SetText("Raid Icon Size:"..ZMobDB_GetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RaidIcon_Size").."%");
end
function ZMobDB_PvPIcon_SizeChanged(self)
	ZMobDB_SetOption(ZMobDB_GetOption("Settings","SelectUnit"),"PvPIcon_Size",self:GetValue());
	_G[self:GetName().."Text"]:SetText("PvP Icon Size:"..ZMobDB_GetOption(ZMobDB_GetOption("Settings","SelectUnit"),"PvPIcon_Size"));
end
function ZMobDB_AlphaRateChanged(self)
	ZMobDB_SetOption("Settings","AlphaRate",self:GetValue());
	_G[self:GetName().."Text"]:SetText("Stealth Alpha:"..ZMobDB_GetOption("Settings","AlphaRate").."%");
end
function ZMobDB_RandomAnimationRateChanged(self)
	ZMobDB_SetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RandomAnimation_Rate",self:GetValue());
end
function ZMobDB_RandomAnimationRateCombatChanged(self)
	ZMobDB_SetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RandomAnimation_Rate_Combat",self:GetValue());
end
function ZMobDB_RandomAnimationIntervalChanged(self)
	ZMobDB_SetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RandomAnimation_Interval",self:GetValue());
	_G[self:GetName().."Text"]:SetText("Interval:"..ZMobDB_GetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RandomAnimation_Interval").."sec");
end
function ZMobDB_RandomAnimationIntervalCombatChanged(self)
	ZMobDB_SetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RandomAnimation_Interval_Combat",self:GetValue());
	_G[self:GetName().."Text"]:SetText("Combat Interval:"..ZMobDB_GetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RandomAnimation_Interval_Combat").."sec");
end
function ZMobDB_CursorControl_IsEnabled(self)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	local id = ZMobDB_GetBoundingBox(self):GetID();
	return ZMobDB_Profile[ZMobDBPlayerIndex][id].cursorControls.isEnabled;
end

function ZMobDB_CursorControl_SetButton(bBox, controlName, mouseButton, keyModifier)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	local id = ZMobDB_GetBoundingBox(bBox):GetID();
	cc = ZMobDB_Profile[ZMobDBPlayerIndex][id].cursorControls;
	if (keyModifier == nil) then
		keyModifier = "NOKEY";
	end
	if (controlName ~= nil) then
		cc[mouseButton][keyModifier] = { ["name"] = controlName, ["isAvatar"] = bBox.isAvatar };
		cc.count = cc.count + 1;
		-- ZMobDB_SpecialEvent("CURSORCONTROL_ADDED", bBox, controlName, mouseButton, keyModifier);
	else
		cc[mouseButton][keyModifier] = nil;
		cc.count = cc.count - 1;
		if (cc.count < 0) then
			-- ZMobDB_GetBoundingBox(bBox):EnableMouse(false);
			cc.count = 0;
		end
		-- ZMobDB_SpecialEvent("CURSORCONTROL_REMOVED", bBox, controlName, mouseButton, keyModifier);
	end
end

function ZMobDB_CursorControl_SetActiveButton(self, mouseButton)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	local id = ZMobDB_GetBoundingBox(self):GetID();
	cc = ZMobDB_Profile[ZMobDBPlayerIndex][id].cursorControls;
	if (mouseButton == nil) then
		cc.active = nil;
		return;
	end
	if (IsAltKeyDown()) then
		keyModifier = "ALT";
		ZMobDB_db_changed = id;
	elseif (IsControlKeyDown()) then
		keyModifier = "CTRL";
		ZMobDB_db_changed = id;
	elseif (IsShiftKeyDown()) then
		keyModifier = "SHIFT";
		ZMobDB_db_changed = nil;
	else
		keyModifier = "NOKEY";
		ZMobDB_db_changed = nil;
	end
	if (IsAltKeyDown()) and mouseButton == "RightButton" then
		ZMobDB_db_changed = nil;
	end
	if (cc[mouseButton][keyModifier] ~= nil) then
		cc.active = cc[mouseButton][keyModifier];
	else
		cc.active = nil;
	end
end

function ZMobDB_CursorControl_GetActiveName(self)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	local id = ZMobDB_GetBoundingBox(self):GetID();
	return ZMobDB_Profile[ZMobDBPlayerIndex][id].cursorControls.active;
end

function ZMobDB_CursorControl_IsActive(self, controlName)
	local active = ZMobDB_CursorControl_GetActiveName(self);
	if (controlName ~= nil and active ~= nil and controlName == active.name) then
		return true;
	end
	return false;
end
function ZMobDB_Avatar_GetControlIntensity(self, modAmountPerUnit)
	boundryWidth = self:GetParent():GetWidth();
	boundryHeight = self:GetParent():GetHeight();
	if (boundryHeight == nil) then
		boundryHeight = boundryWidth;
	end
	local modAmount;
	if (modAmountPerUnit == nil) then
		modAmountPerUnit = 0;
	elseif (boundryWidth > boundryHeight) then
		modAmount = modAmountPerUnit / (boundryWidth / 100);
	elseif (boundryHeight <= 0) then
		-- Shouldn't be able (or want) to size to 0, but just in case.
		modAmount = modAmountPerUnit;
	else
		modAmount = modAmountPerUnit / (boundryHeight / 100);
	end
	return modAmount;
end

function ZMobDB_Avatar_GetControlConstraint(modify, min, max, loop)
	if (min ~= nil) then
		if (modify < min and not loop) then
			modify = min;
		elseif (modify < min and loop and max ~= nil) then
			modify = max;
		end
	end
	if (max ~= nil) then
		if (modify > max and not loop) then
			modify = max;
		elseif (modify > max and loop and min ~= nil) then
			modify = min;
		end
	end
	return modify;
end



-- ---------------------------------------------------------
-- Get Model Data Name
-- ---------------------------------------------------------
function ZMobDB_Get_Unit_File(avatar)
	
	local Unit_File = avatar:GetModelFileID();

	if (type(Unit_File) == "string") then
		while(strfind(Unit_File,"\\")) do
			Unit_File = strsub(Unit_File,strfind(Unit_File,"\\")+1);
		end
		Unit_File = gsub(Unit_File,"SCOURGE","undead");
		Unit_File = gsub(Unit_File,"scourge","undead");
		Unit_File = gsub(Unit_File,".M2","");
		Unit_File = gsub(Unit_File,".mdx","");
		Unit_File = gsub(Unit_File,"_HD","");

	else
		Unit_File = "No Model";
	end

	return Unit_File;
end
function ZMobDB_Get_UnitType(unittype)
	local Unit_type = nil;
	Unit_type = UnitCreatureFamily(unittype);
		if Unit_type == nil then
			Unit_type = UnitRace(unittype);
				if Unit_type ~= nil then
					if ZMobDB_GetOption("Settings","PvPMode") == "on" and UnitFactionGroup(unittype) then
						Unit_type = UnitFactionGroup(unittype).."_";
					else
						Unit_type = "Player_";
					end
				else
					Unit_type = UnitName(unittype);
						if Unit_type == nil then
							Unit_type = "default";
						else
							-- if ZMobDB_GetOption("Settings","SimpleMode") == "off" then
							-- 	Unit_type = Unit_type.."_";
							-- else
								Unit_type = "NPC_";
							-- end
						end
				end
		else
			Unit_type = "Creature_";
		end
		if ZMobDB_GetOption("Settings","ModelMode") == "on" then
			Unit_type = "Model_";
		end

	return Unit_type;
end
function ZMobDB_Get_db_name(db_name,Unit_File_name,stats)

	local db_select = db_name;

	if Unit_File_name ~= nil then
		local i = 1;
		if UnitFactionGroup("player") == "Alliance" then
			form_table = {"Model_","Creature_","Alliance_","Horde_","Player_","NPC_","Self_Alliance_","Self_Horde_","Self_Player_","Pet_Creature_","Pet_Alliance_","Pet_Horde_","Pet_Player_","Pet_NPC_"};
		else
			form_table = {"Model_","Creature_","Horde_","Alliance_","Player_","NPC_","Self_Horde_","Self_Alliance_","Self_Player_","Pet_Creature_","Pet_Horde_","Pet_Alliance_","Pet_Player_","Pet_NPC_"};
		end
		if not(ZMobDB_table[db_select]) then
			while (not(ZMobDB_table[db_select])) do
				if stats == "Normal" or stats == nil then
					db_select = form_table[i]..Unit_File_name;
				else
					db_select = form_table[i]..Unit_File_name.."_"..stats;
				end
				i = i + 1;
				if i > 14 then
					db_select = "default";
				end
			end
		end
	else
		db_select = "default";
	end
		return db_select;
end
function ZMobDB_Get_Unit_Aura(unittype)
	local i_Buff = 1;
	local i_DeBuff = 1;
	local Unit_word = ZMobDB_Unit_word[unittype];
	local Buff_name,Buff_Rank,DeBuff_name,DeBuff_Rank = nil;
	local Unit_Buff,Unit_DeBuff,Unit_Stealth = nil;
	local Unit_Shape = "Normal";
	
--	while (UnitBuff(unittype, i_Buff)) do
--		Buff_name,Buff_Rank = UnitBuff(unittype, i_Buff);
--			if Buff_name ~= nil then
--				for index,value in ipairs(ZMobDBBuff_Table) do
--					if 
--						string.find(Buff_name,value) and 
--						ZMobDB_GetOption(Unit_word,"Animation_"..ZMobDBBuff_Name[index]) == "on" 
--					then 
--						Unit_Buff = ZMobDBBuff_Name[index];
--					end
--				end
--				for index,value in ipairs(ZMobDBForm_Table) do
--					if string.find(Buff_name,value) then
--						Unit_Shape = ZMobDBForm_Name[index];
--					end
--				end
--				for index,value in ipairs(ZMobDBStealth_Table) do
--					if string.find(Buff_name,value) then
--						Unit_Stealth = ZMobDBStealth_Name[index];
--					end
--				end
--				if Buff_name == "Stealth" then
--					Unit_Stealth = "Stealth";
--				end
--			end
--		i_Buff = i_Buff + 1;
--	end
--	while (UnitDebuff(unittype, i_DeBuff)) do
--		DeBuff_name,DeBuff_Rank = UnitDebuff(unittype, i_DeBuff);
--			if 
--				DeBuff_name ~= nil and 
--				DeBuff_name ~= "Anesthetic Poison" 
--			then
--				for index,value in ipairs(ZMobDBDebuff_Table) do
--					if 
--						string.find(DeBuff_name,value) and 
--						ZMobDB_GetOption(Unit_word,"Animation_"..ZMobDBDebuff_Name[index]) == "on" 
--					then
--						Unit_DeBuff = ZMobDBDebuff_Name[index];
--					end
--				end
--				for index,value in ipairs(ZMobDBForm_Table) do
--					if string.find(DeBuff_name,value) then
--						Unit_Shape = ZMobDBForm_Name[index];
--					end
--				end
--			end
--		i_DeBuff = i_DeBuff + 1;
--	end

	return Unit_Buff,Unit_DeBuff,Unit_Shape,Unit_Stealth
end
function ZMobDB_GetStats(unittype)
	local Unit_word = ZMobDB_Unit_word[unittype];
	local Unit_Buff,Unit_DeBuff,Unit_Shape,Unit_Stealth = ZMobDB_Get_Unit_Aura(unittype);
	local stats = "Normal";
	if ZMobDB_GetOption(Unit_word,"EventAnimation") == "on" then
		if (UnitIsPlayer(unittype) or UnitName(unittype) == UnitName("pet")) then
			if UnitIsGhost(unittype) then
				stats = "Ghost";
			elseif 
				UnitIsDead(unittype) or 
				UnitIsFeignDeath(unittype) or 
				(UnitIsPlayer(unittype) and UnitHealth(unittype) == 0) 
			then
				stats = "Dead";
			elseif 
				Unit_Buff == "Rest" 
			then
				stats = "Rest";
			elseif 
				Unit_Shape == "Normal" and 
				((UnitIsPlayer(unittype) and 
				UnitIsFriend("player",unittype) and 
				UnitHealth(unittype) / UnitHealthMax(unittype) <= ZMobDB_GetOption("Settings","PainRate") / 100) or 
				(UnitIsPlayer(unittype) and 
				not(UnitIsFriend("player",unittype)) and 
				UnitHealth(unittype) <= ZMobDB_GetOption("Settings","PainRate") / 100)) 
			then
				stats = "Pain";
			elseif 
				UnitIsAFK(unittype) 
			then
				stats = "AFK";
			elseif 
				Unit_Stealth =="Stealth" 
			then
				stats = "Stealth";
			else
				stats = "Normal";
			end
		else
			stats = "Normal";
		end
		if stats ~= "Normal" then
			if ZMobDB_GetOption(Unit_word,"Animation_"..stats) == "off" then
				stats = "Normal";
			end
		end
		if Unit_Buff ~=nil and Unit_Buff ~= "Rest" then
			stats = Unit_Buff;
		end
		if Unit_DeBuff ~=nil then
			stats = Unit_DeBuff;
		end
		if 
			Unit_Buff =="Ice" and 
			ZMobDB_GetOption(Unit_word,"Animation_Ice") == "on" 
		then
			stats = "Ice";
		end
	end
	ZMobDB_Animation_stats[unittype].stats = stats;
	return stats,ZMobDB_Animation_stats[unittype].pre_stats,ZMobDB_Animation_stats[unittype].ghost_model;
end
function ZMobDB_GetModelSetting(avatar)
	local db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport;
	local unittype = ZMobDB_Avatar_GetUnitType(avatar);
	local UnitType = ZMobDB_Get_UnitType(unittype);
	local Unit_word = ZMobDB_Unit_word[unittype];
	local bBox = _G["ZMobDB_Camera9"];
	local stats,pre_stats,ghost_model = ZMobDB_GetStats(unittype);
	local stats_test = ZMobDB_GetOption("Settings","Select_Animation");
	local unittype_test = ZMobDB_GetOption("Settings","SelectUnit_Animation");
	bBox:GetChildren():ClearModel();
	bBox:GetChildren():SetUnit(unittype);
	-- bBox:GetChildren():SetCamera(2);
	bBox:GetChildren():SetPortraitZoom(0);
	local Unit_File = ZMobDB_Get_Unit_File(bBox:GetChildren());
	local Unit_File_name = Unit_File;
	if avatar:GetParent():GetID() == 20 then
		if (UnitIsPlayer(unittype) or UnitName(unittype) == UnitName("pet")) then
			stats = stats_test;
		else
			stats = "Normal";
		end
	end
		if Unit_File == "No Model" then
			db_name = "default";
		else
			db_name = UnitType..Unit_File;
		end
		if stats == "Ghost" then
			db_name = UnitType..ghost_model;
		end
		if 
			(stats == "Ice" or 
			stats == "Shackle" or 
			stats == "Fear" or 
			stats == "Cyclone" or 
			stats == "Seduce" or 
			stats == "Banish" or 
			stats == "Sleep" or 
			stats == "Shield" or 
			stats == "Bandage") 
		then
			db_name = "Spell";
		end
	if db_name ~= "Spell" and ZMobDB_GetOption(Unit_word,"Specific")=="on" and (avatar:GetParent():GetID() ~= 20) then
		if Unit_word == "player" then
			db_name = "Self_"..db_name;
		elseif Unit_word == "targettarget" then
			db_name = "ToT_"..db_name;
		elseif Unit_word == "pet" then
			db_name = "Pet_"..db_name;
		elseif Unit_word == "pettarget" then
			db_name = "PetTarget"..db_name;
		elseif Unit_word == "party" then
			db_name = "Party_"..db_name;
		elseif Unit_word == "partypet" then
			db_name = "PartyPet_"..db_name;
		elseif Unit_word == "partytarget" then
			db_name = "PartyTarget_"..db_name;
		elseif Unit_word == "focus" then
			db_name = "Focus_"..db_name;
		elseif Unit_word == "focustarget" then
			db_name = "FocusTarget_"..db_name;
		end
	end
	if db_name ~= "Spell" and (avatar:GetParent():GetID() == 20) then
		if unittype_test == "player" then
			db_name = "Self_"..db_name;
		elseif unittype_test == "targettarget" then
			db_name = "ToT_"..db_name;
		elseif unittype_test == "pet" then
			db_name = "Pet_"..db_name;
		elseif unittype_test == "pettarget" then
			db_name = "PetTarget"..db_name;
		elseif unittype_test == "party" then
			db_name = "Party_"..db_name;
		elseif unittype_test == "partypet" then
			db_name = "PartyPet_"..db_name;
		elseif unittype_test == "partytarget" then
			db_name = "PartyTarget_"..db_name;
		elseif unittype_test == "focus" then
			db_name = "Focus_"..db_name;
		elseif unittype_test == "focustarget" then
			db_name = "FocusTarget_"..db_name;
		end
	end
	if (avatar:GetParent():GetID() ~= 20) then
		if stats ~= "Normal" then
			db_name_ani = db_name.."_"..stats;
		end
		if avatar.random_anim ~= nil then
			db_name_ani = db_name.."_".."Random";
		end
	else
		if stats_test == "Random" then
			db_name_ani = db_name.."_".."Random";
		elseif stats_test ~= "Normal" then
			db_name_ani = db_name.."_"..stats_test;
		end
	end
		if avatar.random_anim ~= nil then
			db_select = ZMobDB_Get_db_name(db_name,Unit_File_name,"Random");
		else
			db_select = ZMobDB_Get_db_name(db_name,Unit_File_name,"Normal");
		end
		db_select_ani = ZMobDB_Get_db_name(db_name_ani,Unit_File_name,stats);
		db_zoom = ZMobDB_table[db_select].zoom;                                
		db_position = ZMobDB_table[db_select].position;
		db_rotation = ZMobDB_table[db_select].rotation;
		if ZMobDB_table[db_select].scale ~= nil then
			db_scale = ZMobDB_table[db_select].scale;
		else
			db_scale = 1;
		end
		if ZMobDB_table[db_select].autoport ~= nil then
			db_autoport = ZMobDB_table[db_select].autoport;
		else
			db_autoport = "off";
		end
		db_zoom_ani = ZMobDB_table[db_select_ani].zoom;                                
		db_position_ani = ZMobDB_table[db_select_ani].position;
		db_rotation_ani = ZMobDB_table[db_select_ani].rotation;
		if ZMobDB_table[db_select_ani].scale ~= nil then
			db_scale_ani = ZMobDB_table[db_select_ani].scale;
		else
			db_scale_ani = 1;
		end
	return db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport;
end

-- ---------------------------------------------------------
-- Model Event Set
-- ---------------------------------------------------------
function ZMobDB_Avatar_SetUnitType(avatar, unittype)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	if (unittype ~= nil) then
		ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.unitType = unittype;
		if (unittype == "player") then
			ZMobDB_Avatar_SetRendered(avatar, false); -- Force a refresh
			if (ZMobDB_BoundingBox_IsEnabled(avatar:GetParent())) then
				avatar:GetParent():Show();
			else
				avatar:GetParent():Hide();
			end
		else
			if (ZMobDB_BoundingBox_IsEnabled(avatar:GetParent())) then
				if (UnitExists(unittype)) then
					avatar:GetParent():Show();
				else
					avatar:GetParent():Hide();
				end
			end
		end
		ZMobDB_SpecialEvent("AVATAR_UNITTYPE_CHANGED", avatar);
	end
end
function ZMobDB_RegisterEvent(avatar, unittype)
	avatar:UnregisterAllEvents();
end
function ZMobDB_Tooltip_Unit(self)
	if ZMobDB_GetOption("Settings","Tooltip_Unit")=="on" then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetBackdropColor(0.3, 0.3, 0.3);
		GameTooltip:SetUnit(ZMobDB_Avatar_GetUnitType(_G["ZMobDB_Camera"..self:GetID()]:GetChildren()));
		if ZMobDB_GetOption("Settings","Tooltip")=="on" then
			if 
				ZMobDB_GetOption("Settings","Tooltip_onlyconfig")=="off" or 
				(ZMobDB_GetOption("Settings","Tooltip_onlyconfig")=="on" and _G["ZMobDB_Configuration"]:IsShown()) 
			then
				GameTooltip:AddLine("Ctrl+MouseLeft:Rotate/Zoom\nCtrl+MouseRight:Pan\n\nAlt+MouseLeft:Zoom\n\nShift+MouseLeft:MoveWindow\nShift+MouseRigtht:WindowSize\n\nShift+Ctrl+MouseLeft:Auto Portrait ON\nShift+Ctrl+MouseRigtht:Auto Portrait OFF\nShift+Ctrl+Alt+MouseLeft:Reset Model View", 1.0, 1.0, 1.0);
			end
		end
	elseif ZMobDB_GetOption("Settings","Tooltip")=="on" then
		if 
			ZMobDB_GetOption("Settings","Tooltip_onlyconfig")=="off" or 
			(ZMobDB_GetOption("Settings","Tooltip_onlyconfig")=="on" and _G["ZMobDB_Configuration"]:IsShown()) 
		then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetBackdropColor(0.3, 0.3, 0.3);
			GameTooltip:SetText("Ctrl+MouseLeft:Rotate/Zoom\nCtrl+MouseRight:Pan\n\nAlt+MouseLeft:Zoom\n\nShift+MouseLeft:MoveWindow\nShift+MouseRigtht:WindowSize\n\nShift+Ctrl+MouseLeft:Auto Portrait ON\nShift+Ctrl+MouseRigtht:Auto Portrait OFF\nShift+Ctrl+Alt+MouseLeft:Reset Model View", 1.0, 1.0, 1.0);
		end
	end
end

function ZMobDB_Mouseover_OnEnter(self)
	local Strata_temp = self:GetFrameStrata();
	local Strara_set = ZMobDB_GetOption(ZMobDB_Unit_word[ZMobDB_Avatar_GetUnitType(self:GetChildren())],"Strata");

	if Strata_temp ~= "BACKGROUND" then
		if Strata_set ~= "BACKGROUND" then
			self:SetFrameStrata("BACKGROUND");
		end
	else
		if Strata_set ~= "BACKGROUND" then
			self:SetFrameStrata(Strara_set);
		end
	end
end
function ZMobDB_copy_to()
	if UnitExists("target") then
		if ZMobDB_GetOption("Settings","CopyEntry") ~= "" then
			DEFAULT_CHAT_FRAME:AddMessage("Copy Model Setting:"..ZMobDB_GetOption("Settings","TargetData")..">>"..ZMobDB_GetOption("Settings","CopyEntry"));
			if (ZMobDB_table[ZMobDB_GetOption("Settings","TargetData")].scale ==nil) then ZMobDB_table[ZMobDB_GetOption("Settings","TargetData")].scale = 1; end

			ZMobDB_table[ZMobDB_GetOption("Settings","CopyEntry")] = { 
			scale = ZMobDB_table[ZMobDB_GetOption("Settings","TargetData")].scale,
			zoom = ZMobDB_table[ZMobDB_GetOption("Settings","TargetData")].zoom,
			rotation = ZMobDB_table[ZMobDB_GetOption("Settings","TargetData")].rotation,
			position = ZMobDB_table[ZMobDB_GetOption("Settings","TargetData")].position,
			autoport = ZMobDB_table[ZMobDB_GetOption("Settings","TargetData")].autoport,
			}
		else
			DEFAULT_CHAT_FRAME:AddMessage("Needs Data Name(Undead_male etc.)");
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("self Command Needs Target");
	end
end
function ZMobDB_copy_from()
	if UnitExists("target") then
		if UnitExists("target") then
			if ZMobDB_table[ZMobDB_GetOption("Settings","CopyEntry")] then
				DEFAULT_CHAT_FRAME:AddMessage("Copy Model Setting:"..ZMobDB_GetOption("Settings","TargetData").."<<"..ZMobDB_GetOption("Settings","CopyEntry"));
			if (ZMobDB_table[ZMobDB_GetOption("Settings","CopyEntry")].scale ==nil) then ZMobDB_table[ZMobDB_GetOption("Settings","CopyEntry")].scale = 1; end

				ZMobDB_table[ZMobDB_GetOption("Settings","TargetData")] = { 
				scale = ZMobDB_table[ZMobDB_GetOption("Settings","CopyEntry")].scale,
				zoom = ZMobDB_table[ZMobDB_GetOption("Settings","CopyEntry")].zoom,
				rotation = ZMobDB_table[ZMobDB_GetOption("Settings","CopyEntry")].rotation,
				position = ZMobDB_table[ZMobDB_GetOption("Settings","CopyEntry")].position,
				autoport = ZMobDB_table[ZMobDB_GetOption("Settings","CopyEntry")].autoport,
				}
			else
				DEFAULT_CHAT_FRAME:AddMessage("Can't Find Data:"..ZMobDB_GetOption("Settings","CopyEntry"));
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("self Command Needs Target");
		end
	else
				DEFAULT_CHAT_FRAME:AddMessage("Needs Target and Data Name(Undead_male etc.)");
	end
end
function ZMobDB_delete_data()
	if UnitExists("target") then
		if ZMobDB_GetOption("Settings","TargetData") == "default" then
			DEFAULT_CHAT_FRAME:AddMessage("Target Now Use Default Set:");
		else
			DEFAULT_CHAT_FRAME:AddMessage("Delete Data:"..ZMobDB_GetOption("Settings","TargetData"));
			ZMobDB_table[ZMobDB_GetOption("Settings","TargetData")] = nil;
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("self Command needs Target");
	end
end
-- ---------------------------------------------------------
-- Box Position,Size Option
-- ---------------------------------------------------------
function ZMobDB_ChangeBoxSize(self)
	if ZMobDB_GetOption("Settings","HoldBox")=="on" then
		DEFAULT_CHAT_FRAME:AddMessage("Can't Change Box Size/Position while Hold Windows ON");
	else
		local i = _G["ZMobDB_Frame_"..ZMobDB_GetOption("Settings","SelectBox")]:GetID();
		ZMobDB_BoundingBox_SetScale(_G["ZMobDB_Camera"..i],_G["ZMobDB_Configuration_Controls_Panel_BoxSize_x"]:GetNumber(),_G["ZMobDB_Configuration_Controls_Panel_BoxSize_y"]:GetNumber())
		local j = _G["ZMobDB_Frame_"..ZMobDB_GetOption("Settings","SelectBox")]:GetID();
		local x = _G["ZMobDB_Camera"..j]:GetWidth();
		local y = _G["ZMobDB_Camera"..j]:GetHeight();
		_G["ZMobDB_Configuration_Controls_Panel_BoxSize_x_Text"]:SetText("X:"..x);
		_G["ZMobDB_Configuration_Controls_Panel_BoxSize_y_Text"]:SetText("Y:"..y);
	end
end
function ZMobDB_ChangeBoxPosition(move)
	local changeX = 0;
	local changeY = 0;
	if ZMobDB_GetOption("Settings","HoldBox")=="on" then
		DEFAULT_CHAT_FRAME:AddMessage("Can't Change Box Size/Position while Hold Windows ON");
	else
		if move == "up" then
			changeY = 1;
		elseif move == "down" then
			changeY = -1;
		elseif move == "left" then
			changeX = -1;
		elseif move == "right" then
			changeX = 1;
		end
		local i = _G["ZMobDB_Frame_"..ZMobDB_GetOption("Settings","SelectBox")]:GetID();
		ZMobDB_BoundingBox_SetPosition(_G["ZMobDB_Camera"..i],_G["ZMobDB_Camera"..i]:GetLeft() + changeX,_G["ZMobDB_Camera"..i]:GetBottom() + changeY);

	end
end
function ZMobDB_ChangeIconPosition(move)
	local Unit_word = ZMobDB_Unit_word[ZMobDB_GetOption("Settings","SelectBox")];
	local PositionX = ZMobDB_GetOption(Unit_word,"PvPIcon_PositionX");
	local PositionY = ZMobDB_GetOption(Unit_word,"PvPIcon_PositionY");
	if move == "up" then
		PositionY = PositionY + 1;
	elseif move == "down" then
		PositionY = PositionY - 1;
	elseif move == "left" then
		PositionX = PositionX - 1;
	elseif move == "right" then
		PositionX = PositionX + 1;
	end
	ZMobDB_SetOption(Unit_word,"PvPIcon_PositionX",PositionX);
	ZMobDB_SetOption(Unit_word,"PvPIcon_PositionY",PositionY);
	for i = 0,19 do
		if i ~= 9 then
			ZMobDB_Change_RaidIcon(_G["ZMobDB_Camera"..i]:GetChildren())
		end
	end
end
-- ---------------------------------------------------------
-- Profile
-- ---------------------------------------------------------
function ZMobDB_GetPlayerIndex()
	return ZMobDBPlayerIndex
end

function ZMobDB_UpdateProfileList(topIndex)
	for ind=1, 10 do
		--Clears all 10 list elements.
		_G["ZMobDB_Configuration_Profile_Panel_Entry"..ind.."_Text"]:SetText("")
		_G["ZMobDB_Configuration_Profile_Panel_Entry"..ind].profile=""
		_G["ZMobDB_Configuration_Profile_Panel_Entry"..ind]:Hide()
	end
	i=1
	j=1
	for index, entry in pairs(ZMobDB_Options_4) do
		if(i>=topIndex) and (i<topIndex+10)then
			--Displays the topIndex's element through to the topIndex+12'th element in the list
			dot=string.find(index, "%.")
			
			_G["ZMobDB_Configuration_Profile_Panel_Entry"..j].stringName=string.sub(index, 1, dot-1).." of "..string.sub(index, dot+1)
			_G["ZMobDB_Configuration_Profile_Panel_Entry"..j.."_Text"]:SetText(_G["ZMobDB_Configuration_Profile_Panel_Entry"..j].stringName)
			_G["ZMobDB_Configuration_Profile_Panel_Entry"..j].profile=index
			_G["ZMobDB_Configuration_Profile_Panel_Entry"..j]:Show()
			j=j+1
		end
		i=i+1
	end

	if(i<=10)then
		--the entire list will be displayed on a single, un-scrolling list.
		ZMobDB_Configuration_Profile_Panel_Scroller:SetMinMaxValues(1,1)
	else		
		--The list will require scrolling.
		ZMobDB_Configuration_Profile_Panel_Scroller:SetMinMaxValues(1,i-10)
	end
end
function ZMobDB_PasteProfile(newName)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	for index, entry in pairs(ZMobDBVar_CopiedProfile)do
		ZMobDB_Options_4[newName][index]=ZMobDBVar_CopiedProfile[index]
	end
	for index, entry in pairs(ZMobDBVar_CopiedProfile_2)do
		ZMobDB_Profile[newName][index]=ZMobDBVar_CopiedProfile_2[index]
	end
	if(newName==ZMobDBPlayerIndex)then 
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:Some changes may require logout before taking effect");
		ZMobDB_Option_Change()
	end
end
function ZMobDB_DeleteProfile(profileName)
	ZMobDB_Options_4[profileName]=nil
	ZMobDB_Profile[profileName]=nil
end
function ZMobDB_CopyProfile(profileName)
	ZMobDBVar_CopiedProfile={}
	ZMobDBVar_CopiedProfile_2={}
	for index, entry in pairs(ZMobDB_Options_4[profileName]) do
		ZMobDBVar_CopiedProfile[index]=ZMobDB_Options_4[profileName][index]
	end
	for index, entry in pairs(ZMobDB_Profile[profileName]) do
		ZMobDBVar_CopiedProfile_2[index]=ZMobDB_Profile[profileName][index]
	end
end
function ZMobDB_BackupProfile()
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	ZMobDB_Backup={};
	ZMobDB_Backup["table"]={};
	ZMobDB_Backup["Options"]={};
	ZMobDB_Backup["Profile"]={};
	for index, entry in pairs(ZMobDB_table) do
		ZMobDB_Backup["table"][index]=ZMobDB_table[index]
	end
	for index, entry in pairs(ZMobDB_Options_4[ZMobDBPlayerIndex]) do
		ZMobDB_Backup["Options"][index]=ZMobDB_Options_4[ZMobDBPlayerIndex][index]
	end
	for index, entry in pairs(ZMobDB_Profile[ZMobDBPlayerIndex]) do
		ZMobDB_Backup["Profile"][index]=ZMobDB_Profile[ZMobDBPlayerIndex][index]
	end
	DEFAULT_CHAT_FRAME:AddMessage("BackUp Current Setting/DataBase to Charactor's Profile");
end
-- ---------------------------------------------------------
-- Animation Test Box
-- ---------------------------------------------------------
function ZMobDB_AnimationTest_StartButton()
	-- if (UnitIsPlayer("target")) then
		ZMobDB_Avatar_ModelUpdate(_G["ZMobDB_Camera20"]:GetChildren(),true)
		ZMobDB_ChangeModel(_G["ZMobDB_Camera20"]:GetChildren());
	-- end
end
