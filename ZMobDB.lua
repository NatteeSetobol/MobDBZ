-- ---------------------------------------------------------
-- Main Init
-- ---------------------------------------------------------
local Box_name0 = nil;
local Box_name1 = nil;
local Box_name2 = nil;
local Box_name3 = nil;
local Box_name4 = nil;
local Box_name5 = nil;
local Box_name6 = nil;
local Box_name7 = nil;
local Box_name8 = nil;
local Box_name10 = nil;
local Box_name11 = nil;
local Box_name12 = nil;
local Box_name13 = nil;
local Box_name14 = nil;
local Box_name15 = nil;
local Box_name16 = nil;
local Box_name17 = nil;
local Box_name18 = nil;
local Box_name19 = nil;
local Timer_Count = 0;
local Update_Count = 0;
local Update_Count_sub = 0;
local Option_Count = 0;
local unitwatch;
ZMobDB_Options_4={};
ZMobDB_Profile={};
ZMobDB_CursorX,     ZMobDB_CursorY     = nil, nil;
ZMobDB_CursorMoveX, ZMobDB_CursorMoveY = nil, nil;
ZMobDB_Animation_stats={};
local RefreshBoundingBox_loaded = nil;
local Option_Change_loaded = nil;
local Config_OnShow = 0;
local ZMobDB_Avatar_Main_OnEvent = {};		-- event manager

-- ---------------------------------------------------------
-- Load/Save Option Setting
-- ---------------------------------------------------------
function ZMobDB_setup()

	local cameras_index = 0;
	local name_config = "ZMobDB_Configuration"
	local Config_window = _G[name_config]

	Config_window.background = Config_window:CreateTexture(nil, "BACKGROUND")
	Config_window.background:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	Config_window.background:SetVertexColor(0.0, 1.0, 0.0, 0.5)

	Config_window.background:SetAllPoints(Config_window)


	SetBackdrop("ZMobDB_Configuration","Interface\\DialogFrame\\UI-DialogBox-Background",0,1.0,0,0.5)

	for i=0,19 do
		SetBackdrop("ZMobDB_Camera" .. tostring(i), "Interface\\Tooltips\\UI-Tooltip-Background", 1,1,1,0.5)
	end

	local name_Copyto_Dialog = "ZMobDB_Copyto_Dialog"
	local Copyto_Dialog = _G[name_Copyto_Dialog]

	Copyto_Dialog.background = Copyto_Dialog:CreateTexture(nil, "BACKGROUND")
	Copyto_Dialog.background:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	Copyto_Dialog.background:SetVertexColor(0.0, 1.0, 0.0, 0.5)

	Copyto_Dialog.background:SetAllPoints(Copyto_Dialog)


	--SetBackdrop("ZMobDB_Copyto_Dialog","Interface\\DialogFrame\\UI-DialogBox-Background",0,0,0,0.5)
	local name_AnimationTest_Dialog = "ZMobDB_AnimationTest_Dialog"
	local AnimationTest_Dialog = _G[name_AnimationTest_Dialog]

	AnimationTest_Dialog.background = AnimationTest_Dialog:CreateTexture(nil, "BACKGROUND")
	AnimationTest_Dialog.background:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	AnimationTest_Dialog.background:SetVertexColor(0.0, 1.0, 0.0, 0.5)

	AnimationTest_Dialog.background:SetAllPoints(AnimationTest_Dialog)

	--SetBackdrop("ZMobDB_AnimationTest_Dialog","Interface\\DialogFrame\\UI-DialogBox-Background",1,1,1,0.5)




	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	ZMobDBoption=nil
	if(not ZMobDB_Backup)then ZMobDB_Backup={}; end
	if(ZMobDB_Options_4==nil) then ZMobDB_Options_4={} end
	if(ZMobDB_Options_4[ZMobDBPlayerIndex]==nil) then
		ZMobDB_Options_4[ZMobDBPlayerIndex]={}
		ZMobDB_Options_4[ZMobDBPlayerIndex]["Settings"]={}
		for index,value in ipairs(ZMobDB_Unit_table) do
			ZMobDB_Options_4[ZMobDBPlayerIndex][value]={}
		end
		if(ZMobDB_Backup["Options"]==nil) then
			ZMobDB_SetupDefaultProfile(ZMobDBPlayerIndex,"default")
		else
			for index, entry in pairs(ZMobDB_Backup["Options"]) do
				ZMobDB_Options_4[ZMobDBPlayerIndex][index]=ZMobDB_Backup["Options"][index]
			end
		end
	end

	ZMobDB_Options_Temp={}
	ZMobDB_Options_Temp[ZMobDBPlayerIndex]={}
	ZMobDB_SetupDefaultProfile(ZMobDBPlayerIndex,"temp")

	ZMobDB_Animation_stats={}
	for index,value in ipairs(ZMobDB_Unittype_table) do
		ZMobDB_Animation_stats[value]={}
	end
	for index,value in ipairs(ZMobDB_Unittype_table) do
		ZMobDB_SetupAnimationStats(ZMobDB_Animation_stats,value)
	end

	if (ZMobDB_table==nil) then
		ZMobDB_table={}
		ZMobDB_table["default"]={}
		ZMobDB_table["default"]={ scale = 1,zoom = 0,position = {0,0},rotation = 0,autoport = "off", }
		if not(ZMobDB_Backup["table"]==nil) then
			for index, entry in pairs(ZMobDB_Backup["table"]) do
				ZMobDB_table[index]=ZMobDB_Backup["table"][index]
			end
		end
	end

	local frame = _G["ZMobDB_Camera9"];
	frame:GetChildren():ClearModel();
	frame:GetChildren():SetUnit("player");

	if(ZMobDB_Profile==nil) then ZMobDB_Profile={} end
	if ZMobDB_GetOption("Settings","ResetSwitch") == "on" then
		ZMobDB_Profile[ZMobDBPlayerIndex] = nil;
		ZMobDB_SetOption("Settings","ResetSwitch","off");
	end
	if(ZMobDB_Profile[ZMobDBPlayerIndex]==nil) then
		ZMobDB_Profile[ZMobDBPlayerIndex]={}
		if(ZMobDB_Backup["Profile"]==nil) then
			ZMobDB_Profile[ZMobDBPlayerIndex] = ZMobDB_Settings_CreateProfile();
		else
			for index, entry in pairs(ZMobDB_Backup["Profile"]) do
				ZMobDB_Profile[ZMobDBPlayerIndex][index]=ZMobDB_Backup["Profile"][index]
			end
		end
	end
end

function SetBackdrop(Element_Name, TexturesPath, red,blue,green,alpha)
	local name_config = Element_Name
	local Config_window = _G[name_config]

	-- Create background texture
	Config_window.background = Config_window:CreateTexture(nil, "BACKGROUND")
	Config_window.background:SetTexture(TexturePath)
	Config_window.background:SetVertexColor(red, blue, green, alpha)

	-- Set the anchors to fill the frame
	Config_window.background:SetAllPoints(Config_window)
end

function ZMobDB_SaveData(bBox)
	local db_name = bBox.DataName;
	local unittype = ZMobDB_Avatar_GetUnitType(bBox:GetChildren());
	if db_name ~= nil and db_name ~="default" and ZMobDB_db_changed ~= nil and UnitExists(unittype) then
		DEFAULT_CHAT_FRAME:AddMessage("Update Model Setting :"..db_name);
		ZMobDB_db_changed = nil;
		local h, v = ZMobDB_Avatar_GetPosition(bBox:GetChildren());
		ZMobDB_table[db_name] = { 
			scale = ZMobDB_Avatar_GetScale(bBox:GetChildren()),
			zoom = ZMobDB_Avatar_GetZoom(bBox:GetChildren()),
			rotation = ZMobDB_Avatar_GetRotation(bBox:GetChildren()),
			position = {h,v},
			autoport = bBox:GetChildren().port,
		}
	end
end

-- ---------------------------------------------------------
-- Main Event Handle
-- ---------------------------------------------------------
function ZMobDB_Avatar_Main_OnEvent:ADDON_LOADED()

	ZMobDB_setup();
end
function ZMobDB_Avatar_Main_OnEvent:PLAYER_ENTERING_WORLD()
	local name_config = "ZMobDB_Configuration";
	local Config_Window = _G[name_config];

	ZMobDB_Option_Change();
	if 
		ZMobDB_GetOption("Settings","HideInRaid") == "on" and 
		IsInRaid() and 
		not(Config_Window:IsShown()) 
	then
		if unitwatch == "on" then
			for i=2,5 do
				local name_camera = "ZMobDB_Camera"..i;
				local frame = _G[name_camera];
				frame:Hide();
			end
			for i=10,13 do
				local name_camera = "ZMobDB_Camera"..i;
				local frame = _G[name_camera];
				frame:Hide();
			end
			for i=15,18 do
				local name_camera = "ZMobDB_Camera"..i;
				local frame = _G[name_camera];
				frame:Hide();
			end
			for i=1,4 do
				local name_camera = "ZMobDB_Frame_party"..i;
				local name_camera_targtet = "ZMobDB_Frame_party"..i.."target";
				local name_camera_pet = "ZMobDB_Frame_party"..i.."pet";
				local frame = _G[name_camera];
				local frame_target = _G[name_camera_target];
				local frame_pet = _G[name_camera_pet];
				UnregisterUnitWatch(frame);
				frame:Hide();
				UnregisterUnitWatch(frame_target);
				frame_target:Hide();
				UnregisterUnitWatch(frame_pet);
				frame_pet:Hide();
			end
			unitwatch = "off";
		end
	end
end
function ZMobDB_Avatar_Main_OnEvent:UNIT_PORTRAIT_UPDATE(arg1)
	if (type(arg1) == "string") then
		if not(string.find(arg1,"raid")) then
			local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar(arg1);
			if avatar_unit ~= nil then
				ZMobDB_Avatar_ModelUpdate(avatar_unit,true);
				ZMobDB_ChangeModel(avatar_unit,true);
			end
		end
	end
end
function ZMobDB_Avatar_Main_OnEvent:UNIT_TARGET(arg1)
	if (type(arg1) == "string") then
		if not(string.find(arg1,"raid")) and not(string.find(arg1,"player")) then
			local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar(arg1);
			if avatar_unit ~= nil then
				ZMobDB_Avatar_ModelUpdate(avatar_unit,true);
				ZMobDB_ChangeModel(avatar_unit,true);
			end
			if avatar_target ~= nil then
				ZMobDB_Avatar_ModelUpdate(avatar_target,true);
				ZMobDB_ChangeModel(avatar_target,true);
				ZMobDB_Change_RaidIcon(avatar_target);
			end
		end
	end
end
function ZMobDB_Avatar_Main_OnEvent:UNIT_MODEL_CHANGED(arg1)
	if (type(arg1) == "string") then
		if not(string.find(arg1,"raid")) then
			local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar(arg1);
			if avatar_unit ~= nil then
				ZMobDB_Avatar_ModelUpdate(avatar_unit,true);
				ZMobDB_ChangeModel(avatar_unit,true);
			end
		end
	end
end
function ZMobDB_Avatar_Main_OnEvent:PLAYER_DEAD()
	local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar("player");
	if avatar_unit ~= nil then
		ZMobDB_EventAnimation(avatar_unit,"player");
		ZMobDB_ChangeModel(avatar_unit);
	end
end
function ZMobDB_Avatar_Main_OnEvent:PLAYER_ALIVE()
	local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar("player");
	if avatar_unit ~= nil then
		ZMobDB_EventAnimation(avatar_unit,"player");
		ZMobDB_ChangeModel(avatar_unit);
	end
end
function ZMobDB_Avatar_Main_OnEvent:PLAYER_UNGHOST()
	local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar("player");
	if avatar_unit ~= nil then
		ZMobDB_EventAnimation(avatar_unit,"player");
		ZMobDB_ChangeModel(avatar_unit);
	end
end
function ZMobDB_Avatar_Main_OnEvent:GROUP_ROSTER_UPDATE()
	if IsInRaid() then
		ZMobDB_Avatar_Main_OnEvent:RAID_ROSTER_UPDATE()
	elseif IsInGroup() then
		ZMobDB_Avatar_Main_OnEvent:PARTY_MEMBERS_CHANGED()
	end
end
function ZMobDB_Avatar_Main_OnEvent:RAID_ROSTER_UPDATE()
	local name_config = "ZMobDB_Configuration";
	local Config_Window = _G[name_config];
	if 
		ZMobDB_GetOption("Settings","HideInRaid") == "on" and 
		not(Config_Window:IsShown()) 
	then
			if unitwatch == "on" then
				for i=2,5 do
					local name_camera = "ZMobDB_Camera"..i;
					local frame = _G[name_camera];
					frame:Hide();
				end
				for i=10,13 do
					local name_camera = "ZMobDB_Camera"..i;
					local frame = _G[name_camera];
					frame:Hide();
				end
				for i=15,18 do
					local name_camera = "ZMobDB_Camera"..i;
					local frame = _G[name_camera];
					frame:Hide();
				end
				for i=1,4 do
					local name_camera = "ZMobDB_Frame_party"..i;
					local name_camera_targtet = "ZMobDB_Frame_party"..i.."target";
					local name_camera_pet = "ZMobDB_Frame_party"..i.."pet";
					local frame = _G[name_camera];
					local frame_target = _G[name_camera_target];
					local frame_pet = _G[name_camera_pet];
					UnregisterUnitWatch(frame);
					frame:Hide();
					UnregisterUnitWatch(frame_target);
					frame_target:Hide();
					UnregisterUnitWatch(frame_pet);
					frame_pet:Hide();
				end
				unitwatch = "off";
			end
	elseif ZMobDB_GetOption("Settings","HoldBox") == "on" then
		if unitwatch ~= "on" then
			for i=1,4 do
				local name_camera = "ZMobDB_Frame_party"..i;
				local name_camera_targtet = "ZMobDB_Frame_party"..i.."target";
				local name_camera_pet = "ZMobDB_Frame_party"..i.."pet";
				local frame = _G[name_camera];
				local frame_target = _G[name_camera_target];
				local frame_pet = _G[name_camera_pet];
				if ZMobDB_GetOption("party","Show") == "on" then
					RegisterUnitWatch(frame);
				end
				if ZMobDB_GetOption("partytarget","Show") == "on" then
					RegisterUnitWatch(frame_target);
				end
				if ZMobDB_GetOption("partypet","Show") == "on" then
					RegisterUnitWatch(frame_pet);
				end
			end
		end
		unitwatch = "on";
	end
end
function ZMobDB_Avatar_Main_OnEvent:PARTY_MEMBERS_CHANGED()
	local name_config = "ZMobDB_Configuration";
	local Config_Window = _G[name_config];
	if (ZMobDB_GetOption("Settings","HideInRaid") == "on") and IsInRaid() and not(Config_Window:IsShown()) then
		for i=2,5 do
			local name_camera = "ZMobDB_Camera"..i;
			local frame = _G[name_camera];
			frame:Hide();
		end
		for i=10,13 do
			local name_camera = "ZMobDB_Camera"..i;
			local frame = _G[name_camera];
			frame:Hide();
		end
		for i=15,18 do
			local name_camera = "ZMobDB_Camera"..i;
			local frame = _G[name_camera];
			frame:Hide();
		end
	else
		for i=2,5 do
			local name_camera = "ZMobDB_Camera"..i;
			local frame = _G[name_camera];
			ZMobDB_Avatar_ModelUpdate(frame:GetChildren());
			ZMobDB_ChangeModel(frame:GetChildren());
			ZMobDB_Change_RaidIcon(frame:GetChildren());
		end
		for i=10,13 do
			local name_camera = "ZMobDB_Camera"..i;
			local frame = _G[name_camera];
			ZMobDB_Avatar_ModelUpdate(frame:GetChildren());
			ZMobDB_ChangeModel(frame:GetChildren());
			ZMobDB_Change_RaidIcon(frame:GetChildren());
		end
		for i=15,18 do
			local name_camera = "ZMobDB_Camera"..i;
			local frame = _G[name_camera];
			ZMobDB_Avatar_ModelUpdate(frame:GetChildren());
			ZMobDB_ChangeModel(frame:GetChildren());
			ZMobDB_Change_RaidIcon(frame:GetChildren());
		end
	end

	if ZMobDB_GetOption("Settings","HoldBox") == "on" then
		if unitwatch ~= "on" then
			for i=1,4 do
				local name_camera = "ZMobDB_Frame_party"..i;
				local name_camera_targtet = "ZMobDB_Frame_party"..i.."target";
				local name_camera_pet = "ZMobDB_Frame_party"..i.."pet";
				local frame = _G[name_camera];
				local frame_target = _G[name_camera_target];
				local frame_pet = _G[name_camera_pet];
				if ZMobDB_GetOption("party","Show") == "on" then
					RegisterUnitWatch(frame);
				end
				if ZMobDB_GetOption("partytarget","Show") == "on" then
					RegisterUnitWatch(frame_target);
				end
				if ZMobDB_GetOption("partypet","Show") == "on" then
					RegisterUnitWatch(frame_pet);
				end
			end
		end
		unitwatch = "on";
	end
end
function ZMobDB_Avatar_Main_OnEvent:UNIT_PET(arg1)
	if (type(arg1) == "string") then
		if not(string.find(arg1,"raid")) then
			local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar(arg1);
			if avatar_pet ~= nil then
				ZMobDB_Avatar_ModelUpdate(avatar_pet);
				ZMobDB_ChangeModel(avatar_pet);
				ZMobDB_Change_RaidIcon(avatar_pet);
			end
			if arg1 == "player" then
				local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar("pet");
				ZMobDB_Avatar_ModelUpdate(avatar_target,true);
				ZMobDB_ChangeModel(avatar_target,true);
				ZMobDB_Change_RaidIcon(avatar_target);
			end
		end
	end
end
function ZMobDB_Avatar_Main_OnEvent:PLAYER_TARGET_CHANGED()
	local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar("target");
	if avatar_unit ~= nil then
		ZMobDB_Avatar_ModelUpdate(avatar_unit,true);
		ZMobDB_ChangeModel(avatar_unit,true);
		ZMobDB_Change_RaidIcon(avatar_unit);
	end
	if avatar_target ~= nil then
		ZMobDB_Avatar_ModelUpdate(avatar_target,true);
		ZMobDB_ChangeModel(avatar_target,true);
		ZMobDB_Change_RaidIcon(avatar_target);
	end
end
function ZMobDB_Avatar_Main_OnEvent:PLAYER_FOCUS_CHANGED()
	local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar("focus");
	if avatar_unit ~= nil then
		ZMobDB_Avatar_ModelUpdate(avatar_unit);
		ZMobDB_ChangeModel(avatar_unit,true);
		ZMobDB_Change_RaidIcon(avatar_unit);
	end
	if avatar_target ~= nil then
		ZMobDB_Avatar_ModelUpdate(avatar_target);
		ZMobDB_ChangeModel(avatar_target,true);
		ZMobDB_Change_RaidIcon(avatar_target);
	end
end
function ZMobDB_Avatar_Main_OnEvent:UNIT_HEALTH(arg1)
	if (type(arg1) == "string") then
		if not(string.find(arg1,"raid")) then
			local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar(arg1);
			if avatar_unit ~= nil then
				ZMobDB_EventAnimation(avatar_unit,ZMobDB_Avatar_GetUnitType(avatar_unit));
				ZMobDB_ChangeModel(avatar_unit);
			end
		end
	end
end
function ZMobDB_Avatar_Main_OnEvent:PLAYER_FLAGS_CHANGED(arg1)
	if (type(arg1) == "string") then
		if not(string.find(arg1,"raid")) then
			local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar(arg1);
			if avatar_unit ~= nil then
				ZMobDB_EventAnimation(avatar_unit,ZMobDB_Avatar_GetUnitType(avatar_unit));
				ZMobDB_ChangeModel(avatar_unit);
			end
		end
	end
end
function ZMobDB_Avatar_Main_OnEvent:UNIT_AURA(arg1)
	if (type(arg1) == "string") then
		if not(string.find(arg1,"raid")) then
			local avatar_unit,avatar_target,avatar_pet,avatar_focus = ZMobDB_GetAvatar(arg1);
			if avatar_unit ~= nil then
				ZMobDB_EventAnimation(avatar_unit,ZMobDB_Avatar_GetUnitType(avatar_unit));
				ZMobDB_ChangeModel(avatar_unit);
			end
		end
	end
end
function ZMobDB_Avatar_Main_OnEvent:RAID_TARGET_UPDATE()
	for i=0,18 do
		if i~=9 then
			local name_camera = "ZMobDB_Camera"..i;
			local frame = _G[name_camera];
			ZMobDB_Change_RaidIcon(frame:GetChildren());
		end
	end
end
-- ---------------------------------------------------------
-- Model Update
-- ---------------------------------------------------------
function ZMobDB_Avatar_OnEvent(avatar)
	local name_config = "ZMobDB_Configuration";
	local Config_window = _G[name_config];
	local id = avatar:GetParent():GetID();
	if (ZMobDB_BoundingBox_IsEnabled(avatar:GetParent())) then
			if (UnitExists(ZMobDB_Avatar_GetUnitType(avatar))) then
				avatar:GetParent():Show();
				if not(Config_window:IsShown()) then
					ZMobDB_Avatar_SetRendered(avatar, false);
					ZMobDB_Avatar_AttemptToRender(avatar, true);
					ZMobDB_Avatar_Refresh(avatar);
				end
			end
	end
	if Config_window:IsShown() then
		for i=0,19 do
			if i ~= 9 then
				local name_camera = "ZMobDB_Camera"..i;
				local camera = _G[name_camera];
				ZMobDB_Avatar_SetRendered(camera:GetChildren(), false);
				ZMobDB_Avatar_AttemptToRender(camera:GetChildren(), true);
			end
		end
	end
end
-- ---------------------------------------------------------
-- Target
-- ---------------------------------------------------------
function ZMobDB_Avatar_ModelUpdate(avatar,OnShow)
	local db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport;
	local unittype = ZMobDB_Avatar_GetUnitType(avatar);
	local Unit_word = ZMobDB_Unit_word[unittype];
	local stats,pre_stats,ghost_model = ZMobDB_GetStats(unittype);
	local stats_test = ZMobDB_GetOption("Settings","Select_Animation");
	local name_camera = "ZMobDB_Camera9";
	local bBox = _G[name_camera];
	local Unit_Name = ZMobDB_Animation_stats[unittype].UnitName;
	local Data_Select = ZMobDB_Animation_stats[unittype].DataSelect;
	local config_name = "ZMobDB_Configuration";
	local Config_Window = _G[config_name];
	if ZMobDB_GetOption(Unit_word,"Show") =="on" and avatar:GetParent():GetID() ~= 20 and avatar:GetParent():GetID() ~= 9 then
		if unittype == "target" and avatar:GetParent():GetID() == 1 then
			if UnitExists(unittype) then
				avatar:GetParent():Show();
				db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport = ZMobDB_GetModelSetting(avatar);
				if stats == "Normal" and avatar.random_anim == nil then
					avatar.animationNo = nil;
					avatar.nextNo = nil;
					avatar.frameNo = 0;
					avatar.frameEndNo = 0;
					avatar:SetScript("OnUpdate",nil);
					if pre_stats ~= "Normal" then
						avatar:RefreshUnit();
					end
				end
				if 
					ZMobDB_db_changed == nil and 
					avatar.random_anim == nil and 
					((OnShow) or Unit_Name ~= UnitName(unittype) or Data_Select ~= db_select) 
				then
					ZMobDB_Avatar_OnEvent(avatar);
				end
				if 
					stats == "Normal" and 
					ZMobDB_db_changed == nil and 
					ZMobDB_UnitIsRenderable(unittype) 
				then
						ZMobDB_Avatar_SetZoom(avatar, db_zoom);
						ZMobDB_Avatar_SetPosition(avatar, db_position[1], db_position[2]);
						if ZMobDB_GetOption(Unit_word,"FixFace") =="off" then
							ZMobDB_Avatar_SetRotation(avatar, db_rotation);
						end
						ZMobDB_Avatar_SetScale(avatar, db_scale);
					if db_select ~= Data_Select and db_select == "default" then
						if ZMobDB_GetOption("Settings","NoticeNewData") =="on" then
							DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:Find New Model :"..unittype);
						end
						-- avatar:SetModelScale(1);
						avatar:RefreshUnit();
					end
				elseif 
					stats ~= "Normal" and 
					not(stats == "Ice" or 
					stats == "Shackle" or 
					stats == "Fear" or 
					stats == "Cyclone" or 
					stats == "Seduce" or 
					stats == "Banish" or 
					stats == "Sleep" or 
					stats == "Shield" or 
					stats == "Bandage") and 
					ZMobDB_db_changed == nil and 
					ZMobDB_UnitIsRenderable(unittype) 
				then
						ZMobDB_Avatar_SetZoom(avatar, db_zoom_ani);
						ZMobDB_Avatar_SetPosition(avatar, db_position_ani[1], db_position_ani[2]);
						if ZMobDB_GetOption(Unit_word,"FixFace") =="off" then
							ZMobDB_Avatar_SetRotation(avatar, db_rotation_ani);
						end
						ZMobDB_Avatar_SetScale(avatar, db_scale_ani);
					if db_name_ani ~= DataSelect and db_select_ani == "default" then
						-- avatar:SetModelScale(1);
						avatar:RefreshUnit();
					end
				end
				if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Port") == "on" or db_autoport == "on" then
					if not(ZMobDB_GetOption("Settings","Symbol") == "on" and not(UnitIsVisible(unittype))) then
						avatar:SetModelScale(1);

						avatar:SetPortraitZoom(1);
						avatar:SetPosition(0,0,0);
						avatar:ClearModel();
						avatar:SetUnit(unittype);

						avatar.port = "on";
					end
				else
						avatar:SetPortraitZoom(0);
						avatar.port = "off";
				end

				ZMobDB_EventAnimation(avatar,"target");

				ZMobDB_Animation_stats[unittype].UnitName = UnitName(unittype);
				if stats == "Normal" then
					avatar:GetParent().DataName = db_name;
					ZMobDB_Animation_stats[unittype].DataSelect = db_select;
				else
					avatar:GetParent().DataName = db_name_ani;
					ZMobDB_Animation_stats[unittype].DataSelect = db_select_ani;
				end
				ZMobDB_SetOption("Settings","TargetData", avatar:GetParent().DataName);
				ZMobDB_SetOption("Settings","TargetModel", ZMobDB_Get_Unit_File(avatar));
				local name_text = "ZMobDB_Copyto_Dialog_Copy_to_name_box_Text";
				local Text_Box = _G[name_text];
				Text_Box:SetText("Target Data:"..avatar:GetParent().DataName);
             		else
				if not(Config_Window:IsShown()) then
					avatar:GetParent():Hide();
				else
					avatar:GetParent():Show();
				end
				bBox:GetChildren():ClearModel();
				bBox:GetChildren():SetUnit("player");
				local name_20 = "ZMobDB_Camera20";
				local bBox_20 = _G[name_20];
				bBox_20:Hide();
				avatar.animationNo = nil;
				avatar.nextNo = nil;
				avatar.frameNo = 0;
				avatar.frameEndNo = 0;
				avatar:SetScript("OnUpdate",nil);
				db_name = nil;
				db_select = nil;
				if ZMobDB_db_changed == 1 then
					ZMobDB_db_changed = nil;
				end
				ZMobDB_Animation_stats[unittype].DataSelect = "default";
				ZMobDB_Animation_stats[unittype].UnitName = "NoData";
				db_autoport = nil;
				avatar:GetParent().DataName = nil;
				avatar.port = nil;
				ZMobDB_SetOption("Settings","TargetData","No Target");
				ZMobDB_SetOption("Settings","TargetModel","");
				local name_text = "ZMobDB_Copyto_Dialog_Copy_to_name_box_Text";
				local Text_Box = _G[name_text];
				Text_Box:SetText("Target Data:No Target");
				ZMobDB_Animation_stats["target"].stats = "Normal";
				ZMobDB_Animation_stats["target"].pre_stats = "Normal";
			end
		-- ---------------------------------------------------------
		-- (In Raid) Party,Party Pet,Party Target
		-- ---------------------------------------------------------
		elseif 
			ZMobDB_GetOption("Settings","HideInRaid") == "on" and 
			IsInRaid() and 
			(Unit_word == "party" or Unit_word == "partytarget" or Unit_word == "partypet") 
		then
			if not(Config_Window:IsShown()) then
				avatar:GetParent():Hide();
			else
				avatar:GetParent():Show();
			end
		-- ---------------------------------------------------------
		-- Else
		-- ---------------------------------------------------------
		else
			if UnitExists(unittype) then
				avatar:GetParent():Show();
				db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport = ZMobDB_GetModelSetting(avatar);
				if stats == "Normal" then
					if 
						ZMobDB_db_changed == nil and 
						avatar.random_anim == nil and 
						((OnShow) or Unit_Name ~= UnitName(unittype) or Data_Select ~= db_select) 
					then
						ZMobDB_Avatar_OnEvent(avatar);
					end
					if ZMobDB_UnitIsRenderable(unittype) and avatar.random_anim == nil then

				avatar.animationNo = nil;
				avatar.nextNo = nil;
				avatar.frameNo = 0;
				avatar.frameEndNo = 0;
				avatar:SetScript("OnUpdate",nil);

							ZMobDB_Avatar_SetZoom(avatar, db_zoom);
							ZMobDB_Avatar_SetPosition(avatar, db_position[1], db_position[2]);
							if ZMobDB_GetOption(Unit_word,"FixFace") =="off" then
								ZMobDB_Avatar_SetRotation(avatar, db_rotation);
							end
							ZMobDB_Avatar_SetScale(avatar, db_scale);
						if db_select ~= Data_Select and db_select == "default" then
							if ZMobDB_GetOption("Settings","NoticeNewData") =="on" then
								DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:Find New Model :"..unittype);
							end
							-- avatar:SetModelScale(1);
							avatar:RefreshUnit();
						end
					end
					ZMobDB_Animation_stats[unittype].DataSelect = db_select;
					ZMobDB_Animation_stats[unittype].UnitName = UnitName(unittype);
					avatar:GetParent().DataName = db_name;
					if 
						db_autoport == "on" and 
						ZMobDB_db_changed == nil 
					then
						if not(ZMobDB_GetOption("Settings","Symbol") == "on" and not(ZMobDB_UnitIsRenderable(unittype))) then
							avatar:SetModelScale(1);
						avatar:SetPortraitZoom(1);
						avatar:SetPosition(0,0,0);

							avatar.port = "on";
						end
					else
						avatar.port = "off";
					end
				else
					if 
						ZMobDB_db_changed == nil and 
						avatar.random_anim == nil and 
						((OnShow) or (event == "UNIT_PORTRAIT_UPDATE")) 
					then
						ZMobDB_Avatar_OnEvent(avatar);
						ZMobDB_Avatar_SetZoom(avatar, db_zoom);
						ZMobDB_Avatar_SetPosition(avatar, db_position[1], db_position[2]);
						if ZMobDB_GetOption(Unit_word,"FixFace") =="off" then
							ZMobDB_Avatar_SetRotation(avatar, db_rotation);
						end
						ZMobDB_Avatar_SetScale(avatar, db_scale);
						if db_name ~= Data_Select and db_select == "default" then
							-- avatar:SetModelScale(1);
							avatar:RefreshUnit();
						end
						ZMobDB_Animation_stats[unittype].pre_stats = "Normal";

					end
					ZMobDB_EventAnimation(avatar,unittype);
				end
			else
				ZMobDB_Avatar_OnEvent(avatar);
				bBox:GetChildren():ClearModel();
				avatar.animationNo = nil;
				avatar.nextNo = nil;
				avatar.frameNo = 0;
				avatar.frameEndNo = 0;
				avatar:SetScript("OnUpdate",nil);
				if not(Config_Window:IsShown()) then
					avatar:GetParent():Hide();
				else
					avatar:GetParent():Show();
				end
				ZMobDB_Animation_stats[unittype].DataSelect = "default";
				ZMobDB_Animation_stats[unittype].UnitName = "NoData";
				avatar:GetParent().DataName = nil;
			end
			if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Port") == "on" then
				if not(ZMobDB_GetOption("Settings","Symbol") == "on" and not(ZMobDB_UnitIsRenderable(unittype))) then
					avatar:SetModelScale(1);
						avatar:SetPortraitZoom(1);
						avatar:SetPosition(0,0,0);
					avatar.port = "on";
				else
						avatar:SetPortraitZoom(0);
				end
			end
		end
	elseif avatar:GetParent():GetID() ~= 20 and avatar:GetParent():GetID() ~= 9 then
		if not(Config_Window:IsShown()) then
			avatar:GetParent():Hide();
		end
	end
	-- ---------------------------------------------------------
	-- Animation Test Box
	-- ---------------------------------------------------------
	if avatar:GetParent():GetID() == 20 then
		if UnitExists(unittype) then
			avatar:GetParent():Show();
			db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport = ZMobDB_GetModelSetting(avatar);
			avatar.animationNo = nil;
			avatar.nextNo = nil;
			avatar.frameNo = 0;
			avatar.frameEndNo = 0;
			avatar:SetScript("OnUpdate",nil);
			if pre_stats ~= "Normal" then
				avatar:RefreshUnit();
			end
			if 
				ZMobDB_db_changed == nil and 
				avatar.random_anim == nil 
			then
				ZMobDB_Avatar_OnEvent(avatar);
				ZMobDB_Avatar_SetZoom(avatar, db_zoom);
				ZMobDB_Avatar_SetPosition(avatar, db_position[1], db_position[2]);
				if ZMobDB_GetOption(Unit_word,"FixFace") =="off" then
					ZMobDB_Avatar_SetRotation(avatar, db_rotation);
				end
				ZMobDB_Avatar_SetScale(avatar, db_scale);
				if db_name ~= Data_Select and db_select == "default" then
					-- avatar:SetModelScale(1);
					avatar:RefreshUnit();
				end

			end
			if 
				stats_test ~= "Normal" and 
				UnitIsPlayer("target") and 
				not(stats_test == "Ice" or 
				stats_test == "Shackle" or 
				stats_test == "Fear" or 
				stats_test == "Cyclone" or 
				stats_test == "Seduce" or 
				stats_test == "Banish" or 
				stats_test == "Sleep" or 
				stats_test == "Shield" or 
				stats_test == "Bandage") and 
				ZMobDB_db_changed == nil and 
				ZMobDB_UnitIsRenderable(unittype) 
			then
				ZMobDB_Avatar_SetZoom(avatar, db_zoom_ani);
				ZMobDB_Avatar_SetPosition(avatar, db_position_ani[1], db_position_ani[2]);
				if ZMobDB_GetOption(Unit_word,"FixFace") =="off" then
					ZMobDB_Avatar_SetRotation(avatar, db_rotation_ani);
				end
				ZMobDB_Avatar_SetScale(avatar, db_scale_ani);
				if db_name_ani ~= DataSelect and db_select_ani == "default" then
					-- avatar:SetModelScale(1);
					avatar:RefreshUnit();
				end
			end
			if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Port") == "on" or db_autoport == "on" then
				if not(ZMobDB_GetOption("Settings","Symbol") == "on" and not(UnitIsVisible(unittype))) then
					avatar:SetModelScale(1);
						avatar:SetPortraitZoom(1);
						avatar:SetPosition(0,0,0);
						avatar:ClearModel();
						avatar:SetUnit(unittype);
					avatar.port = "on";
				end
			else
				avatar:SetPortraitZoom(0);
				avatar.port = "off";
			end
			if stats_test ~= "Normal" and stats_test ~= "Random"  and stats_test ~= "Ghost" and UnitIsPlayer("target") then
				ZMobDB_StartAnimation(avatar,stats_test,"on");
			end
			if stats_test == "Normal" then
				avatar:GetParent().DataName = db_name;
			else
				if UnitIsPlayer("target") then
					avatar:GetParent().DataName = db_name_ani;
				else
					avatar:GetParent().DataName = db_name;
				end
			end
			local Dialog = "ZMobDB_AnimationTest_Dialog_DataName";
			local Dialog_Box = _G[Dialog];
			Dialog_Box:SetText(avatar:GetParent().DataName);
		else
			avatar:ClearModel();
			avatar.animationNo = nil;
			avatar.nextNo = nil;
			avatar.frameNo = 0;
			avatar.frameEndNo = 0;
			avatar:GetParent().DataName = nil;
			avatar.port = nil;
		end
	end
end
-- ---------------------------------------------------------
-- Box Event
-- ---------------------------------------------------------
function ZMobDB_BoundingBox_OnLoad(self)
	self.isAvatar = false;
	self:RegisterEvent("VARIABLES_LOADED");
	ZMobDB_SpecialEvent("BOUNDINGBOX_CREATED", self);
end


local lastClick = 0
local DOUBLE_CLICK_TIME = 0.3 -- seconds

function ZMobDB_BoundingBox_OnMouseDown(self, button)
	if (IsControlKeyDown()) and (IsShiftKeyDown()) and (IsAltKeyDown()) then
		ZMobDB_ResetModel(self,MouseButton);
	elseif (IsControlKeyDown()) and (IsShiftKeyDown()) then
		ZMobDB_SetAutoPort(self,MouseButton);
	else
		if (ZMobDB_CursorControl_IsEnabled(self) and (MouseButton == "LeftButton" or MouseButton == "RightButton" or MouseButton == "MiddleButton")) then
			ZMobDB_CursorControl_SetActiveButton(self, MouseButton);
		end
	end
end
function ZMobDB_BoundingBox_OnReceiveDrag(self)
	ZMobDB_BoundingBox_OnMouseUp(self);
end
function ZMobDB_ShadowFrame_OnMouseDown(self)
	local MouseButton = GetMouseButtonClicked();
	local id = self:GetID();
	local name_camera = "ZMobDB_Camera"..id;
	local bBox = _G[name_camera];

	if (IsControlKeyDown()) and (IsShiftKeyDown()) and (IsAltKeyDown()) then
		ZMobDB_ResetModel(bBox,MouseButton);
	elseif (IsControlKeyDown()) and (IsShiftKeyDown()) then
		ZMobDB_SetAutoPort(bBox,MouseButton);
	else
		if (ZMobDB_CursorControl_IsEnabled(bBox) and (MouseButton == "LeftButton" or MouseButton == "RightButton" or MouseButton == "MiddleButton")) then
			ZMobDB_CursorControl_SetActiveButton(bBox, MouseButton);
		end
		if ZMobDB_GetOption("Settings","DropDown") == "on" and ZMobDB_GetOption("Settings","HoldBox") == "on" and MouseButton == "RightButton" then
			ZMobDB_DropDownMenu(self,id);
		end
	end
end
function ZMobDB_BoundingBox_OnMouseUp(self)
	local name_config = "ZMobDB_Configuration";
	local Config_window = _G[name_config];
	if not(Config_window:IsShown()) then
		if 
			ZMobDB_GetOption("Settings","Border") == "tooltip" or 
			ZMobDB_GetOption("Settings","Border") == "black" 
		then
			self:SetBackdropColor(0,0,0,1);
		else
			self:SetBackdropColor(0,0,0,0);
		end
	end
		ZMobDB_CursorControl_SetActiveButton(self);
		ZMobDB_CursorX,     ZMobDB_CursorY     = nil, nil;
		ZMobDB_CursorMoveX, ZMobDB_CursorMoveY = nil, nil;
		ZMobDB_SaveData(self);
		ZMobDB_db_changed = nil;
	if self:GetID() == 9 then
		self:SetBackdropColor(0,0,0,0);
	end
end
function ZMobDB_ShadowFrame_OnMouseUp(self)
	local id = self:GetID();
	local name_config = "ZMobDB_Configuration";
	local Config_window = _G[name_config];
	local name_camera = "ZMobDB_Camera"..id;
	local bBox = _G[name_camera];
	if not(Config_window:IsShown()) then
		if 
			ZMobDB_GetOption("Settings","Border") == "tooltip" or 
			ZMobDB_GetOption("Settings","Border") == "black" 
		then
			bBox:SetBackdropColor(0,0,0,1);
		else
			bBox:SetBackdropColor(0,0,0,0);
		end
	end
	ZMobDB_CursorControl_SetActiveButton(bBox);
	ZMobDB_CursorX,     ZMobDB_CursorY     = nil, nil;
	ZMobDB_CursorMoveX, ZMobDB_CursorMoveY = nil, nil;
	ZMobDB_SaveData(bBox);
	ZMobDB_db_changed = nil;
	if id == 9 then
		bBox:SetBackdropColor(0,0,0,0);
	end
end
function ZMobDB_ShadowFrame_OnReceiveDrag()
	ZMobDB_BoundingBox_OnMouseUp(self);
end
function ZMobDB_ShadowFrame_OnUpdate(self)
	local id = self:GetID();
	local name_camera = "ZMobDB_Camera"..id;
	local bBox = _G[name_camera];
	if (ZMobDB_CursorControl_IsEnabled(bBox)) then
		activeControl = ZMobDB_CursorControl_GetActiveName(bBox);
		if (activeControl ~= nil) then
			ZMobDB_GetCursorMovement(); -- Calculate movement for controls
			if (activeControl.isAvatar) then
				-- ZMobDB_SpecialEvent("CURSORCONTROL_ONMOUSEDOWN", bBox:GetChildren());
				ZMobDB_SpecialEvent("CURSORCONTROL_ONMOUSEDOWN", bBox);
			else
				if ZMobDB_GetOption("Settings","HoldBox") == "off" then
					self:SetBackdropColor(0,0.5,1,0.5);
				end
				ZMobDB_SpecialEvent("CURSORCONTROL_ONMOUSEDOWN", bBox);
			end
			ZMobDB_CursorMoveX, ZMobDB_CursorMoveY = nil, nil;
		end
	end
end
function ZMobDB_BoundingBox_IsEnabled(bBox)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	return ZMobDB_Profile[ZMobDBPlayerIndex][bBox:GetID()].isEnabled;
end
function ZMobDB_BoundingBox_SetScale(bBox, width, height)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	local changed = false;
	width = ZMobDB_BoundingBox_GetWidthConstraint(bBox, width);
	if (width ~= nil and width ~= bBox:GetWidth()) then
		bBox:SetWidth(width);
		ZMobDB_Profile[ZMobDBPlayerIndex][bBox:GetID()].scale.width = width;
		changed = true;
	end
	height = ZMobDB_BoundingBox_GetHeightConstraint(bBox, height);
	if (height ~= nil and height ~= bBox:GetHeight()) then
		bBox:SetHeight(height);
		ZMobDB_Profile[ZMobDBPlayerIndex][bBox:GetID()].scale.height = height;
		changed = true;
	end
	if (changed) then
		-- Make sure the new bounding box size doesn't exceed its borders.
		local x, y = ZMobDB_BoundingBox_GetPositionConstraint(bBox);
		bBox:SetPoint("BOTTOMLEFT", x, y);
		ZMobDB_Profile[ZMobDBPlayerIndex][bBox:GetID()].anchor.x = x;
		ZMobDB_Profile[ZMobDBPlayerIndex][bBox:GetID()].anchor.y = y;
		ZMobDB_SpecialEvent("BOUNDINGBOX_SCALE_CHANGED", bBox);
	end
end
function ZMobDB_BoundingBox_GetWidthConstraint(bBox, width)
	if (width == nil) then
		return nil
	elseif (width > UIParent:GetWidth() / UIParent:GetEffectiveScale()) then
		return UIParent:GetWidth() / UIParent:GetEffectiveScale();
	elseif (width < 20) then
		return 20;
	end
	return width;
end
function ZMobDB_BoundingBox_GetHeightConstraint(bBox, height)
	if (height == nil) then
		return nil
	elseif (height > UIParent:GetHeight() / UIParent:GetEffectiveScale()) then
		return UIParent:GetHeight() / UIParent:GetEffectiveScale();
	elseif (height < 20) then
		return 20;
	end
	return height;
end
function ZMobDB_BoundingBox_SetPosition(bBox, x, y)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	if (x == nil) then
		x = bBox:GetLeft();
	end
	if (y == nil) then
		y = bBox:GetBottom();
	end
	if (x ~= bBox:GetLeft() or y ~= bBox:GetBottom()) then
		-- Anchor points have changed.
		bBox:SetPoint("BOTTOMLEFT", ZMobDB_BoundingBox_GetPositionConstraint(bBox, x, y));
		ZMobDB_Profile[ZMobDBPlayerIndex][bBox:GetID()].anchor.x = x;
		ZMobDB_Profile[ZMobDBPlayerIndex][bBox:GetID()].anchor.y = y;
		ZMobDB_SpecialEvent("BOUNDINGBOX_POSITION_CHANGED", bBox);
	end
end
function ZMobDB_BoundingBox_GetPositionConstraint(bBox, x, y)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	if (x == nil) then
		x = bBox:GetLeft();
	end
	if (y == nil) then
		y = bBox:GetBottom();
	end
	-- Determine left and right boundries
	local parentBoundry = UIParent:GetWidth() / UIParent:GetEffectiveScale();
	if (x < 0 and x + bBox:GetWidth() > parentBoundry) then
		bBox:SetWidth(parentBoundry);
		ZMobDB_Profile[ZMobDBPlayerIndex][bBox:GetID()].scale.width = parentBoundry;
	elseif (x < 0) then
		x = 0;
	elseif (x + bBox:GetWidth() > parentBoundry) then
		x = parentBoundry - bBox:GetWidth();
	end
	-- Determine top and bottom boundries
	parentBoundry = UIParent:GetHeight() / UIParent:GetEffectiveScale();
	if (y < 0 and y + bBox:GetHeight() > parentBoundry) then
		bBox:SetHeight(parentBoundry);
		ZMobDB_Profile[ZMobDBPlayerIndex][bBox:GetID()].scale.height = parentBoundry;
	elseif (y < 0) then
		y = 0;
	elseif (y + bBox:GetHeight() > parentBoundry) then
		y = parentBoundry - bBox:GetHeight();
	end
	return x, y;
end
function ZMobDB_Settings_RefreshBoundingBox(self)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	local Button_Name = nil;
	local Text_Name = nil;
	profile = ZMobDB_Profile[ZMobDBPlayerIndex][self:GetID()];
		if (self:GetID() == 0) then
			profile.avatar.unitType = "player";
			Box_name0 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name0;
		elseif (self:GetID() == 1) then
			profile.avatar.unitType = "target";
			Box_name1 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name1;
		elseif (self:GetID() == 2) then
			profile.avatar.unitType = "party1";
			Box_name2 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name2;
		elseif (self:GetID() == 3) then
			profile.avatar.unitType = "party2";
			Box_name3 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name3;
		elseif (self:GetID() == 4) then
			profile.avatar.unitType = "party3";
			Box_name4 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name4;
		elseif (self:GetID() == 5) then
			profile.avatar.unitType = "party4";
			Box_name5 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name5;
		elseif (self:GetID() == 6) then
			profile.avatar.unitType = "pet";
			Box_name6 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name6;
		elseif (self:GetID() == 7) then
			profile.avatar.unitType = "targettarget";
			Box_name7 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name7;
		elseif (self:GetID() == 8) then
			profile.avatar.unitType = "pettarget";
			Box_name8 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name8;
		elseif (self:GetID() == 10) then
			profile.avatar.unitType = "party1target";
			Box_name10 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name10;
		elseif (self:GetID() == 11) then
			profile.avatar.unitType = "party2target";
			Box_name11 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name11;
		elseif (self:GetID() == 12) then
			profile.avatar.unitType = "party3target";
			Box_name12 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name12;
		elseif (self:GetID() == 13) then
			profile.avatar.unitType = "party4target";
			Box_name13 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name13;
		elseif (self:GetID() == 14) then
			profile.avatar.unitType = "focus";
			Box_name14 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name14;
		elseif (self:GetID() == 15) then
			profile.avatar.unitType = "party1pet";
			Box_name15 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name15;
		elseif (self:GetID() == 16) then
			profile.avatar.unitType = "party2pet";
			Box_name16 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name16;
		elseif (self:GetID() == 17) then
			profile.avatar.unitType = "party3pet";
			Box_name17 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name17;
		elseif (self:GetID() == 18) then
			profile.avatar.unitType = "party4pet";
			Box_name18 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name18;
		elseif (self:GetID() == 19) then
			profile.avatar.unitType = "focustarget";
			Box_name19 = self:CreateFontString(nil,"OVERLAY");
			Text_Name = Box_name19;
		elseif (self:GetID() == 20) then
			profile.avatar.unitType = "target";
			self:GetChildren():SetScript("OnEvent",nil);
		elseif (self:GetID() == 9) then
			profile.avatar.unitType = "player";
			self:GetChildren():SetScript("OnEvent",nil);
		end
		if (self:GetID() ~= 9) and (self:GetID() ~= 20) then
			if ZMobDB_GetOption(ZMobDB_Unit_word[profile.avatar.unitType],"Show") =="on" then
				profile.isEnabled = true;
				self:Show();
			else
				profile.isEnabled = false;
				self:Hide();
				self:GetChildren():SetScript("OnEvent",nil);
			end
		else
			profile.isEnabled = true;
			self:Hide();
			-- self:Show();

			self:GetChildren():SetScript("OnEvent",nil);
		end
		if (self:GetID() ~= 9) and (self:GetID() ~= 20) then
			self:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", profile.anchor.x, profile.anchor.y);
			if profile.scale.width == 0 or profile.scale.height == 0 then
				profile.scale.width = 200;
				profile.scale.height = 200;
			end
			self:SetWidth(profile.scale.width);
			self:SetHeight(profile.scale.height);
			Mixin(self, BackdropTemplateMixin)
			self:SetBackdropColor(profile.bgColor.red, profile.bgColor.green, profile.bgColor.blue, profile.bgColor.alpha);
			self:SetFrameStrata(ZMobDB_GetOption(ZMobDB_Unit_word[profile.avatar.unitType],"Strata"));
			self:EnableMouse(true);
			profile.cursorControls.isEnabled = true;
		elseif (self:GetID() == 9) then
			self:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", profile.anchor.x, profile.anchor.y);
			self:SetWidth(0);
			profile.scale.width = 0;
			self:SetHeight(0);
			profile.scale.height = 0;
			Mixin(self, BackdropTemplateMixin)
			self:SetBackdropColor(profile.bgColor.red, profile.bgColor.green, profile.bgColor.blue, profile.bgColor.alpha);
			self:EnableMouse(false);
			profile.cursorControls.isEnabled = false;
		elseif (self:GetID() == 20) then
			self:SetWidth(200);
			profile.scale.width = 200;
			self:SetHeight(200);
			profile.scale.height = 200;
			Mixin(self, BackdropTemplateMixin)			
			self:SetBackdropColor(profile.bgColor.red, profile.bgColor.green, profile.bgColor.blue, profile.bgColor.alpha);
			self:EnableMouse(true);
			profile.cursorControls.isEnabled = true;
			self:Hide();
			self:GetChildren():SetPoint("TOPLEFT",0,0);
			self:GetChildren():SetPoint("BOTTOMRIGHT",0,0);

			self:EnableMouse(true);
			self:EnableMouseWheel(true);
			self:SetScript('OnMouseDown',ZMobDB_BoundingBox_OnMouseDown);
			self:SetScript('OnReceiveDrag',ZMobDB_BoundingBox_OnReceiveDrag);
			self:SetScript('OnMouseUp',ZMobDB_BoundingBox_OnMouseUp);

		end
			ZMobDB_Avatar_SetUnitType(self:GetChildren(), profile.avatar.unitType);
			ZMobDB_Settings_RefreshCamera(self:GetChildren());

		if (self:GetID() ~= 20) and (self:GetID() ~= 9) and ZMobDB_GetOption(ZMobDB_Unit_word[profile.avatar.unitType],"Port") =="on" then
			self:GetChildren():SetModelScale(1);
			-- self:GetChildren():SetCamera(0);
						self:GetChildren():SetPortraitZoom(1);
						self:GetChildren():SetPosition(0,0,0);
						self:GetChildren():ClearModel();
						self:GetChildren():SetUnit(ZMobDB_Avatar_GetUnitType(self:GetChildren()));
		end
		if (self:GetID() ~= 9) and (self:GetID() ~= 20) then
			local button = "ZMobDB_Frame_"..profile.avatar.unitType;
			Button_Name = _G[button];
			Button_Name:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT",profile.anchor.x,profile.anchor.y);
			Button_Name:SetWidth(profile.scale.width);
			Button_Name:SetHeight(profile.scale.height);
			Mixin(Button_Name, BackdropTemplateMixin)
			Button_Name:SetBackdropColor(profile.bgColor.red, profile.bgColor.green, profile.bgColor.blue, profile.bgColor.alpha);	
			Button_Name:SetAttribute("type", "target");
			Button_Name:SetAttribute("type2", "");
			ClickCastFrames = ClickCastFrames or {};
			ClickCastFrames[Button_Name] = true;

			Button_Name:SetFrameStrata(ZMobDB_GetOption(ZMobDB_Unit_word[profile.avatar.unitType],"Strata"));
			Button_Name:SetFrameLevel(self:GetFrameLevel() + 1);


			if ZMobDB_GetOption(ZMobDB_Unit_word[profile.avatar.unitType],"EnableMouse")=="on" then
				self:EnableMouse(true);
				self:EnableMouseWheel(true);
				self:SetScript('OnMouseDown',ZMobDB_BoundingBox_OnMouseDown);
				self:SetScript('OnReceiveDrag',ZMobDB_BoundingBox_OnReceiveDrag);
				self:SetScript('OnMouseUp',ZMobDB_BoundingBox_OnMouseUp);
			else
				self:SetScript('OnMouseDown',nil);
				self:SetScript('OnReceiveDrag',nil);
				self:SetScript('OnMouseUp',nil);
				self:EnableMouse(false);
				self:EnableMouseWheel(false);
				Button_Name:SetWidth(0);
				Button_Name:SetHeight(0);
			end

			Button_Name:SetScript('OnMouseDown',ZMobDB_ShadowFrame_OnMouseDown);
			Button_Name:SetScript('OnUpdate',ZMobDB_ShadowFrame_OnUpdate);
			Button_Name:SetScript('OnReceiveDrag',ZMobDB_ShadowFrame_OnReceiveDrag);
			Button_Name:SetScript('OnMouseUp',ZMobDB_ShadowFrame_OnMouseUp);

			Text_Name:SetPoint("CENTER",self,"CENTER");
			Text_Name:SetJustifyH("CENTER");
			Text_Name:SetFontObject(GameFontNormal);
			Text_Name:SetText(profile.avatar.unitType);
			Text_Name:Hide();

		end
		RefreshBoundingBox_loaded = 1;
end



function ZMobDB_BoundingBox_OnUpdate(self)
	if (ZMobDB_CursorControl_IsEnabled(self)) then
		activeControl = ZMobDB_CursorControl_GetActiveName(self);
		if (activeControl ~= nil) then
			ZMobDB_GetCursorMovement(); -- Calculate movement for controls
			if (activeControl.isAvatar) then
				-- ZMobDB_SpecialEvent("CURSORCONTROL_ONMOUSEDOWN", self:GetChildren());
				ZMobDB_SpecialEvent("CURSORCONTROL_ONMOUSEDOWN", self);
			else
				if ZMobDB_GetOption("Settings","HoldBox") == "off" then
					self:SetBackdropColor(0,0.5,1,0.5);
				end
				ZMobDB_SpecialEvent("CURSORCONTROL_ONMOUSEDOWN", self);
			end
			ZMobDB_CursorMoveX, ZMobDB_CursorMoveY = nil, nil;
		end
	end
end
function ZMobDB_BoundingBox_OnShow(self)
	if self:GetID() ~= 20 and self:GetID() ~= 9 then
		if 
			RefreshBoundingBox_loaded ~= nil and 
			Option_Change_loaded ~= nil and 
			Config_OnShow == 0 
		then

			if ZMobDB_GetOption(ZMobDB_Unit_word[ZMobDB_Avatar_GetUnitType(self:GetChildren())],"Port")=="on" then
				-- self:GetChildren():SetCamera(0);
						self:GetChildren():SetPortraitZoom(1);
						self:GetChildren():SetPosition(0,0,0);
						self:GetChildren():ClearModel();
						self:GetChildren():SetUnit(ZMobDB_Avatar_GetUnitType(self:GetChildren()));
			else
				-- self:GetChildren():SetCamera(2);
						self:GetChildren():SetPortraitZoom(0);
			end
			ZMobDB_Avatar_Refresh(self:GetChildren());
			self.PushRefresh="on";
		end
		self.SecondsSinceLastEvent=0;
	end
end
function ZMobDB_BoundingBox_OnHide(self)
	if self:GetID() ~= 9 then
		ZMobDB_BoundingBox_OnMouseUp(self);
		self:GetChildren():ClearModel();
		ZMobDB_Avatar_SetRendered(self:GetChildren(),false);
		self.SecondsSinceLastEvent = 0;
	end
end
function ZMobDB_BoundingBox_Reflesh(self)
	if (ZMobDB_CursorControl_IsActive(self, "Reflesh") or ZMobDB_CursorControl_IsActive(self, "Reflesh_Dropdown") or (event == "DISPLAY_SIZE_CHANGED")) then
		for i=0,19 do
			if i~=9 then
				local name_camera = "ZMobDB_Camera"..i;
				local camera = _G[name_camera];
				ZMobDB_BoundingBox_Reflesh_sub(camera);
			end
		end
	end
end
function ZMobDB_BoundingBox_Reflesh_sub(bBox)
	local db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport;
	local unittype = ZMobDB_Avatar_GetUnitType(bBox:GetChildren());
	local Unit_Buff,Unit_DeBuff,Unit_Shape,Unit_Stealth = ZMobDB_Get_Unit_Aura(unittype);
	local stats,pre_stats,ghost_model = ZMobDB_GetStats(unittype);
	if (UnitExists(unittype) and stats == "Normal") then
		ZMobDB_Animation_stats[unittype].pre_stats = "Normal";
		bBox:GetChildren().animationNo = nil;
		bBox:GetChildren().nextNo = nil;
		bBox:GetChildren().frameNo = 0;
		bBox:GetChildren().frameEndNo = 0;
		bBox:GetChildren():SetScript("OnUpdate",nil);
		bBox:GetChildren():RefreshUnit();
		db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport = ZMobDB_GetModelSetting(bBox:GetChildren());

		-- bBox:GetChildren():SetCamera(2);
		bBox:GetChildren():SetPortraitZoom(0);

		ZMobDB_Avatar_SetRendered(bBox:GetChildren(), false);
		ZMobDB_Avatar_AttemptToRender(bBox:GetChildren(), true);
		ZMobDB_Avatar_SetZoom(bBox:GetChildren(), db_zoom);
		ZMobDB_Avatar_SetPosition(bBox:GetChildren(), db_position[1], db_position[2]);
		if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"FixFace") =="off" then
			ZMobDB_Avatar_SetRotation(bBox:GetChildren(), db_rotation);
		end
		ZMobDB_Avatar_SetScale(bBox:GetChildren(), db_scale);
		if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Port")=="on" or db_autoport =="on" then
			-- bBox:GetChildren():SetCamera(0);
			bBox:GetChildren():SetPortraitZoom(1);
			bBox:GetChildren():SetPosition(0,0,0);
			bBox:GetChildren():ClearModel();
			bBox:GetChildren():SetUnit(unittype);
		end
	elseif not(UnitExists(unittype)) then
		local name_config = "ZMobDB_Configuration";
		local Config_Window = _G[name_config];
		bBox:GetChildren():ClearModel();
		if not(Config_Window:IsShown()) then
			bBox:Hide();
		end
	end
	if 
		stats == "Dead" or 
		stats == "Rest" or 
		stats == "AFK" or 
		stats == "Pain" or 
		stats == "Stealth" 
	then
		ZMobDB_Animation_stats[unittype].pre_stats = stats;
		ZMobDB_StartAnimation(bBox:GetChildren(),stats,"on");
	elseif stats == "Ghost" then
		ZMobDB_Animation_stats[unittype].pre_stats = "Ghost";
		db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport = ZMobDB_GetModelSetting(bBox:GetChildren());
		bBox:GetChildren().animationNo = nil;
		bBox:GetChildren().nextNo = nil;
		bBox:GetChildren().frameNo = 0;
		bBox:GetChildren().frameEndNo = 0;
		bBox:GetChildren():SetScript("OnUpdate",nil);
		-- bBox:GetChildren():SetCamera(2);
		bBox:GetChildren():SetPortraitZoom(0);
		bBox.DataName = db_name_ani;
		if ghost_model == "flag" then
			if UnitFactionGroup("player") == "Horde" then
				ghost_model = "Horde_Flag";
			else
				ghost_model = "Alliance_Flag";
			end
		end
		local ok = pcall(function() bBox:GetChildren():SetModel(ZMobDB_Event_Animation[ghost_model].File) end)
		if not ok then
			
		else
			ZMobDB_Avatar_SetZoom(bBox:GetChildren(), db_zoom_ani);
			ZMobDB_Avatar_SetPosition(bBox:GetChildren(), db_position_ani[1], db_position_ani[2]);
			if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"FixFace") =="off" then
				ZMobDB_Avatar_SetRotation(bBox:GetChildren(), db_rotation_ani);
			end
			ZMobDB_Avatar_SetScale(bBox:GetChildren(), db_scale_ani);
		end
	elseif 
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
		db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport = ZMobDB_GetModelSetting(bBox:GetChildren());
		ZMobDB_Animation_stats[unittype].pre_stats = stats;
		bBox:GetChildren().animationNo = nil;
		bBox:GetChildren().nextNo = nil;
		bBox:GetChildren().frameNo = 0;
		bBox:GetChildren().frameEndNo = 0;
		bBox:GetChildren():SetScript("OnUpdate",nil);
		-- bBox:GetChildren():SetCamera(2);
		bBox:GetChildren():SetPortraitZoom(0);
		bBox.DataName = db_name_ani;
		bBox:GetChildren():SetModel(ZMobDB_Event_Animation[stats].File);
		ZMobDB_Avatar_SetZoom(bBox:GetChildren(), db_zoom_ani);
		ZMobDB_Avatar_SetPosition(bBox:GetChildren(), db_position_ani[1], db_position_ani[2]);
		if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"FixFace") =="off" then
			ZMobDB_Avatar_SetRotation(bBox:GetChildren(), db_rotation_ani);
		end
		ZMobDB_Avatar_SetScale(bBox:GetChildren(), db_scale_ani);
	end

	if UnitExists(unittype) and not(UnitIsVisible(unittype)) and stats ~="Ghost" and ZMobDB_GetOption("Settings","Symbol") == "on" then
		bBox:GetChildren():SetCamera(2);
		bBox:GetChildren():SetPortraitZoom(0);
		bBox:GetChildren():SetModel("Interface\\Buttons\\talktomequestion_ltblue.mdx");
		bBox:GetChildren():SetModelScale(4.25);
		bBox:GetChildren():SetPosition(0,0,-1.5);
		bBox:GetChildren().mark ="on";
	else
		bBox:GetChildren().mark ="off";
	end
	if 
		UnitIsVisible(unittype) and 
		(Unit_Stealth =="Stealth" or Unit_Stealth =="Invisi") and 
		ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Animation_Stealth") =="on" and 
		not (stats == "Ice" or 
		stats == "Shackle" or 
		stats == "Fear" or 
		stats == "Cyclone" or 
		stats == "Seduce" or 
		stats == "Banish" or 
		stats == "Sleep" or  
		stats == "Shield" or 
		stats == "Bandage") 
	then
		bBox:GetChildren():SetAlpha(ZMobDB_GetOption("Settings","AlphaRate")/100);
	elseif ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Animation_Stealth") =="on" then
		bBox:GetChildren():SetAlpha(1);
	end
end


function ZMobDB_SpecialEvent(event,bBox)
	local id = bBox:GetID();
	if (event == "BOUNDINGBOX_REFRESHED") then

		if ZMobDB_GetOption("Settings","HoldBox") ~= "on" and id ~=20 then
			ZMobDB_CursorControl_SetButton(bBox, "Drag", "LeftButton", "SHIFT");
			ZMobDB_CursorControl_SetButton(bBox, "Resize", "RightButton", "SHIFT");
		end
		if ZMobDB_GetOption("Settings","Reflesh_control") == "mouseright" then
			ZMobDB_CursorControl_SetButton(bBox:GetChildren(), "Reflesh_Dropdown", "RightButton", "NOKEY");
			ZMobDB_CursorControl_SetButton(bBox:GetChildren(), nil, "RightButton", "ALT");
		elseif ZMobDB_GetOption("Settings","Reflesh_control") == "alt_mouseright" then
			ZMobDB_CursorControl_SetButton(bBox:GetChildren(), "Reflesh", "RightButton", "ALT");
			ZMobDB_CursorControl_SetButton(bBox:GetChildren(), "Dropdown", "RightButton", "NOKEY");
		end
		ZMobDB_CursorControl_SetButton(bBox:GetChildren(), "RotateAndZoom", "LeftButton", "CTRL");
		ZMobDB_CursorControl_SetButton(bBox:GetChildren(), "Pan", "RightButton", "CTRL");
		ZMobDB_CursorControl_SetButton(bBox:GetChildren(), "Change_Scale", "LeftButton", "ALT");
		local name_20 = "ZMobDB_Camera20";
		local bBox_20 = _G[name_20];
		bBox_20:Hide();
	elseif (event == "CURSORCONTROL_ONMOUSEDOWN") then
		ZMobDB_BoundingBox_Reflesh(bBox);
		if ZMobDB_GetOption("Settings","Mouseoverthrough") == "off" then
			if ZMobDB_GetOption("Settings","HoldBox") ~= "on" and id ~= 20 then
				ZMobDB_BoundingBox_Drag(bBox);
				ZMobDB_BoundingBox_Resize(bBox);
			end
			--if ZMobDB_GetOption(ZMobDB_Unit_word[ZMobDB_Avatar_GetUnitType(ZMobDB_GetBoundingBox(bBox):GetChildren())],"Port") =="off" or ZMobDB_GetBoundingBox(bBox):GetChildren().port =="off" then
				ZMobDB_Avatar_RotateAndZoom(bBox);
				ZMobDB_Avatar_RotateAndShrink(bBox);
				ZMobDB_Avatar_Rotate(bBox);
				ZMobDB_Avatar_Zoom(bBox);
				ZMobDB_Avatar_Shrink(bBox);
				ZMobDB_Avatar_Pan(bBox);
				ZMobDB_Avatar_Scale(bBox);
			--end
		end
	end
end
function ZMobDB_GetCursorMovement()
	if (ZMobDB_CursorMoveX == nil or ZMobDB_CursorMoveY == nil) then
		-- Update mouse coords
		local previousX, previousY = ZMobDB_CursorX, ZMobDB_CursorY;
		ZMobDB_CursorX, ZMobDB_CursorY = GetCursorPosition();
		if (previousX == nil or previousY == nil) then
			-- Initial mouse click, mouse has yet to move
			previousX, previousY = ZMobDB_CursorX, ZMobDB_CursorY;
		end
		-- Save movement
		ZMobDB_CursorMoveX = (ZMobDB_CursorX - previousX) / UIParent:GetEffectiveScale();
		ZMobDB_CursorMoveY = (ZMobDB_CursorY - previousY) / UIParent:GetEffectiveScale();
	end
	
	return ZMobDB_CursorMoveX, ZMobDB_CursorMoveY;
end
function ZMobDB_GetBoundingBox(bBox)
	if (bBox.isAvatar) then
		return bBox:GetParent();
	else
		return bBox;
	end
end
function ZMobDB_UnitIsRenderable(unitType)
	if (UnitExists(unitType) and UnitIsVisible(unitType)) then
		return true;
	else
		return false;
	end
end
function ZMobDB_BoundingBox_Resize(self)
	if (ZMobDB_CursorControl_IsActive(self, "Resize")) then
		changeX, changeY = ZMobDB_GetCursorMovement();
		if (changeX ~= 0 or changeY ~= 0) then
			ZMobDB_BoundingBox_SetScale(self, self:GetWidth() + changeX, self:GetHeight() + changeY);
			ZMobDB_SetOption("Settings","SelectBox",ZMobDB_Avatar_GetUnitType(self:GetChildren()));
			UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Controls_Panel_DropDown_SelectBox, ZMobDB_GetIDFromList(string.upper(ZMobDB_GetOption("Settings","SelectBox")),ZMobDB_SelectBoxList));
			local j = self:GetID();
			local x = self:GetWidth();
			local y = self:GetHeight();
			local name_box_x = "ZMobDB_Configuration_Controls_Panel_BoxSize_x_Text";
			local name_box_y = "ZMobDB_Configuration_Controls_Panel_BoxSize_y_Text";
			local Box_x = _G[name_box_x];
			local Box_y = _G[name_box_y];
			Box_x:SetText("X:"..x);
			Box_y:SetText("Y:"..y);
		end
	end
end
function ZMobDB_BoundingBox_Drag(self)
	if (ZMobDB_CursorControl_IsActive(self, "Drag")) then
		changeX, changeY = ZMobDB_GetCursorMovement();
		if (changeX ~= 0 or changeY ~= 0) then
			ZMobDB_BoundingBox_SetPosition(self, self:GetLeft() + changeX, self:GetBottom() + changeY);
			ZMobDB_SetOption("Settings","SelectBox",ZMobDB_Avatar_GetUnitType(self:GetChildren()));
			UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Controls_Panel_DropDown_SelectBox, ZMobDB_GetIDFromList(string.upper(ZMobDB_GetOption("Settings","SelectBox")),ZMobDB_SelectBoxList));
		end
	end
end
function ZMobDB_BoundingBox_OnEvent(self)
	-- if (event == "PLAYER_LOGIN") then
		-- ZMobDB_setup();
		ZMobDB_Settings_RefreshBoundingBox(self);
		ZMobDB_SpecialEvent("BOUNDINGBOX_REFRESHED", self);
	-- end
end

-- ---------------------------------------------------------
-- Slash Command
-- ---------------------------------------------------------
function ZMobDB_Register_SlashCommands()
	SlashCmdList["ZMOBDBCOMMANDS"] =  ZMobDB_Main_ChatCommandHandler;
	SLASH_ZMOBDBCOMMANDS1 = "/ZMOB";
	SLASH_ZMOBDBCOMMANDS2 = "/zmob";
end
function ZMobDB_Main_ChatCommandHandler(msg)
	local commandName, params = ZMobDB_Extract_NextParameter(msg);
	if ((commandName) and (strlen(commandName) > 0)) then
		commandName = string.lower(commandName);
	else
		commandName = "?";
	end
	if (((strfind(commandName,"delete")))) then
		if params ~= nil then
			if (ZMobDB_table[params]) then
				DEFAULT_CHAT_FRAME:AddMessage("Delete Model Data:"..params);
				if params == "default" then
					ZMobDB_table[params] = { 
					scale = 1,
					zoom = 0,
					rotation = 0,
					position = {0,0},
					autoport = "off",
					}
				else
					ZMobDB_table[params] = nil;
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("Can't Find Data:"..params);
			end
		else
				DEFAULT_CHAT_FRAME:AddMessage("Needs Data Name(Player_UndeadMale etc.)");
		end
	elseif (((strfind(commandName,"copymenu")))) then
		local name_copy = "ZMobDB_Copyto_Dialog";
		local ZMobDB_Copyform = _G[name_copy];
		if InCombatLockdown() then
			DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't toggle menu while in combat");
		else
			ZMobDB_Copyform:Show();
		end
	elseif (((strfind(commandName,"copy")))) then
		local data_id;
		data_id, params = ZMobDB_Extract_3rdParameter(params);
		if data_id ~= nil and params ~= nil then
			if (ZMobDB_table[data_id]) then
				DEFAULT_CHAT_FRAME:AddMessage("Copy Model Setting:"..data_id..">>"..params);
				if (ZMobDB_table[data_id].scale ==nil) then ZMobDB_table[data_id].scale = 1; end
				if (ZMobDB_table[data_id].autoport ==nil) then ZMobDB_table[data_id].autoport = "off"; end
				ZMobDB_table[params] ={
				scale = ZMobDB_table[data_id].scale,
				zoom = ZMobDB_table[data_id].zoom,
				rotation = ZMobDB_table[data_id].rotation,
				position = ZMobDB_table[data_id].position,
				autoport = ZMobDB_table[data_id].autoport,
				}
			else
				DEFAULT_CHAT_FRAME:AddMessage("Can't Find Data:"..data_id);
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("Needs Data Name(Undead_male etc.)");
		end
	elseif (((strfind(commandName,"config")))) then
		local name_config = "ZMobDB_Configuration";
		local ZMobDB_ConfigDialog = _G[name_config];
		if InCombatLockdown() then
			DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't toggle menu while in combat");
		else
			ZMobDB_ConfigDialog:Show();
		end
	elseif (((strfind(commandName,"reflesh")))) then
		for i=0,19 do
			if i~=9 then
				local name_camera = "ZMobDB_Camera"..i;
				local camera = _G[name_camera];
				ZMobDB_BoundingBox_Reflesh_sub(camera);
			end
		end

	elseif (((strfind(commandName,"cleardatabase")))) then
		DEFAULT_CHAT_FRAME:AddMessage("All Model Data Cleared");
		ZMobDB_table = { default = { scale = 1, zoom = 0, position = {0,0}, rotation = 0 ,autoport = "off", }	};
	elseif (((strfind(commandName,"testbox")))) then
		local name_test = "ZMobDB_AnimationTest_Dialog";
		local name_20 = "ZMobDB_Camera20";
		local ZMobDB_AnimationTest = _G[name_test];
		local bBox_20 = _G[name_20];
		if InCombatLockdown() then
			DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't toggle menu while in combat");
		else
			ZMobDB_AnimationTest:Show();
			bBox_20:Show();
		end
	elseif (((strfind(commandName,"resetbox")))) then
		ZMobDB_SetOption("Settings","ResetSwitch","on");
		DEFAULT_CHAT_FRAME:AddMessage("All Windows Reset to Default when next login");
	
	elseif (((strfind(commandName,"tilt")))) then

		local direction,params2 = ZMobDB_Extract_NextParameter(params);
		local p = ZMobDB_Extract_NextParameter(params2);
		local amount = 0.5

		if (p) then
			amount = tonumber(p)
		end

		if (direction == null) then
			direction = "right"
		end

		local model = _G["ZMobDB_Camera0"]

		if (model) then

			local parent = _G["ZMobDB_Camera0"]
			local model = _G["ZMobDB_Camera0_Avatar"] or _G["ZMobDB_Camera0_Model"]
				for _, child in ipairs({ parent:GetChildren() }) do
				local t = child:GetObjectType()
				if t == "PlayerModel" or t == "Model" or t == "DressUpModel" or t == "CinematicModel" or t == "ModelScene" then
					model = child
					break
				end
			end
			if (model) then
				model:SetUnit("player")
				if (direction == "right") then
					model:SetPitch(-amount)
					model:SetPitch(amount)
				else
					model:SetPitch(amount)
					model:SetPitch(-amount)

				end
				ZMobDB_Settings_RefreshBoundingBox(parent);
			end
		
		end

	elseif (((strfind(commandName,"flip")))) then
		local direction,params2 = ZMobDB_Extract_NextParameter(params);
		local model = _G["ZMobDB_Camera0"]

		if (model) then

			local parent = _G["ZMobDB_Camera0"]
			local model = _G["ZMobDB_Camera0_Avatar"] or _G["ZMobDB_Camera0_Model"]
				for _, child in ipairs({ parent:GetChildren() }) do
				local t = child:GetObjectType()
				if t == "PlayerModel" or t == "Model" or t == "DressUpModel" or t == "CinematicModel" or t == "ModelScene" then
					model = child
					break
				end
			end
			if (model) then
				model:SetUnit("player")
				if (direction == "left") then
					model:SetFacing(-math.pi / 2)
				end
				if (direction == "right") then
					model:SetFacing(math.pi / 2)
				end
			end
		
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB Command list:");
		DEFAULT_CHAT_FRAME:AddMessage("/ZMOB config -- popup configration window");
		DEFAULT_CHAT_FRAME:AddMessage("/ZMOB delete DataName -- Reset DataName's Model Setting to Default");
		DEFAULT_CHAT_FRAME:AddMessage("/ZMOB copy DataName1,DataName2 --Copy DataName1 Model Setting to DataName2");
		DEFAULT_CHAT_FRAME:AddMessage("/ZMOB copymenu -- popup Copy Menu");
		DEFAULT_CHAT_FRAME:AddMessage("/ZMOB cleardatabase -- delete all model data");
		DEFAULT_CHAT_FRAME:AddMessage("/ZMOB reflesh -- Reflesh All Models");
		DEFAULT_CHAT_FRAME:AddMessage("/ZMOB testbox -- popup animation test window");
		DEFAULT_CHAT_FRAME:AddMessage("/ZMOB slant-- Slant your character model, example: /zmob slant right 0.5");
		DEFAULT_CHAT_FRAME:AddMessage("/ZMOB flip -- Flip your character model left or right, example: /zmob flip right");
	end
end
function ZMobDB_Extract_NextParameter(msg)
	local params = msg;
	local command = params;
	local index = strfind(command," ");
	if (index) then
		command,params = strsplit(" ",msg,2);
	else
		params = "";
	end
	return command, params;
end
function ZMobDB_Extract_3rdParameter(msg)
	local params = msg;
	local command = params;
	local index = strfind(command,",");
	if (index) then
		command,params = strsplit(",",msg,2);
	else
		params = "";
	end
	return command, params;
end
-- ---------------------------------------------------------
-- Timer Handler
-- ---------------------------------------------------------
function ZMobDB_OnUpdate(self,elapsed)
	local name_config = "ZMobDB_Configuration";
	local Config_window = _G[name_config];
	if not(Config_window:IsShown()) then
		Timer_Count=Timer_Count+elapsed;
		Update_Count=Update_Count+elapsed;
		if (Timer_Count>1) then
			Timer_Count = 0;
			ZMobDB_Timer_RandomAnimation();
		end
		if (Update_Count > 0.2) then
			Update_Count = 0;
			local SlowMode = ZMobDB_GetOption("Settings","SlowMode");
			if 
				(SlowMode == "off") or 
				(SlowMode == "all" and Update_Count_sub > 5) or 
				(SlowMode == "party" and (IsInGroup() and not IsInRaid()) and Update_Count_sub > 5) or 
				(SlowMode == "raid" and IsInRaid() and Update_Count_sub > 5) 
			then
				Update_Count_sub = 0;

				for i=0,6 do
					local name_camera = "ZMobDB_Camera"..i;
					local camera = _G[name_camera];
					if camera.PushRefresh == "on" then
						local unittype = ZMobDB_Avatar_GetUnitType(camera:GetChildren());
						if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Show") == "on" and ZMobDB_UnitIsRenderable(unittype) and ZMobDB_db_changed ~= i then
							ZMobDB_Avatar_ModelUpdate(camera:GetChildren());
							ZMobDB_ChangeModel(camera:GetChildren());
							ZMobDB_Change_RaidIcon(camera:GetChildren());
							camera.PushRefresh = "off";
						end
					end
				end

				for i=7,8 do
					local name_camera = "ZMobDB_Camera"..i;
					local camera = _G[name_camera];
					local unittype = ZMobDB_Avatar_GetUnitType(camera:GetChildren());
					if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Show") == "on" then
						if ZMobDB_db_changed ~= i then
							ZMobDB_Avatar_ModelUpdate(camera:GetChildren());
							ZMobDB_ChangeModel(camera:GetChildren());
							ZMobDB_Change_RaidIcon(camera:GetChildren());
						end
					end
				end
				for i=10,13 do
					local name_camera = "ZMobDB_Camera"..i;
					local camera = _G[name_camera];
					local unittype = ZMobDB_Avatar_GetUnitType(camera:GetChildren());
					if 
						ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Show") == "off" or 
						(ZMobDB_GetOption("Settings","HideInRaid") == "on" and IsInRaid()) 
					then
						if ZMobDB_db_changed ~= i then
							ZMobDB_Avatar_ModelUpdate(camera:GetChildren());
							ZMobDB_ChangeModel(camera:GetChildren());
							ZMobDB_Change_RaidIcon(camera:GetChildren());
						end
					end
				end
				for i=14,18 do
					local name_camera = "ZMobDB_Camera"..i;
					local camera = _G[name_camera];
					if camera.PushRefresh == "on" then
						local unittype = ZMobDB_Avatar_GetUnitType(camera:GetChildren());
						if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Show") == "on" and ZMobDB_UnitIsRenderable(unittype) and ZMobDB_db_changed ~= i then
							ZMobDB_Avatar_ModelUpdate(camera:GetChildren());
							ZMobDB_ChangeModel(camera:GetChildren());
							ZMobDB_Change_RaidIcon(camera:GetChildren());
							camera.PushRefresh = "off";
						end
					end
				end

					if ZMobDB_GetOption("focustarget","Show") == "on" then
						if ZMobDB_db_changed ~= 19 then
							local name_camera = "ZMobDB_Camera19";
							local camera = _G[name_camera];
							ZMobDB_Avatar_ModelUpdate(camera:GetChildren());
							ZMobDB_ChangeModel(camera:GetChildren());
							ZMobDB_Change_RaidIcon(camera:GetChildren());
						end
					end
			else
				Update_Count_sub = Update_Count_sub + 1;
			end
		end
	end
end
function ZMobDB_Timer_RandomAnimation()
	for i=0,19 do
		local name_camera = "ZMobDB_Camera"..i;
		local bBox = _G[name_camera];
		if i~= 9 and ZMobDB_db_changed ~= i then
			if 
				ZMobDB_GetOption("Settings","Random_IsNotCombat") == "off" or 
				( ZMobDB_GetOption("Settings","Random_IsNotCombat") == "on" and not(InCombatLockdown()) ) 
			then
				local unittype = ZMobDB_Avatar_GetUnitType(bBox:GetChildren());
				local Unit_word = ZMobDB_Unit_word[unittype];
				if 
					ZMobDB_GetOption(Unit_word,"RandomAnimation") == "on" and 
					bBox:IsShown() 
				then
					if 
						UnitIsPlayer(unittype) and 
						bBox:IsShown() and 
						(ZMobDB_GetOption(Unit_word,"RandomAnimation_IsFriend")=="off" or 
						(UnitIsFriend("player",unittype) and ZMobDB_GetOption(Unit_word,"RandomAnimation_IsFriend")=="on")) 
					then
						bBox.SecondsSinceLastEvent=bBox.SecondsSinceLastEvent+1
						if 
							(UnitAffectingCombat(unittype) == nil and (bBox.SecondsSinceLastEvent>ZMobDB_GetOption(Unit_word,"RandomAnimation_Interval"))) or 
							(not(UnitAffectingCombat(unittype) == nil) and (bBox.SecondsSinceLastEvent>ZMobDB_GetOption(Unit_word,"RandomAnimation_Interval_Combat"))) 
						then
							bBox.SecondsSinceLastEvent = 0;
							if 
								(UnitIsVisible(unittype)) and 
								(UnitExists(unittype)) and 
								bBox:GetChildren().random_anim == nil 
							then
								ZMobDB_RandomAnimation(bBox:GetChildren());
							end
						end
					end
				end
			end
			if bBox:IsShown() and bBox:GetChildren().animationNo == nil then
				if (bBox:GetChildren().renderTick < 4) then
					bBox:GetChildren().renderTick = bBox:GetChildren().renderTick + 1;
				else
					bBox:GetChildren().renderTick = 0;
					ZMobDB_Avatar_AttemptToRender(bBox:GetChildren(),true);
				end
			end
		end
	end
end

-- ---------------------------------------------------------
-- Config Window Event
-- ---------------------------------------------------------
function ZMobDB_Config_OnShow()
	Config_OnShow = 1;
	for i=0,19 do
		if i ~= 9 then
			local name_camera = "ZMobDB_Camera"..i;
			local bBox = _G[name_camera];
			if not(UnitExists(ZMobDB_Avatar_GetUnitType(bBox:GetChildren()))) then
				bBox:GetChildren():ClearModel();
			end
			bBox:SetBackdropColor(0,0.5,1,0.5);
			if ZMobDB_GetOption(ZMobDB_Unit_word[ZMobDB_Avatar_GetUnitType(bBox:GetChildren())],"Show") == "on" then
				bBox:Show();
			else
				bBox:Hide();
			end
		end
	end
		local name_20 = "ZMobDB_Camera20";
		local camera_20 = _G[name_20];
		camera_20:SetBackdropColor(0,0.5,1,0.5);
		Box_name0:Show();
		Box_name1:Show();
		Box_name2:Show();
		Box_name3:Show();
		Box_name4:Show();
		Box_name5:Show();
		Box_name6:Show();
		Box_name7:Show();
		Box_name8:Show();
		Box_name10:Show();
		Box_name11:Show();
		Box_name12:Show();
		Box_name13:Show();
		Box_name14:Show();
		Box_name15:Show();
		Box_name16:Show();
		Box_name17:Show();
		Box_name18:Show();
		Box_name19:Show();
end
function ZMobDB_Config_OnHide()
	for i=0,19 do
		if i~=9 then
			local name_camera = "ZMobDB_Camera"..i;
			local bBox = _G[name_camera];
			if not(UnitExists(ZMobDB_Avatar_GetUnitType(bBox:GetChildren()))) then
				bBox:Hide();
			end
			if 
				ZMobDB_GetOption("Settings","Border") == "tooltip" or 
				ZMobDB_GetOption("Settings","Border") == "black" 
			then
				bBox:SetBackdropColor(0,0,0,1);
			else
				bBox:SetBackdropColor(0,0,0,0);
			end
			if 
				ZMobDB_GetOption(ZMobDB_Unit_word[ZMobDB_Avatar_GetUnitType(bBox:GetChildren())],"Show") == "on" and 
				UnitExists(ZMobDB_Avatar_GetUnitType(bBox:GetChildren())) 
			then
				bBox:Show();
			else
				bBox:Hide();
			end
			ZMobDB_Change_RaidIcon(bBox:GetChildren())
		end
	end
		Box_name0:Hide();
		Box_name1:Hide();
		Box_name2:Hide();
		Box_name3:Hide();
		Box_name4:Hide();
		Box_name5:Hide();
		Box_name6:Hide();
		Box_name7:Hide();
		Box_name8:Hide();
		Box_name10:Hide();
		Box_name11:Hide();
		Box_name12:Hide();
		Box_name13:Hide();
		Box_name14:Hide();
		Box_name15:Hide();
		Box_name16:Hide();
		Box_name17:Hide();
		Box_name18:Hide();
		Box_name19:Hide();
		if (ZMobDB_GetOption("Settings","HideInRaid") == "on") and IsInRaid() then
			i=2,5 do
				local name_camera = "ZMobDB_Camera"..i;
				local bBox = _G[name_camera];
				bBox:Hide();
			end
			i=10,13 do
				local name_camera = "ZMobDB_Camera"..i;
				local bBox = _G[name_camera];
				bBox:Hide();
			end
			i=15,18 do
				local name_camera = "ZMobDB_Camera"..i;
				local bBox = _G[name_camera];
				bBox:Hide();
			end
		end
		for i=0,19 do
			if i~=9 then
				local name_camera = "ZMobDB_Camera"..i;
				local bBox = _G[name_camera];
				ZMobDB_BoundingBox_Reflesh_sub(bBox);
			end
		end
	Config_OnShow = 0;
end
function ZMobDB_Option_Change()
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	local name_config = "ZMobDB_Configuration";
	local Config_window = _G[name_config];

	for i=0,19 do
		if i ~= 9 then
			local name_camera = "ZMobDB_Camera"..i;
			local bBox = _G[name_camera];
			local unittype = ZMobDB_Avatar_GetUnitType(bBox:GetChildren());
			local PotisionSet = ZMobDB_Profile[ZMobDBPlayerIndex][i];
			local name_frame = "ZMobDB_Frame_"..unittype;
			Frame_Name = _G[name_frame];
			if ZMobDB_GetOption("Settings","Border") == "tooltip" or ZMobDB_GetOption("Settings","Border") == "edge" then
				bBox:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                          edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }});
				bBox:GetChildren():SetPoint("TOPLEFT",5,-5);
				bBox:GetChildren():SetPoint("BOTTOMRIGHT",-5,5);
			else
				bBox:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                           edgeFile = ""});
				bBox:GetChildren():SetPoint("TOPLEFT",0,0);
				bBox:GetChildren():SetPoint("BOTTOMRIGHT",0,0);
			end
			if not(Config_window:IsShown()) then
				if 
					ZMobDB_GetOption("Settings","Border") == "tooltip" or 
					ZMobDB_GetOption("Settings","Border") == "black" 
				then
					bBox:SetBackdropColor(0,0,0,1);
				elseif ZMobDB_GetOption("Settings","Border") == "edge" or ZMobDB_GetOption("Settings","Border") == "default" or ZMobDB_GetOption("Settings","Border") == "circle" then
					bBox:SetBackdropColor(0,0,0,0);
				end
			else
				bBox:SetBackdropColor(0,0.5,1,0.5);
			end

			if 
				ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Show") == "off" or 
				(ZMobDB_GetOption("Settings","HideInRaid") == "on" and 
				IsInRaid() and 
				(ZMobDB_Unit_word[unittype] == "party" or 
				ZMobDB_Unit_word[unittype] == "partytarget" or 
				ZMobDB_Unit_word[unittype] == "partypet")) 
			then
				UnregisterUnitWatch(Frame_Name);
				bBox:Hide();
				Frame_Name:Hide();
				PotisionSet.isEnabled = false;
				PotisionSet.cursorControls.isEnabled = false;
				-- bBox:GetChildren():SetScript("OnEvent",nil);
				-- bBox:GetChildren():UnregisterAllEvents();
				-- bBox:SetScript("OnUpdate",nil)
			else
				PotisionSet.isEnabled = true;
				PotisionSet.cursorControls.isEnabled = true;
				bBox:SetFrameStrata(ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Strata"));
				-- bBox:SetScript("OnUpdate",ZMobDB_BoundingBox_OnUpdate)
				if Config_window:IsShown() then
					bBox:Show();
				end
					Frame_Name:SetFrameStrata(bBox:GetFrameStrata());
					Frame_Name:SetFrameLevel(bBox:GetFrameLevel() + 1);
					Frame_Name:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT",PotisionSet.anchor.x,PotisionSet.anchor.y);
					Frame_Name:SetWidth(PotisionSet.scale.width);
					Frame_Name:SetHeight(PotisionSet.scale.height);
					bBox:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT",PotisionSet.anchor.x,PotisionSet.anchor.y);
					bBox:SetWidth(PotisionSet.scale.width);
					bBox:SetHeight(PotisionSet.scale.height);
			ZMobDB_Avatar_ModelUpdate(bBox:GetChildren());
			ZMobDB_ChangeModel(bBox:GetChildren());
			ZMobDB_Change_RaidIcon(bBox:GetChildren());

				if ZMobDB_GetOption("Settings","HoldBox") == "on" then
					RegisterUnitWatch(Frame_Name);
				else
					UnregisterUnitWatch(Frame_Name);
					Frame_Name:Hide();
				end
			end

			ZMobDB_Change_RaidIcon(bBox:GetChildren());

			if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Port")=="on" then
				-- bBox:GetChildren():SetCamera(0);
						bBox:GetChildren():SetPortraitZoom(1);
						bBox:GetChildren():SetPosition(0,0,0);
						bBox:GetChildren():ClearModel();
						bBox:GetChildren():SetUnit(unittype);
			else
				-- bBox:GetChildren():SetCamera(2);
						bBox:GetChildren():SetPortraitZoom(0);
			end

			-- bBox:SetScript("OnEnter",ZMobDB_Tooltip_Unit);
			Frame_Name:SetScript("OnEnter",ZMobDB_Tooltip_Unit);

			if ZMobDB_GetOption("Settings","Mouseoverthrough")=="on" then
				bBox:SetScript("OnEnter",ZMobDB_Mouseover_OnEnter);
				Frame_Name:SetWidth(0);
				Frame_Name:SetHeight(0);
			end

			if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"EnableMouse")=="on" then
				PotisionSet.cursorControls.isEnabled = true;
			else
				PotisionSet.cursorControls.isEnabled = false;
				Frame_Name:SetWidth(0);
				Frame_Name:SetHeight(0);
			end
			if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Animation_Stealth") =="on" then
				bBox:GetChildren():SetAlpha(1);
			end
		end
	end

	ZMobDB_RandomAnimation_Table = {};
	ZMobDB_HitAnimation_Table = {};

	if ZMobDB_GetOption("Settings","Random_Wave")=="on" then table.insert(ZMobDB_RandomAnimation_Table, "Wave") end;
	if ZMobDB_GetOption("Settings","Random_Rude")=="on" then table.insert(ZMobDB_RandomAnimation_Table, "Rude") end;
	if ZMobDB_GetOption("Settings","Random_Roar")=="on" then table.insert(ZMobDB_RandomAnimation_Table, "Roar") end;
	if ZMobDB_GetOption("Settings","Random_Kiss")=="on" then table.insert(ZMobDB_RandomAnimation_Table, "Kiss") end;
	if ZMobDB_GetOption("Settings","Random_Chicken")=="on" then table.insert(ZMobDB_RandomAnimation_Table, "Chicken") end;
	if ZMobDB_GetOption("Settings","Random_Applause")=="on" then table.insert(ZMobDB_RandomAnimation_Table, "Applause") end;
	if ZMobDB_GetOption("Settings","Random_Flex")=="on" then table.insert(ZMobDB_RandomAnimation_Table, "Flex") end;
	if ZMobDB_GetOption("Settings","Random_Point")=="on" then table.insert(ZMobDB_RandomAnimation_Table, "Point") end;
	if ZMobDB_GetOption("Settings","Random_Shout")=="on" then table.insert(ZMobDB_RandomAnimation_Table, "Shout") end;
	if ZMobDB_GetOption("Settings","Random_Run")=="on" then table.insert(ZMobDB_RandomAnimation_Table, "Run") end;

	if ZMobDB_GetOption("Settings","Hit_Flinch")=="on" then table.insert(ZMobDB_HitAnimation_Table, "Flinch") end;
	if ZMobDB_GetOption("Settings","Hit_Flinch2")=="on" then table.insert(ZMobDB_HitAnimation_Table, "Flinch2") end;
	if ZMobDB_GetOption("Settings","Hit_Spell")=="on" then table.insert(ZMobDB_HitAnimation_Table, "Spell") end;
	if ZMobDB_GetOption("Settings","Hit_Spell2")=="on" then table.insert(ZMobDB_HitAnimation_Table, "Spell2") end;
	if ZMobDB_GetOption("Settings","Hit_Run")=="on" then table.insert(ZMobDB_HitAnimation_Table, "Run") end;
	if ZMobDB_GetOption("Settings","Hit_WalkBack")=="on" then table.insert(ZMobDB_HitAnimation_Table, "WalkBack") end;
	if ZMobDB_GetOption("Settings","Hit_Channeling")=="on" then table.insert(ZMobDB_HitAnimation_Table, "Channeling") end;

		for i=0,19 do
			if i~=9 then
				local name_camera = "ZMobDB_Camera"..i;
				local camera = _G[name_camera];
				ZMobDB_BoundingBox_Reflesh_sub(camera);
			end
		end

	if Config_window:IsShown() then
		ZMobDB_Config_OnShow()
	end
	Option_Change_loaded = 1;
end

-- ---------------------------------------------------------
-- Animation,Eye Catch
-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- Event Animation
-- ---------------------------------------------------------
function ZMobDB_EventAnimation(avatar,unittype)
	if 
		ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"EventAnimation") == "on" and 
		ZMobDB_db_changed ~= avatar:GetParent():GetID() 
	then
		local stats,pre_stats,ghost_model = ZMobDB_GetStats(unittype);
		if 
			not(stats == "Ghost" or 
			stats == "Ice" or 
			stats == "Shackle" or 
			stats == "Fear" or 
			stats == "Cyclone" or 
			stats == "Seduce" or 
			stats == "Banish" or 
			stats == "Sleep" or 
			stats == "Shield" or 
			stats == "Bandage") 
		then
			if stats ~= "Normal" then
				if stats ~= pre_stats then
					ZMobDB_Animation_stats[unittype].pre_stats = stats;
					ZMobDB_StartAnimation(avatar,stats,"on");
				end
			else
				if pre_stats ~= "Normal" then
					ZMobDB_Animation_stats[unittype].pre_stats = "Normal";
					ZMobDB_ResetAnimation(avatar);
				end
			end
		end
	end
end
-- ---------------------------------------------------------
-- Random Animation
-- ---------------------------------------------------------
function ZMobDB_RandomAnimation(avatar)
	local unittype = ZMobDB_Avatar_GetUnitType(avatar);
	local Unit_Buff,Unit_DeBuff,Unit_Shape,Unit_Stealth = ZMobDB_Get_Unit_Aura(unittype);
	local Unit_word = ZMobDB_Unit_word[unittype];
	local random_anim = nil;
	if 
		Unit_Shape == "Normal" 
	then
		local stats,pre_stats,ghost_model = ZMobDB_GetStats(unittype);
		if stats == "Normal" and pre_stats == "Normal" and ZMobDB_db_changed ~= avatar:GetParent():GetID() then
			if UnitAffectingCombat(unittype)==nil then
				if (getn(ZMobDB_RandomAnimation_Table) == 0) then return end
				if math.random(100) < ZMobDB_GetOption(Unit_word,"RandomAnimation_Rate") then
					random_anim = ZMobDB_RandomAnimation_Table[math.random(#(ZMobDB_RandomAnimation_Table))];
					avatar.random_anim = random_anim;
					ZMobDB_StartAnimation(avatar,random_anim,ZMobDB_GetOption(Unit_word,"RandomAnimation_ChangeView"));
					avatar.random_anim = nil;
				end
			else
				if (getn(ZMobDB_HitAnimation_Table) == 0) then return end
				if math.random(100) < ZMobDB_GetOption(Unit_word,"RandomAnimation_Rate_Combat") then
					random_anim = ZMobDB_HitAnimation_Table[math.random(#(ZMobDB_HitAnimation_Table))];
					avatar.random_anim = random_anim;
					ZMobDB_StartAnimation(avatar,random_anim,ZMobDB_GetOption(Unit_word,"RandomAnimation_ChangeView"));
					avatar.random_anim = nil;
				end
			end
		end
	end
end
-- ---------------------------------------------------------
-- Eye Catch Animation
-- ---------------------------------------------------------
function ZMobDB_ChangeModel(avatar,OnShow)
	local db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport;
	local unittype = ZMobDB_Avatar_GetUnitType(avatar);
	local Unit_word = ZMobDB_Unit_word[unittype];
	local id = avatar:GetParent():GetID();
	local name_frame = "ZMobDB_Frame_"..unittype;
	local Frame_Name = _G[name_frame];
	local name_config = "ZMobDB_Configuration";
	local Config_Window = _G[name_config];
	local stats,pre_stats,ghost_model = ZMobDB_GetStats(unittype);
	local stats_test = ZMobDB_GetOption("Settings","Select_Animation");
	local Ghost_Model = nil;
	local x = GetNumBattlefieldScores();
	local Unit_Buff,Unit_DeBuff,Unit_Shape,Unit_Stealth = ZMobDB_Get_Unit_Aura(unittype);

	-- ---------------------------------------------------------
	-- Ghost Model
	-- ---------------------------------------------------------
	if id ~= 20 and id ~= 9 and ZMobDB_db_changed ~= id then
		if UnitExists(unittype) then
			if stats == "Ghost" and ZMobDB_GetOption(Unit_word,"Animation_Ghost")=="on" then
				if pre_stats ~= "Ghost" then
					ZMobDB_Animation_stats[unittype].pre_stats = "Ghost";
					if ZMobDB_GetOption("Settings","Ghost_Model_name") == "random" then
						Ghost_Model = ZMobDBGhost_Name[math.random(5)];
					elseif ZMobDB_GetOption("Settings","Ghost_Model_name") == "random_bg" then
						if x > 0 then
							Ghost_Model = "flag";
						else
							Ghost_Model = ZMobDBGhost_Name[math.random(5)];
						end
					else
						Ghost_Model = ZMobDB_GetOption("Settings","Ghost_Model_name");
					end
					ZMobDB_Animation_stats[unittype].ghost_model = Ghost_Model;
					db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport = ZMobDB_GetModelSetting(avatar);
					avatar.animationNo = nil;
					avatar.nextNo = nil;
					avatar.frameNo = 0;
					avatar.frameEndNo = 0;
					avatar:SetScript("OnUpdate",nil);
					-- avatar:SetCamera(2);
					avatar:SetPortraitZoom(0);
					avatar:GetParent().DataName = db_name_ani;
					if Ghost_Model == "flag" then
						if UnitFactionGroup("player") == "Horde" then
							Ghost_Model = "Horde_Flag";
						else
							Ghost_Model = "Alliance_Flag";
						end
					end
					if (ZMobDB_Event_Animation[Ghost_Model].File) then
						local ok = pcall(function() avatar:SetModel(MobDB_Event_Animation[Ghost_Model].File) end)
						if not ok then
							avatar:ClearModel()
						else
							avatar:SetModel(ZMobDB_Event_Animation[Ghost_Model].File);
							ZMobDB_Avatar_SetZoom(avatar, db_zoom_ani);
							ZMobDB_Avatar_SetPosition(avatar, db_position_ani[1], db_position_ani[2]);
							if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"FixFace") =="off" then
								ZMobDB_Avatar_SetRotation(avatar, db_rotation_ani);
							end
							ZMobDB_Avatar_SetScale(avatar, db_scale_ani);
						end
					end
				end
			-- ---------------------------------------------------------
			-- IceBlock,Shackle,Fear,Cyclone,Seduce
			-- ---------------------------------------------------------
			elseif 
				ZMobDB_Animation_stats[unittype].pre_stats ~= stats and 
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
				if ZMobDB_GetOption(Unit_word,"Animation_"..stats)=="on" then
					ZMobDB_Animation_stats[unittype].pre_stats = stats;
					db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport = ZMobDB_GetModelSetting(avatar);
					avatar.animationNo = nil;
					avatar.nextNo = nil;
					avatar.frameNo = 0;
					avatar.frameEndNo = 0;
					avatar:SetScript("OnUpdate",nil);
					-- avatar:SetCamera(2);
					avatar:SetPortraitZoom(0);
					avatar:GetParent().DataName = db_name_ani;

					if (InCombatLockdown()) then
					else
						if (ZMobDB_Event_Animation[stats].File) then
							avatar:SetModel(ZMobDB_Event_Animation[stats].File);
							ZMobDB_Avatar_SetZoom(avatar, db_zoom_ani);
							ZMobDB_Avatar_SetPosition(avatar, db_position_ani[1], db_position_ani[2]);
							if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"FixFace") =="off" then
								ZMobDB_Avatar_SetRotation(avatar, db_rotation_ani);
							end
							ZMobDB_Avatar_SetScale(avatar, db_scale_ani);
						end
					end
				end
			-- ---------------------------------------------------------
			-- Out of Range Mark
			-- ---------------------------------------------------------
			elseif 
				unittype ~="pet" and 
				stats ~="Ghost" and 
				ZMobDB_GetOption("Settings","Symbol") == "on" 
			then
				if not(UnitIsVisible(unittype)) then
					if avatar.mark ~="on" or (OnShow) then
						-- avatar:SetCamera(2);
						if InCombatLockdown() then
						else
							avatar:SetPortraitZoom(0);

							local path = "Interface\\Buttons\\talktomequestion_ltblue.mdx"
							if path and path ~= "" then
								local ok = pcall(function() avatar:SetModel(path) end)
								if not ok then
									avatar:ClearModel()
								end
							else
								avatar:ClearModel()
							end
							avatar.mark ="on";
						end
					end
					avatar:SetModelScale(4.25);
					avatar:SetPosition(0,0,-1.5);
				else
					avatar.mark ="off";
				end
			end
		else
			if not(Config_Window:IsShown()) then
				avatar:GetParent():Hide();
			end
		end

		-- ---------------------------------------------------------
		-- Stealth,Invisible Model Alpha
		-- ---------------------------------------------------------
		if 
			UnitIsVisible(unittype) and 
			(Unit_Stealth =="Stealth" or Unit_Stealth =="Invisi") and 
			ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Animation_Stealth") =="on" and 
			not (stats == "Ice" or 
			stats == "Shackle" or 
			stats == "Fear" or 
			stats == "Cyclone" or 
			stats == "Seduce" or 
			stats == "Banish" or 
			stats == "Sleep" or 
			stats == "Shield" or 
			stats == "Bandage") 
		then
			avatar:SetAlpha(ZMobDB_GetOption("Settings","AlphaRate")/100);
		elseif ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Animation_Stealth") =="on" then
			avatar:SetAlpha(1);
		end
	-- ---------------------------------------------------------
	-- Animation Test Ghost Model
	-- ---------------------------------------------------------
	elseif id == 20 and ZMobDB_db_changed ~= 20 and UnitExists("target") and UnitIsPlayer("target") then
		if stats_test == "Ghost" then
			if ZMobDB_GetOption("Settings","Ghost_Model_name") == "random" or ZMobDB_GetOption("Settings","Ghost_Model_name") == "random_bg" then
				Ghost_Model = ZMobDBGhost_Name[math.random(5)];
			else
				Ghost_Model = ZMobDB_GetOption("Settings","Ghost_Model_name");
			end
			db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport = ZMobDB_GetModelSetting(avatar);
			avatar.animationNo = nil;
			avatar.nextNo = nil;
			avatar.frameNo = 0;
			avatar.frameEndNo = 0;
			avatar:SetScript("OnUpdate",nil);
			-- avatar:SetCamera(2);
			avatar:SetPortraitZoom(0);
			avatar:GetParent().DataName = db_name_ani;
			if Ghost_Model == "flag" then
				if UnitFactionGroup("player") == "Horde" then
					Ghost_Model = "Horde_Flag";
				else
					Ghost_Model = "Alliance_Flag";
				end
			end
			avatar:SetModel(ZMobDB_Event_Animation[Ghost_Model].File);
			ZMobDB_Avatar_SetZoom(avatar, db_zoom_ani);
			ZMobDB_Avatar_SetPosition(avatar, db_position_ani[1], db_position_ani[2]);
			ZMobDB_Avatar_SetRotation(avatar, db_rotation_ani);
			ZMobDB_Avatar_SetScale(avatar, db_scale_ani);
		-- ---------------------------------------------------------
		-- IceBlock,Shackle,Fear,Cyclone,Seduce
		-- ---------------------------------------------------------
		elseif 
			(stats_test == "Ice" or 
			stats_test == "Shackle" or 
			stats_test == "Fear" or 
			stats_test == "Cyclone" or 
			stats_test == "Seduce" or 
			stats_test == "Banish" or 
			stats_test == "Sleep" or 
			stats_test == "Shield" or 
			stats_test == "Bandage") 
		then
			db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport = ZMobDB_GetModelSetting(avatar);
			avatar.animationNo = nil;
			avatar.nextNo = nil;
			avatar.frameNo = 0;
			avatar.frameEndNo = 0;
			avatar:SetScript("OnUpdate",nil);
			-- avatar:SetCamera(2);
			avatar:SetPortraitZoom(0);
			avatar:GetParent().DataName = db_name_ani;
			avatar:SetModel(ZMobDB_Event_Animation[stats_test].File);
			ZMobDB_Avatar_SetZoom(avatar, db_zoom_ani);
			ZMobDB_Avatar_SetPosition(avatar, db_position_ani[1], db_position_ani[2]);
			ZMobDB_Avatar_SetRotation(avatar, db_rotation_ani);
			ZMobDB_Avatar_SetScale(avatar, db_scale_ani);
		-- ---------------------------------------------------------
		-- Out of Range Mark
		-- ---------------------------------------------------------
		elseif stats_test ~="Ghost" then
			if not(UnitIsVisible(unittype)) then
				-- avatar:SetCamera(2);
				avatar:SetPortraitZoom(0);
				avatar:SetModel("Interface\\Buttons\\talktomequestion_ltblue.mdx");
				avatar.mark ="on";
				avatar:SetModelScale(4.25);
				avatar:SetPosition(0,0,-1.5);
			end
		end
		-- ---------------------------------------------------------
		-- Stealth,Invisible Model Alpha
		-- ---------------------------------------------------------
		if 
			stats_test == "Stealth" and 
			not (stats_test == "Ice" or 
			stats_test == "Shackle" or 
			stats_test == "Fear" or 
			stats_test == "Cyclone" or 
			stats_test == "Seduce" or 
			stats_test == "Banish" or 
			stats_test == "Sleep" or 
			stats_test == "Shield" or 
			stats_test == "Bandage") 
		then
			avatar:SetAlpha(ZMobDB_GetOption("Settings","AlphaRate")/100);
		else
			avatar:SetAlpha(1);
		end
	end
end
-- ---------------------------------------------------------
-- Raid Icon,PvP Icon
-- ---------------------------------------------------------
function ZMobDB_Change_RaidIcon(avatar)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	local unittype = ZMobDB_Avatar_GetUnitType(avatar);
	local Unit_word = ZMobDB_Unit_word[unittype];
	local name_frame = "ZMobDB_Frame_"..unittype;
	local Frame_Name = _G[name_frame];
	local name_raid = "ZMobDB_Frame_"..unittype.."_RaidIcon";
	local texture_raid = _G[name_raid];
	local name_pvp = "ZMobDB_Frame_"..unittype.."_PvPIcon";
	local texture_pvp = _G[name_pvp];
	local targetIndex = GetRaidTargetIndex(unittype);
	local factionGroup = UnitFactionGroup(unittype);
	local PotisionSet = ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()];
	local PositionX = ZMobDB_GetOption(Unit_word,"PvPIcon_PositionX");
	local PositionY = ZMobDB_GetOption(Unit_word,"PvPIcon_PositionY");

	if ZMobDB_GetOption(Unit_word,"RaidIcon")=="on" and (targetIndex) then
		texture_raid:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons");
		texture_raid:ClearAllPoints();
		texture_raid:SetWidth(PotisionSet.scale.width * ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"RaidIcon_Size") / 100);
		texture_raid:SetHeight(PotisionSet.scale.width * ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"RaidIcon_Size") / 100);
		texture_raid:SetPoint(ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"RaidIcon_Position"),Frame_Name, ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"RaidIcon_Position"),0,0);
		SetRaidTargetIconTexture(texture_raid, targetIndex);
		texture_raid:Show();
		texture_pvp:Hide();
	elseif ZMobDB_GetOption(Unit_word,"PvPIcon")=="on" then
		if ( UnitIsPVPFreeForAll(unittype) ) then
			texture_pvp:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
			texture_pvp:ClearAllPoints();
			texture_pvp:SetWidth(ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"PvPIcon_Size"));
			texture_pvp:SetHeight(ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"PvPIcon_Size"));
			texture_pvp:SetPoint(ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"RaidIcon_Position"),Frame_Name, ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"RaidIcon_Position"),PositionX,PositionY);
			texture_pvp:Show();
			texture_raid:Hide();
		elseif ( factionGroup and UnitIsPVP(unittype)) then
			texture_pvp:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
			texture_pvp:ClearAllPoints();
			texture_pvp:SetWidth(ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"PvPIcon_Size"));
			texture_pvp:SetHeight(ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"PvPIcon_Size"));
			texture_pvp:SetPoint(ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"RaidIcon_Position"),Frame_Name, ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"RaidIcon_Position"),PositionX,PositionY);
			texture_pvp:Show();
			texture_raid:Hide();
		else
			texture_pvp:Hide();
			texture_raid:Hide();
		end
	else
		texture_raid:Hide();
		texture_pvp:Hide();
	end
end
-- --------------------------------------------------------
-- Animation System
-- --------------------------------------------------------
function ZMobDB_StartAnimation(avatar,animation,change_view)
	-- avatar:SetCamera(2);
	avatar:SetPortraitZoom(0);
	-- avatar:RefreshUnit();
	ZMobDB_Avatar_Refresh(avatar)
	avatar.animationNo = nil;
	avatar.nextNo = nil;
	avatar.frameNo = 0;
	avatar.frameEndNo = 0;
	avatar:SetScript("OnUpdate",nil);

	local db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport = ZMobDB_GetModelSetting(avatar);
	ZMobDB_Avatar_SetRendered(avatar, false);
	ZMobDB_Avatar_AttemptToRender(avatar, true);
	if change_view == "on" or avatar.port == "on" then
		ZMobDB_Avatar_SetZoom(avatar, db_zoom_ani);
		ZMobDB_Avatar_SetPosition(avatar, db_position_ani[1], db_position_ani[2]);
		if ZMobDB_GetOption(ZMobDB_Unit_word[ZMobDB_Avatar_GetUnitType(avatar)],"FixFace") =="off" then
			ZMobDB_Avatar_SetRotation(avatar, db_rotation_ani);
		end
		ZMobDB_Avatar_SetScale(avatar, db_scale_ani);
		avatar:GetParent().DataName = db_name_ani;
	else
		ZMobDB_Avatar_SetZoom(avatar, db_zoom);
		ZMobDB_Avatar_SetPosition(avatar, db_position[1], db_position[2]);
		if ZMobDB_GetOption(ZMobDB_Unit_word[ZMobDB_Avatar_GetUnitType(avatar)],"FixFace") =="off" then
			ZMobDB_Avatar_SetRotation(avatar, db_rotation);
		end
		ZMobDB_Avatar_SetScale(avatar, db_scale);
		avatar:GetParent().DataName = db_name;
	end
	avatar.animationNo = ZMobDB_Event_Animation[animation].No;
	avatar.nextNo = ZMobDB_Event_Animation[animation].nextNo;
	avatar.frameNo = 0;
	avatar.frameEndNo = ZMobDB_Event_Animation[animation].Frames;

	if animation =="Dead" then
		if ZMobDB_Get_Unit_File(avatar) == "dwarfmale" then
			avatar.animationNo = 121;
			avatar.nextNo = "Dead";
			avatar.frameNo = 0;
			avatar.frameEndNo = 857;
		elseif ZMobDB_Get_Unit_File(avatar) == "draeneimale" then
			avatar.animationNo = 121;
			avatar.nextNo = "Dead";
			avatar.frameNo = 0;
			avatar.frameEndNo = 666;
		elseif ZMobDB_Get_Unit_File(avatar) == "draeneifemale" then
			avatar.animationNo = 121;
			avatar.nextNo = "Dead";
			avatar.frameNo = 0;
			avatar.frameEndNo = 812;
		end
	end

	avatar:SetScript("OnUpdate",ZMobDB_Avatar_OnUpdate);
end

function ZMobDB_ResetAnimation(avatar)

	avatar.animationNo = nil;
	avatar.nextNo = nil;
	avatar.frameNo = 0;
	avatar.frameEndNo = 0;
	avatar:SetScript("OnUpdate",nil);

	if avatar:GetParent():IsShown() then
		local db_name,db_name_ani,db_select,db_select_ani,db_zoom,db_position,db_rotation,db_scale,db_zoom_ani,db_position_ani,db_rotation_ani,db_scale_ani,db_autoport = ZMobDB_GetModelSetting(avatar);
		ZMobDB_Avatar_SetRendered(avatar, false);
		ZMobDB_Avatar_AttemptToRender(avatar, true);

		ZMobDB_Avatar_Refresh(avatar);

		ZMobDB_Avatar_SetZoom(avatar, db_zoom);
		ZMobDB_Avatar_SetPosition(avatar, db_position[1], db_position[2]);
		if ZMobDB_GetOption(ZMobDB_Unit_word[ZMobDB_Avatar_GetUnitType(avatar)],"FixFace") =="off" then
			ZMobDB_Avatar_SetRotation(avatar, db_rotation);
		end
		ZMobDB_Avatar_SetScale(avatar, db_scale);
		if db_select == "default" then
			-- avatar:SetModelScale(1);
			avatar:RefreshUnit();
		end
		avatar:GetParent().DataName = db_name;
		if ZMobDB_GetOption(ZMobDB_Unit_word[ZMobDB_Avatar_GetUnitType(avatar)],"Port")=="on" or db_autoport == "on" then
			-- avatar:SetCamera(0);
			avatar:SetPortraitZoom(1);
			avatar:SetPosition(0,0,0);
			avatar:ClearModel();
			avatar:SetUnit(ZMobDB_Avatar_GetUnitType(avatar));
			avatar.port = "on";
		end
	end
	avatar:GetParent().SecondsSinceLastEvent=0
end

function ZMobDB_Avatar_OnUpdate(self,elapsed)
	if self.animationNo then
		self.frameNo = self.frameNo + (elapsed * 1000);
		if self.frameEndNo then
			if self.frameNo > self.frameEndNo then
				self.frameNo = self.frameEndNo;
			end
		end

		self:SetSequenceTime(self.animationNo,self.frameNo);

		if self.frameEndNo then
			if self.frameNo > self.frameEndNo then
				if (self.nextNo) then
					ZMobDB_StartAnimation(self, self.nextNo,"off");
				else
					self.random_anim = nil;
					ZMobDB_ResetAnimation(self);
				end
			end
		end
	end
end
-- ---------------------------------------------------------
-- DropDown Menu
-- ---------------------------------------------------------
function ZMobDB_DropDownMenu(self,id)
	local name = "ZMobDB_Camera"..id;
	local frame = _G[name];
	local unittype = ZMobDB_Avatar_GetUnitType(frame:GetChildren());
	local name_dropdown = "ZMobDB_Frame_"..unittype.."_DropDown";
	local frame_dropdown = _G[name_dropdown];
	if 
		not(frame_dropdown:IsShown()) and 
		(ZMobDB_CursorControl_IsActive(self, "Dropdown") or ZMobDB_CursorControl_IsActive(self, "Reflesh_Dropdown"))
	then
		if 
			unittype == "player" or 
			unittype == "pet" or 
			unittype == "target" or 
			unittype == "targettarget" or 
			unittype == "pettarget" or 
			unittype == "focus" or 
			unittype == "focustarget"
		then
			ToggleDropDownMenu(1, nil, frame_dropdown, "ZMobDB_Frame_"..unittype, 40, 0);
		elseif 
			unittype == "party1" or 
			unittype == "party2" or 
			unittype == "party3" or 
			unittype == "party4" or 
			unittype == "party1pet" or 
			unittype == "party2pet" or 
			unittype == "party3pet" or 
			unittype == "party4pet" or 
			unittype == "party1target" or 
			unittype == "party2target" or 
			unittype == "party3target" or 
			unittype == "party4target" 
		then
			ToggleDropDownMenu(1, nil, frame_dropdown, "ZMobDB_Frame_"..unittype, 0, 0);
		end
	end
end
function ZMobDB_Player_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_Player_DropDown_Initialize, "MENU");
	print('DEBUGG: ', UnitPopupFrames)
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_Target_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_Target_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, "ZMobDB_Frame_target_DropDown");
end
function ZMobDB_Pet_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_Pet_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_TargetTarget_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_TargetTarget_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_PetTarget_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_PetTarget_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_Focus_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_Focus_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_Party1_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_Party1_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_Party2_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_Party2_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_Party3_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_Party3_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_Party4_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_Party4_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_PartyTarget1_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_PartyTarget1_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_PartyTarget2_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_PartyTarget2_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_PartyTarget3_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_PartyTarget3_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_PartyTarget4_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_PartyTarget4_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_PartyPet1_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_PartyPet1_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_PartyPet2_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_PartyPet2_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_PartyPet3_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_PartyPet3_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_PartyPet4_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_PartyPet4_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end
function ZMobDB_FocusTarget_DropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, ZMobDB_FocusTarget_DropDown_Initialize, "MENU");
	tinsert(UnitPopupFrames, self:GetName());
end

function ZMobDB_Player_DropDown_Initialize(self)
	if ( PlayerFrame.unit == "vehicle" ) then
		UnitPopup_ShowMenu(ZMobDB_Frame_player_DropDown, "VEHICLE", "vehicle");
	else
		UnitPopup_ShowMenu(ZMobDB_Frame_player_DropDown, "SELF", "player");
	end
end
function ZMobDB_Target_DropDown_Initialize()
	local menu, name;
	local id = nil;
	if (UnitIsUnit("target", "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit("target", "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit("target", "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer("target")) then
		id = UnitInRaid("target");
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty("target")) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_target_DropDown, menu, "target", name, id);
	end
end
function ZMobDB_Pet_DropDown_Initialize()
	if ( UnitExists(PetFrame.unit) ) then
		if ( PetFrame.unit == "player" ) then
			UnitPopup_ShowMenu(ZMobDB_Frame_pet_DropDown, "SELF", "player");
		else
			if ( UnitIsUnit("pet", "vehicle") ) then
				UnitPopup_ShowMenu(ZMobDB_Frame_pet_DropDown, "VEHICLE", "vehicle");
			else
				UnitPopup_ShowMenu(ZMobDB_Frame_pet_DropDown, "PET", "pet");
			end
		end
	end
end
function ZMobDB_TargetTarget_DropDown_Initialize()
	local menu, name;
	local id = nil;
	if (UnitIsUnit("targettarget", "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit("targettarget", "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit("targettarget", "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer("targettarget")) then
		id = UnitInRaid("targettarget");
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty("targettarget")) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_targettarget_DropDown, menu, "targettarget", name, id);
	end
end
function ZMobDB_PetTarget_DropDown_Initialize()
	local menu, name;
	local id = nil;
	if (UnitIsUnit("pettarget", "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit("pettarget", "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit("pettarget", "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer("pettarget")) then
		id = UnitInRaid("pettarget");
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty("pettarget")) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_pettarget_DropDown, menu, "pettarget", name, id);
	end
end
function ZMobDB_Focus_DropDown_Initialize()
	local menu, name;
	local id = nil;
	if (UnitIsUnit("focus", "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit("focus", "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit("focus", "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer("focus")) then
		id = UnitInRaid("focus");
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty("focus")) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_focus_DropDown, menu, "focus", name, id);
	end
end
function ZMobDB_Party1_DropDown_Initialize()
	local menu, name;
	local id = nil;
	currentunit = "party1";
	id = UnitInRaid(currentunit);
	if (id) then
		menu = "RAID_PLAYER";
		name = GetRaidRosterInfo(id + 1);
	else
		menu = "PARTY";
	end

	UnitPopup_ShowMenu(ZMobDB_Frame_party1_DropDown, menu, currentunit, name, id);
end
function ZMobDB_Party2_DropDown_Initialize()
	local menu, name;
	local id = nil;
	currentunit = "party2";
	id = UnitInRaid(currentunit);
	if (id) then
		menu = "RAID_PLAYER";
		name = GetRaidRosterInfo(id + 1);
	else
		menu = "PARTY";
	end

	UnitPopup_ShowMenu(ZMobDB_Frame_party2_DropDown, menu, currentunit, name, id);
end
function ZMobDB_Party3_DropDown_Initialize()
	local menu, name;
	local id = nil;
	currentunit = "party3";
	id = UnitInRaid(currentunit);
	if (id) then
		menu = "RAID_PLAYER";
		name = GetRaidRosterInfo(id + 1);
	else
		menu = "PARTY";
	end

	UnitPopup_ShowMenu(ZMobDB_Frame_party3_DropDown, menu, currentunit, name, id);
end
function ZMobDB_Party4_DropDown_Initialize()
	local menu, name;
	local id = nil;
	currentunit = "party4";
	id = UnitInRaid(currentunit);
	if (id) then
		menu = "RAID_PLAYER";
		name = GetRaidRosterInfo(id + 1);
	else
		menu = "PARTY";
	end

	UnitPopup_ShowMenu(ZMobDB_Frame_party4_DropDown, menu, currentunit, name, id);
end
function ZMobDB_PartyTarget1_DropDown_Initialize()
	local menu, name;
	local id = nil;
	currentunit = "party1target";

	if (UnitIsUnit(currentunit, "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit(currentunit, "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit(currentunit, "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer(currentunit)) then
		id = UnitInRaid(currentunit);
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty(currentunit)) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_party1target_DropDown, menu, currentunit, name, id);
	end
end
function ZMobDB_PartyTarget2_DropDown_Initialize()
	local menu, name;
	local id = nil;
	currentunit = "party2target";

	if (UnitIsUnit(currentunit, "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit(currentunit, "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit(currentunit, "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer(currentunit)) then
		id = UnitInRaid(currentunit);
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty(currentunit)) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_party2target_DropDown, menu, currentunit, name, id);
	end
end
function ZMobDB_PartyTarget3_DropDown_Initialize()
	local menu, name;
	local id = nil;
	currentunit = "party3target";

	if (UnitIsUnit(currentunit, "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit(currentunit, "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit(currentunit, "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer(currentunit)) then
		id = UnitInRaid(currentunit);
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty(currentunit)) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_party3target_DropDown, menu, currentunit, name, id);
	end
end
function ZMobDB_PartyTarget4_DropDown_Initialize()
	local menu, name;
	local id = nil;
	currentunit = "party4target";

	if (UnitIsUnit(currentunit, "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit(currentunit, "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit(currentunit, "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer(currentunit)) then
		id = UnitInRaid(currentunit);
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty(currentunit)) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_party4target_DropDown, menu, currentunit, name, id);
	end
end
function ZMobDB_PartyPet1_DropDown_Initialize()
	local menu, name;
	local id = nil;
	currentunit = "party1pet";

	if (UnitIsUnit(currentunit, "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit(currentunit, "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit(currentunit, "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer(currentunit)) then
		id = UnitInRaid(currentunit);
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty(currentunit)) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_party1pet_DropDown, menu, currentunit, name, id);
	end
end
function ZMobDB_PartyPet2_DropDown_Initialize()
	local menu, name;
	local id = nil;
	currentunit = "party2pet";

	if (UnitIsUnit(currentunit, "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit(currentunit, "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit(currentunit, "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer(currentunit)) then
		id = UnitInRaid(currentunit);
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty(currentunit)) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_party2pet_DropDown, menu, currentunit, name, id);
	end
end
function ZMobDB_PartyPet3_DropDown_Initialize()
	local menu, name;
	local id = nil;
	currentunit = "party3pet";

	if (UnitIsUnit(currentunit, "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit(currentunit, "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit(currentunit, "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer(currentunit)) then
		id = UnitInRaid(currentunit);
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty(currentunit)) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_party3pet_DropDown, menu, currentunit, name, id);
	end
end
function ZMobDB_PartyPet4_DropDown_Initialize()
	local menu, name;
	local id = nil;
	currentunit = "party4pet";

	if (UnitIsUnit(currentunit, "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit(currentunit, "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit(currentunit, "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer(currentunit)) then
		id = UnitInRaid(currentunit);
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty(currentunit)) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_party4pet_DropDown, menu, currentunit, name, id);
	end
end
function ZMobDB_FocusTarget_DropDown_Initialize()
	local menu, name;
	local id = nil;
	if (UnitIsUnit("focustarget", "player")) then
		menu = "SELF";
	elseif ( UnitIsUnit("focustarget", "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif (UnitIsUnit("focustarget", "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer("focustarget")) then
		id = UnitInRaid("focustarget");
		if (id) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id + 1);
		elseif (UnitInParty("focustarget")) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(ZMobDB_Frame_focustarget_DropDown, menu, "focustarget", name, id);
	end
end
-- ---------------------------------------------------------
-- Option Button Setting
-- ---------------------------------------------------------
function ZMobDB_DropDownStrata_player_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownStrataInitiation_player);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(ZMobDB_GetOption("player","Strata"),ZMobDB_StrataList));
	UIDropDownMenu_SetWidth(self,135);
end
function ZMobDB_DropDownStrata_target_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownStrataInitiation_target);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(ZMobDB_GetOption("target","Strata"),ZMobDB_StrataList));
	UIDropDownMenu_SetWidth(self,135);
end
function ZMobDB_DropDownStrata_party_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownStrataInitiation_party);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(ZMobDB_GetOption("party","Strata"),ZMobDB_StrataList));
	UIDropDownMenu_SetWidth(self,135);
end
function ZMobDB_DropDownStrata_pet_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownStrataInitiation_pet);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(ZMobDB_GetOption("pet","Strata"),ZMobDB_StrataList));
	UIDropDownMenu_SetWidth(self,135);
end
function ZMobDB_DropDownStrata_targettarget_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownStrataInitiation_targettarget);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(ZMobDB_GetOption("targettarget","Strata"),ZMobDB_StrataList));
	UIDropDownMenu_SetWidth(self,135);
end
function ZMobDB_DropDownStrata_pettarget_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownStrataInitiation_pettarget);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(ZMobDB_GetOption("pettarget","Strata"),ZMobDB_StrataList));
	UIDropDownMenu_SetWidth(self,135);
end
function ZMobDB_DropDownStrata_focus_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownStrataInitiation_focus);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(ZMobDB_GetOption("focus","Strata"),ZMobDB_StrataList));
	UIDropDownMenu_SetWidth(self,135);
end
function ZMobDB_DropDownStrata_partytarget_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownStrataInitiation_partytarget);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(ZMobDB_GetOption("partytarget","Strata"),ZMobDB_StrataList));
	UIDropDownMenu_SetWidth(self,135);
end
function ZMobDB_DropDownStrata_partypet_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownStrataInitiation_partypet);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(ZMobDB_GetOption("partypet","Strata"),ZMobDB_StrataList));
	UIDropDownMenu_SetWidth(self,135);
end
function ZMobDB_DropDownStrata_focustarget_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownStrataInitiation_focustarget);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(ZMobDB_GetOption("focustarget","Strata"),ZMobDB_StrataList));
	UIDropDownMenu_SetWidth(self,135);
end
function ZMobDB_DropDownGhost_Model_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownGhost_ModelInitiation);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(string.upper(ZMobDB_GetOption("Settings","Ghost_Model_name")),ZMobDB_GhostModelList));
	UIDropDownMenu_SetWidth(self,135);
end

function ZMobDB_DropDownSlowMode_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownSlowModeInitiation);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(string.upper(ZMobDB_GetOption("Settings","SlowMode")),ZMobDB_SlowModeList));
	UIDropDownMenu_SetWidth(self,100);
end
function ZMobDB_DropDownBorder_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownBorderInitiation);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(string.upper(ZMobDB_GetOption("Settings","Border")),ZMobDB_BorderList));
	UIDropDownMenu_SetWidth(self,100);
end
function ZMobDB_DropDownReflesh_control_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDownReflesh_controlInitiation);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(string.upper(ZMobDB_GetOption("Settings","Reflesh_control")),ZMobDB_RefreshControlList));
	UIDropDownMenu_SetWidth(self,100);
end
function ZMobDB_DropDown_SelectUnit_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDown_SelectUnitInitiation);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(string.upper(ZMobDB_GetOption("Settings","SelectUnit")),ZMobDB_SelectUnitList));
	UIDropDownMenu_SetWidth(self,100);
end
function ZMobDB_DropDown_SelectBox_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDown_SelectBoxInitiation);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(string.upper(ZMobDB_GetOption("Settings","SelectBox")),ZMobDB_SelectBoxList));
	UIDropDownMenu_SetWidth(self,120);
	local name = "ZMobDB_Frame_"..ZMobDB_GetOption("Settings","SelectBox");
	local frame = _G[name];
	local i = frame:GetID();
	local name_text = "ZMobDB_Camera"..i;
	local frame_text = _G[name_text];
	local x = frame_text:GetWidth();
	local y = frame_text:GetHeight();
	local name_x = "ZMobDB_Configuration_Controls_Panel_BoxSize_x_Text";
	local name_y = "ZMobDB_Configuration_Controls_Panel_BoxSize_y_Text";
	local frame_x = _G[name_x];
	local frame_y = _G[name_y];
	frame_x:SetText("X:"..x);
	frame_y:SetText("Y:"..y);
end

function ZMobDB_DropDown_RaidIconPosition_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDown_RaidIconPositionInitiation);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(ZMobDB_GetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RaidIcon_Position"),ZMobDB_RaidIconPositionList));
	UIDropDownMenu_SetWidth(self,100);
end

function ZMobDB_DropDown_SelectUnit_Animation_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDown_SelectUnitAnimationInitiation);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(string.upper(ZMobDB_GetOption("Settings","SelectUnit_Animation")),ZMobDB_SelectUnitList));
	UIDropDownMenu_SetWidth(self,100);
end
function ZMobDB_DropDown_SelectAnimation_OnShow(self)
	UIDropDownMenu_Initialize(self, ZMobDB_DropDown_SelectAnimationInitiation);
	UIDropDownMenu_SetSelectedID(self, ZMobDB_GetIDFromList(ZMobDB_GetOption("Settings","Select_Animation"),ZMobDB_SelectAnimationList));
	UIDropDownMenu_SetWidth(self,90);
end


function ZMobDB_DropDownStrataplayerOnClick(self)
	local i = self:GetID();
	local j = ZMobDB_GetIDFromList(ZMobDB_GetOption("player","Strata"),ZMobDB_StrataList);
	if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't change option while in combat");
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_player, j);
	else
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_player, i);
		ZMobDB_SetOption("player","Strata",ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_playerText:GetText());
		ZMobDB_Option_Change();
	end
end
function ZMobDB_DropDownStratatargetOnClick(self)
	local i = self:GetID();
	local j = ZMobDB_GetIDFromList(ZMobDB_GetOption("target","Strata"),ZMobDB_StrataList);
	if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't change option while in combat");
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_target, j);
	else
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_target, i);
		ZMobDB_SetOption("target","Strata",ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_targetText:GetText());
		ZMobDB_Option_Change();
	end
end
function ZMobDB_DropDownStratapartyOnClick(self)
	local i = self:GetID();
	local j = ZMobDB_GetIDFromList(ZMobDB_GetOption("party","Strata"),ZMobDB_StrataList);
	if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't change option while in combat");
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_party, j);
	else
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_party, i);
		ZMobDB_SetOption("party","Strata",ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_partyText:GetText());
		ZMobDB_Option_Change();
	end
end
function ZMobDB_DropDownStratapetOnClick(self)
	local i = self:GetID();
	local j = ZMobDB_GetIDFromList(ZMobDB_GetOption("pet","Strata"),ZMobDB_StrataList);
	if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't change option while in combat");
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_pet, j);
	else
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_pet, i);
		ZMobDB_SetOption("pet","Strata",ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_petText:GetText());
		ZMobDB_Option_Change();
	end
end
function ZMobDB_DropDownStratatargettargetOnClick(self)
	local i = self:GetID();
	local j = ZMobDB_GetIDFromList(ZMobDB_GetOption("targettarget","Strata"),ZMobDB_StrataList);
	if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't change option while in combat");
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_targettarget, j);
	else
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_targettarget, i);
		ZMobDB_SetOption("targettarget","Strata",ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_targettargetText:GetText());
		ZMobDB_Option_Change();
	end
end
function ZMobDB_DropDownStratapettargetOnClick(self)
	local i = self:GetID();
	local j = ZMobDB_GetIDFromList(ZMobDB_GetOption("pettarget","Strata"),ZMobDB_StrataList);
	if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't change option while in combat");
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_pettarget, j);
	else
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_pettarget, i);
		ZMobDB_SetOption("pettarget","Strata",ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_pettargetText:GetText());
		ZMobDB_Option_Change();
	end
end
function ZMobDB_DropDownStratafocusOnClick(self)
	local i = self:GetID();
	local j = ZMobDB_GetIDFromList(ZMobDB_GetOption("focus","Strata"),ZMobDB_StrataList);
	if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't change option while in combat");
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_focus, j);
	else
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_focus, i);
		ZMobDB_SetOption("focus","Strata",ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_focusText:GetText());
		ZMobDB_Option_Change();
	end
end

function ZMobDB_DropDownStratapartytargetOnClick(self)
	local i = self:GetID();
	local j = ZMobDB_GetIDFromList(ZMobDB_GetOption("partytarget","Strata"),ZMobDB_StrataList);
	if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't change option while in combat");
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_partytarget, j);
	else
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_partytarget, i);
		ZMobDB_SetOption("partytarget","Strata",ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_partytargetText:GetText());
		ZMobDB_Option_Change();
	end
end

function ZMobDB_DropDownStratapartypetOnClick(self)
	local i = self:GetID();
	local j = ZMobDB_GetIDFromList(ZMobDB_GetOption("partypet","Strata"),ZMobDB_StrataList);
	if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't change option while in combat");
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_partypet, j);
	else
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_partypet, i);
		ZMobDB_SetOption("partypet","Strata",ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_partypetText:GetText());
		ZMobDB_Option_Change();
	end
end
function ZMobDB_DropDownStratafocustargetOnClick(self)
	local i = self:GetID();
	local j = ZMobDB_GetIDFromList(ZMobDB_GetOption("focustarget","Strata"),ZMobDB_StrataList);
	if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't change option while in combat");
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_focustarget, j);
	else
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_focustarget, i);
		ZMobDB_SetOption("focustarget","Strata",ZMobDB_Configuration_UnitFrames_Panel_DropDownStrata_focustargetText:GetText());
		ZMobDB_Option_Change();
	end
end

function ZMobDB_DropDownGhost_ModelOnClick(self)
	local i = self:GetID();
	UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Animations_Panel_DropDownGhost_Model, i);
	ZMobDB_SetOption("Settings","Ghost_Model_name",string.lower(ZMobDB_Configuration_Animations_Panel_DropDownGhost_ModelText:GetText()));
end

function ZMobDB_DropDownSlowModeOnClick(self)
	local i = self:GetID();
	UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Options_Panel_DropDownSlowMode, i);
	ZMobDB_SetOption("Settings","SlowMode",string.lower(ZMobDB_Configuration_Options_Panel_DropDownSlowModeText:GetText()));
end

function ZMobDB_DropDownBorderOnClick(self)
	local i = self:GetID();
	UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Options_Panel_DropDownBorder, i);
	ZMobDB_SetOption("Settings","Border",string.lower(ZMobDB_Configuration_Options_Panel_DropDownBorderText:GetText()));
	ZMobDB_Option_Change();
end
function ZMobDB_DropDownReflesh_controlOnClick(self)
	local i = self:GetID();
	local j = nil;
	UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Options_Panel_DropDownReflesh_control, i);
	ZMobDB_SetOption("Settings","Reflesh_control",string.lower(ZMobDB_Configuration_Options_Panel_DropDownReflesh_controlText:GetText()));
	for j = 0,18 do
		local name = "ZMobDB_Camera"..j;
		local frame = _G[name];
		if ZMobDB_GetOption("Settings","Reflesh_control") == "mouseright" then
			ZMobDB_CursorControl_SetButton(frame:GetChildren(), "Reflesh_Dropdown", "RightButton", "NOKEY");
			ZMobDB_CursorControl_SetButton(frame:GetChildren(), nil, "RightButton", "ALT");
		elseif ZMobDB_GetOption("Settings","Reflesh_control") == "alt_mouseright" then
			ZMobDB_CursorControl_SetButton(frame:GetChildren(), "Reflesh", "RightButton", "ALT");
			ZMobDB_CursorControl_SetButton(frame:GetChildren(), "Dropdown", "RightButton", "NOKEY");
		end
	end
end
function ZMobDB_DropDownRaidIconPositionOnClick(self)
	local i = self:GetID();
	local j = ZMobDB_GetIDFromList(ZMobDB_GetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RaidIcon_Position"),ZMobDB_RaidIconPositionList);
	if InCombatLockdown() then
		DEFAULT_CHAT_FRAME:AddMessage("ZMobDB:can't change option while in combat");
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Options_Panel_DropDown_RaidIconPosition, j);
	else
		UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Options_Panel_DropDown_RaidIconPosition, i);
		ZMobDB_SetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RaidIcon_Position",ZMobDB_Configuration_Options_Panel_DropDown_RaidIconPositionText:GetText());
		ZMobDB_Option_Change();
	end
end
function ZMobDB_DropDownSelectUnitOnClick(self)
	local i = self:GetID();
	UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Animations_Panel_DropDown_SelectUnit, i);
	UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Options_Panel_DropDown_SelectUnit2, i);
	UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Animations2_Panel_DropDown_SelectUnit3, i);
	ZMobDB_SetOption("Settings","SelectUnit",string.lower(ZMobDB_Configuration_Animations_Panel_DropDown_SelectUnitText:GetText()));
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Dead"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Dead");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Ghost"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Ghost");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Rest"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Rest");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Pain"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Pain");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_AFK"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_AFK");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Stealth"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Stealth");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Ice"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Ice");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Shackle"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Shackle");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Fear"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Fear");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Cyclone"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Cyclone");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Seduce"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Seduce");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Banish"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Banish");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Sleep"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Sleep");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Shield"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Shield");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations_Panel_SelectAnimation_Bandage"],ZMobDB_GetOption("Settings","SelectUnit"),"Animation_Bandage");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations2_Panel_RandomAnimation_IsFriend"],ZMobDB_GetOption("Settings","SelectUnit"),"RandomAnimation_IsFriend");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Animations2_Panel_RandomAnimation_ChangeView"],ZMobDB_GetOption("Settings","SelectUnit"),"RandomAnimation_ChangeView");
	ZMobDB_SetSlider(_G["ZMobDB_Configuration_Animations2_Panel_RandomRate"],ZMobDB_GetOption("Settings","SelectUnit"),"RandomAnimation_Rate");
	ZMobDB_SetSlider(_G["ZMobDB_Configuration_Animations2_Panel_RandomRate_Combat"],ZMobDB_GetOption("Settings","SelectUnit"),"RandomAnimation_Rate_Combat");
	ZMobDB_SetSlider(_G["ZMobDB_Configuration_Animations2_Panel_RandomInterval"],ZMobDB_GetOption("Settings","SelectUnit"),"RandomAnimation_Interval");
	ZMobDB_SetSlider(_G["ZMobDB_Configuration_Animations2_Panel_RandomInterval_Combat"],ZMobDB_GetOption("Settings","SelectUnit"),"RandomAnimation_Interval_Combat");
	UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Options_Panel_DropDown_RaidIconPosition, ZMobDB_GetIDFromList(ZMobDB_GetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RaidIcon_Position"),ZMobDB_RaidIconPositionList));
	ZMobDB_Configuration_Options_Panel_DropDown_RaidIconPositionText:SetText(ZMobDB_GetOption(ZMobDB_GetOption("Settings","SelectUnit"),"RaidIcon_Position"));
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Options_Panel_Raid_Icon_Show"],ZMobDB_GetOption("Settings","SelectUnit"),"RaidIcon");
	ZMobDB_SetSlider(_G["ZMobDB_Configuration_Options_Panel_RaidIcon_Size"],ZMobDB_GetOption("Settings","SelectUnit"),"RaidIcon_Size");
	ZMobDB_SetCheckButton(_G["ZMobDB_Configuration_Options_Panel_PvP_Icon_Show"],ZMobDB_GetOption("Settings","SelectUnit"),"PvPIcon");
	ZMobDB_SetSlider(_G["ZMobDB_Configuration_Options_Panel_PvPIcon_Size"],ZMobDB_GetOption("Settings","SelectUnit"),"PvPIcon_Size");
end
function ZMobDB_DropDownSelectBoxOnClick(self)
	local i = self:GetID();
	UIDropDownMenu_SetSelectedID(ZMobDB_Configuration_Controls_Panel_DropDown_SelectBox, i);
	ZMobDB_SetOption("Settings","SelectBox",string.lower(ZMobDB_Configuration_Controls_Panel_DropDown_SelectBoxText:GetText()));
	local j = _G["ZMobDB_Frame_"..ZMobDB_GetOption("Settings","SelectBox")]:GetID();
	local x = _G["ZMobDB_Camera"..j]:GetWidth();
	local y = _G["ZMobDB_Camera"..j]:GetHeight();
	_G["ZMobDB_Configuration_Controls_Panel_BoxSize_x_Text"]:SetText("X:"..x);
	_G["ZMobDB_Configuration_Controls_Panel_BoxSize_y_Text"]:SetText("Y:"..y);

end
function ZMobDB_DropDownSelectUnitAnimationOnClick(self)
	local i = self:GetID();
	local Unit_word = ZMobDB_Unit_word[ZMobDB_GetOption("Settings","SelectUnit_Animation")];
	local animation = ZMobDB_GetOption("Settings","Select_Animation");
	local Ghost_Model = ZMobDB_GetOption("Settings","Ghost_Model_name");
	UIDropDownMenu_SetSelectedID(ZMobDB_AnimationTest_Dialog_DropDown_SelectUnit4, i);
	ZMobDB_SetOption("Settings","SelectUnit_Animation",string.lower(ZMobDB_AnimationTest_Dialog_DropDown_SelectUnit4Text:GetText()));
end

function ZMobDB_DropDownSelectAnimationOnClick(self)
	local i = self:GetID();
	UIDropDownMenu_SetSelectedID(ZMobDB_AnimationTest_Dialog_DropDown_SelectAnimation, i);
	ZMobDB_SetOption("Settings","Select_Animation",ZMobDB_AnimationTest_Dialog_DropDown_SelectAnimationText:GetText());
end


-- ---------------------------------------------------------
-- Init
-- ---------------------------------------------------------

function ZMobDB_OnLoad(self)

	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	self:RegisterEvent("UNIT_MODEL_CHANGED");
	self:RegisterEvent("PLAYER_DEAD");
	self:RegisterEvent("PLAYER_ALIVE");
	self:RegisterEvent("PLAYER_UNGHOST");
	self:RegisterEvent("GROUP_ROSTER_UPDATE");
	self:RegisterEvent("UNIT_PET");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	-- self:RegisterEvent("PLAYER_FOCUS_CHANGED");
	self:RegisterEvent("PLAYER_FLAGS_CHANGED");
	self:RegisterEvent("UNIT_AURA");
	self:RegisterEvent("UNIT_HEALTH");
	self:RegisterEvent("RAID_TARGET_UPDATE");
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("UNIT_TARGET");

	ZMobDB_Register_SlashCommands();

	self:SetScript("OnEvent", 
		function(self, event, ...)
			ZMobDB_Avatar_Main_OnEvent[event](self, ...);
		end
	);
end
