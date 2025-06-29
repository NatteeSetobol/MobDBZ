--
-- Avatar API
--
function ZMobDB_Avatar_OnLoad(self)
	self.isAvatar = true;
	self.renderTick = 0;
	-- self:RegisterEvent("UNIT_MODEL_CHANGED");
	ZMobDB_SpecialEvent("AVATAR_CREATED", self);
end
function ZMobDB_GetAvatar(unittype)
	local unit = nil;
	local target= nil;
	local pet = nil;
	local focus = nil;
	local avatar_unit = nil;
	local avatar_target = nil;
	local avatar_pet = nil;
	local avatar_focus = nil;
	if ((ZMobDB_Unit_word[unittype])) then
		avatar_unit = _G["ZMobDB_Camera"..ZMobDB_Avatar_table[unittype].unit]:GetChildren();
		if ZMobDB_Avatar_table[unittype].target ~= nil then
			avatar_target = _G["ZMobDB_Camera"..ZMobDB_Avatar_table[unittype].target]:GetChildren();
		end
		if ZMobDB_Avatar_table[unittype].pet ~= nil then
			avatar_pet = _G["ZMobDB_Camera"..ZMobDB_Avatar_table[unittype].pet]:GetChildren();
		end
		if ZMobDB_Avatar_table[unittype].focus ~= nil then
			avatar_focus = _G["ZMobDB_Camera"..ZMobDB_Avatar_table[unittype].focus]:GetChildren();
		end
	end
	return avatar_unit,avatar_target,avatar_pet,avatar_focus;
end

function ZMobDB_Avatar_Refresh(avatar)
	avatar:SetModelScale(1);
	avatar:SetPosition(0, 0, 0);
	avatar:ClearModel();
	avatar:SetUnit(ZMobDB_Avatar_GetUnitType(avatar));
	ZMobDB_Settings_RefreshCamera(avatar);
	if not(UnitExists(ZMobDB_Avatar_GetUnitType(avatar))) then
		-- avatar:GetParent():Hide();
	end
	ZMobDB_SpecialEvent("AVATAR_REFRESHED", avatar);
end
function ZMobDB_Avatar_GetUnitType(avatar)
	return ZMobDB_ID_table[avatar:GetParent():GetID()];
end
function ZMobDB_Avatar_SetRendered(avatar, state)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	if (state) then
		ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.isRendered = true;
	else
		ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.isRendered = false;
	end
end
function ZMobDB_Avatar_IsRendered(avatar)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	return ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.isRendered;
end
function ZMobDB_Avatar_AttemptToRender(avatar, tick)
	-- The rendering tick, in practice, only effects joining a party where
	-- the members are too far away to be rendered. self will continue to
	-- refresh the party member until it ticks while within dueling range.

	local unittype = ZMobDB_Avatar_GetUnitType(avatar);
	local stats,pre_stats,ghost_model = ZMobDB_GetStats(unittype);
	-- avatar.mark = "off";
	if (avatar.renderTick < 4) then
		avatar.renderTick = avatar.renderTick + 1;
	else
		avatar.renderTick = 0;
		tick = true;
	end
	if (tick) then
		avatar.renderTick = 0;
		if (not ZMobDB_Avatar_IsRendered(avatar)) then
			if 
				stats ~= "Ghost" and 
				stats ~= "Ice" and 
				stats ~= "Shackle" and 
				stats ~= "Fear" and 
				stats ~= "Cyclone" and 
				stats ~= "Seduce" and 
				stats ~= "Banish" and 
				stats ~= "Sleep" and 
				stats ~= "Shield" and 
				stats ~= "Bandage" 
			then
				ZMobDB_Avatar_Refresh(avatar);
				-- ZMobDB_Avatar_ModelUpdate(avatar);
				avatar.mark = "off";
			end
			if (ZMobDB_UnitIsRenderable(unittype)) then
				ZMobDB_Avatar_SetRendered(avatar, true);
				avatar.mark = "off";
			else
				-- Model *might* have rendered, until the target is within
				-- dueling range, we can't be sure. Continue to attempt
				-- rendering until we're sure.
				if avatar.mark ~= "on" and unittype ~="pet" and stats ~="Ghost" and ZMobDB_GetOption("Settings","Symbol") == "on" and UnitExists(unittype)then
					-- avatar:SetCamera(2);
					avatar:SetPortraitZoom(0);
					avatar:SetModel("Interface\\Buttons\\talktomequestion_grey.mdx");
					avatar:SetModelScale(4.25);
					avatar:SetPosition(0,0,-1.5);
					avatar.mark = "on";
				end
			end
		end
	end
end
function ZMobDB_Avatar_SetScale(avatar, scale)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	local camera = ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera;
	if (scale ~= nil and scale ~= camera.scale) then
		avatar:SetModelScale(scale);
		camera.scale = scale;
		ZMobDB_SpecialEvent("AVATAR_SCALE_CHANGED", avatar);
	end
end
function ZMobDB_Avatar_GetScale(avatar)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	return ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.scale;
end
function ZMobDB_Avatar_SetZoom(avatar, zoom)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	local camera = ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera;
	if (zoom ~= nil and zoom ~= camera.zoom) then
		avatar:SetPosition(zoom, camera.position.panH, camera.position.panV);
		camera.zoom = zoom;
		ZMobDB_SpecialEvent("AVATAR_ZOOM_CHANGED", avatar);
	end
end
function ZMobDB_Avatar_GetZoom(avatar)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	return ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.zoom;
end
function ZMobDB_Avatar_SetPosition(avatar, panH, panV)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	local camera = ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera;
	if (panH == nil) then
		panH = camera.position.panH;
	end
	if (panV == nil) then
		panV = camera.position.panV;
	end
	if (panH ~= camera.position.panH or panV ~= camera.position.panV) then
		avatar:SetPosition(camera.zoom, panH, panV);
		camera.position.panH = panH;
		camera.position.panV = panV;
		ZMobDB_SpecialEvent("AVATAR_POSITION_CHANGED", avatar);
	end
end
function ZMobDB_Avatar_GetPosition(avatar)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	return ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.position.panH,
		ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.position.panV;
end
function ZMobDB_Avatar_SetRotation(avatar, rotation)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	local camera = ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera;
	if (rotation ~= nil and rotation > 3.099999999999) then
		rotation = -3.1;
	elseif (rotation ~= nil and rotation < -3.1) then
		rotation = 3.099999999999;
	end
	if (rotation ~= nil and rotation ~= camera.rotation) then
		avatar:SetRotation(rotation);
		camera.rotation = rotation;
		ZMobDB_SpecialEvent("AVATAR_ROTATION_CHANGED", avatar);
	end
end
function ZMobDB_Avatar_GetRotation(avatar)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	return ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.rotation;
end
function ZMobDB_SetAutoPort(bBox,MouseButton)
	local db_name = bBox.DataName;
	local unittype = ZMobDB_Avatar_GetUnitType(bBox:GetChildren());
	local stats,pre_stats,ghost_model = ZMobDB_GetStats(unittype);
	if db_name ~= nil and db_name ~="default" and UnitExists(unittype) and stats == "Normal" and not(((strfind(db_name,"_Random")))) then
		if MouseButton == "LeftButton" then
			if (db_name) then
				DEFAULT_CHAT_FRAME:AddMessage("Auto Portrait ON:"..db_name);
				if not(ZMobDB_table[db_name]) then
					ZMobDB_table[db_name] ={
						scale = 1,
						zoom = 0,
						position = {0,0},
						rotation = 0,
						autoport = "on",
					}
				else
					ZMobDB_table[db_name].autoport = "on";
				end
				bBox:GetChildren().port = "on";
				-- bBox:GetChildren():SetCamera(0);
				bBox:GetChildren():SetPortraitZoom(1);
				bBox:GetChildren():SetPosition(0,0,0);
				bBox:GetChildren():ClearModel();
				bBox:GetChildren():SetUnit(unittype);
			else
				DEFAULT_CHAT_FRAME:AddMessage("need set model view before set Auto Portrait");
			end
		elseif MouseButton == "RightButton" then
			DEFAULT_CHAT_FRAME:AddMessage("Auto Portrait OFF:"..db_name);
			ZMobDB_table[db_name].autoport = "off";
			bBox:GetChildren().port = "off";
			if ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Port")=="off" then
				-- bBox:GetChildren():SetCamera(0);
				-- bBox:GetChildren():SetPortraitZoom(1);
				-- bBox:GetChildren():SetPosition(0,0,0);
				-- bBox:GetChildren():ClearModel();
				-- bBox:GetChildren():SetUnit(unittype);
			end
		end
	end
end
function ZMobDB_ResetModel(bBox,Key)
	local db_name = bBox.DataName;
	local unittype = ZMobDB_Avatar_GetUnitType(bBox:GetChildren());
	local stats,pre_stats,ghost_model = ZMobDB_GetStats(unittype);
		if Key == "LeftButton" then
			if 
				db_name ~=nil and 
				ZMobDB_GetOption(ZMobDB_Unit_word[unittype],"Port")=="off" 
			then
				if (ZMobDB_table[db_name]) then
					if ZMobDB_table[db_name].autoport == "off" then
						DEFAULT_CHAT_FRAME:AddMessage("Reset Model View:"..db_name);
						ZMobDB_table[db_name] =nil;
						ZMobDB_BoundingBox_Reflesh_sub(bBox);
					end
				end
			end
		end
end

function ZMobDB_Avatar_SetLightState(avatar, isEnabled, omni)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	light = ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light;
	if (isEnabled == nil) then
		isEnabled = light.isEnabled;
	elseif (isEnabled) then
		isEnabled = 1;
	else
		isEnabled = 0;
	end
	if (omni == nil) then
		omni = light.omni;
	elseif (omni) then
		omni = 1;
	else
		omni = 0;
	end
	if (isEnabled ~= light.isEnabled or omni ~= light.omni) then
		light.isEnabled = isEnabled;
		light.omni  = omni;
		ZMobDB_Avatar_RefreshLight();
		ZMobDB_SpecialEvent("AVATAR_LIGHT_STATE_CHANGED", avatar);
	end
end

function ZMobDB_Avatar_GetLightState(avatar)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	return ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.isEnabled,
		ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.omni;
end

function ZMobDB_Avatar_SetLightZoom(avatar, zoom)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	light = ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light;
	if (zoom ~= nil and zoom ~= light.zoom) then
		light.zoom = zoom;
		ZMobDB_Avatar_RefreshLight();
		ZMobDB_SpecialEvent("AVATAR_LIGHT_ZOOM_CHANGED", avatar);
	end
end

function ZMobDB_Avatar_GetLightZoom(avatar)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	return ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.zoom;
end

function ZMobDB_Avatar_SetLightPosition(avatar, panH, panV)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	light = ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light;
	if (panH == nil) then
		panH = light.position.panH;
	end
	if (panV == nil) then
		panV = light.position.panV;
	end
	if (panH ~= light.position.panH or panV ~= light.position.panV) then
		light.position.panH = panH;
		light.position.panV = panV;
		ZMobDB_Avatar_RefreshLight();
		ZMobDB_SpecialEvent("AVATAR_LIGHT_POSITION_CHANGED", avatar);
	end
end

function ZMobDB_Avatar_GetLightPosition(avatar)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	return ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.position.panH,
		ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.position.panV;
end

function ZMobDB_Avatar_SetLightAmbient(avatar, red, green, blue, alpha)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	ambientLight = ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.ambient;
	if (alpha == nil) then
		alpha = ambientLight.alpha;
	end
	if (red == nil) then
		red = ambientLight.red;
	end
	if (green == nil) then
		green = ambientLight.green;
	end
	if (blue == nil) then
		blue = ambientLight.blue;
	end
	if (  alpha ~= ambientLight.alpha or red ~= ambientLight.red or
	      green ~= ambientLight.green or blue ~= ambientLight.blue  ) then
		ambientLight.alpha  = alpha;
		ambientLight.red    = red;
		ambientLight.green  = green;
		ambientLight.blue   = blue;
		ZMobDB_Avatar_RefreshLight();
		ZMobDB_SpecialEvent("AVATAR_LIGHT_AMBIENT_CHANGED", avatar);
	end
end

function ZMobDB_Avatar_GetLightAmbient(avatar)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	return ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.ambient.red,
		ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.ambient.green,
		ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.ambient.blue,
		ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.ambient.alpha;
end

function ZMobDB_Avatar_SetLightDirect(avatar, red, green, blue, alpha)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	directLight = ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.direct;
	if (alpha == nil) then
		alpha = directLight.alpha;
	end
	if (red == nil) then
		red = directLight.red;
	end
	if (green == nil) then
		green = directLight.green;
	end
	if (blue == nil) then
		blue = directLight.blue;
	end
	if (  alpha ~= directLight.alpha or red ~= directLight.red or
	      green ~= directLight.green or blue ~= directLight.blue  ) then
		directLight.alpha  = alpha;
		directLight.red    = red;
		directLight.green  = green;
		directLight.blue   = blue;
		ZMobDB_Avatar_RefreshLight();
		ZMobDB_SpecialEvent("AVATAR_LIGHT_DIRECT_CHANGED", avatar);
	end
end

function ZMobDB_Avatar_GetLightDirect(avatar)
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	return ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.direct.red,
		ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.direct.green,
		ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.direct.blue,
		ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light.direct.alpha;
end

function ZMobDB_Avatar_RefreshLight()
	local ZMobDBPlayerIndex=UnitName("player").."."..GetRealmName();
	--light = ZMobDB_Profile[ZMobDBPlayerIndex][avatar:GetParent():GetID()].avatar.camera.light;
	-- Haven't tested light sourcing yet.
	--avatar:SetLight(  light.isEnabled, light.omni,
	--                  light.zoom,
	--                  light.position.panH, light.position.panV,
	--                  light.ambient.alpha, light.ambient.red, light.ambient.green, light.ambient.blue,
	--                  light.direct.alpha, light.direct.red, light.direct.green, light.direct.blue  );
end
-- Avatar Rotate & Zoom
-- Allows 3D model to be turned left or right and zoomed in or out.
-- Requires: ZMobDB_Avatar_Rotate() and ZMobDB_Avatar_Zoom()
--

function ZMobDB_Avatar_RotateAndZoom(self)
	if (ZMobDB_CursorControl_IsActive(self, "RotateAndZoom")) then
		-- Complementary visual controls, trigger both.
		ZMobDB_Avatar_Rotate(self);
		ZMobDB_Avatar_Zoom(self);
	end
end
function ZMobDB_Avatar_Rotate(self)
	if 
		ZMobDB_CursorControl_IsActive(self,"RotateAndZoom") or 
		ZMobDB_CursorControl_IsActive(self,"RotateAndShrink") or 
		ZMobDB_CursorControl_IsActive(self,"Rotate") 
	then
		local changeX, changeY = ZMobDB_GetCursorMovement();
		if (changeX ~= 0) then
			local mod = ZMobDB_Avatar_GetControlIntensity(self, 0.066);
			local rotation = ZMobDB_Avatar_GetRotation(self:GetChildren());
			rotation = ZMobDB_Avatar_GetControlConstraint(rotation + (mod * changeX), -3.1, 3.099999999999, true);
			ZMobDB_Avatar_SetRotation(self:GetChildren(), rotation);
		end
	end
end

--
-- Avatar Rotate & Shrink
-- Allows 3D model to shrink or grow and be turned left or right
-- Requires: ZMobDB_Avatar_Rotate() and ZMobDB_Avatar_Shrink()
--

function ZMobDB_Avatar_RotateAndShrink(self)
	if (ZMobDB_CursorControl_IsActive(self, "RotateAndShrink")) then
		-- Complementary visual controls, trigger both.
		ZMobDB_Avatar_Rotate(self);
		ZMobDB_Avatar_Shrink(self);
	end
end

--
-- Avatar Rotate
-- Allows 3D model to be turned left or right.
-- Dependancy: ZMobDB_Avatar_RotateAndZoom*() functions use self.
--


--
-- Avatar Zoom
-- Allows 3D model to zoom in and out.
-- Dependancy: ZMobDB_Avatar_RotateAndZoom*() functions use self.
--
function ZMobDB_Avatar_Zoom(self)
	if 
		ZMobDB_CursorControl_IsActive(self,"RotateAndZoom") or 
		ZMobDB_CursorControl_IsActive(self,"Zoom") 
	then
		local changeX, changeY = ZMobDB_GetCursorMovement();
		if (changeY ~= 0) then
			local mod = ZMobDB_Avatar_GetControlIntensity(self, 0.070);
			local zoom = ZMobDB_Avatar_GetZoom(self:GetChildren());
			zoom = ZMobDB_Avatar_GetControlConstraint(zoom + (mod * changeY), -20, 5, false);
			ZMobDB_Avatar_SetZoom(self:GetChildren(), zoom);
		end
	end
end


--
-- Avatar Shrink
-- Allows 3D model to shrink and grow in size.
--
function ZMobDB_Avatar_Shrink(self)
	if 
		ZMobDB_CursorControl_IsActive(self,"RotateAndShrink") or 
		ZMobDB_CursorControl_IsActive(self,"Shrink") 
	then
		local changeX, changeY = ZMobDB_GetCursorMovement();
		if (changeY ~= 0) then
			local mod = ZMobDB_Avatar_GetControlIntensity(self, 0.070);
			local scale = ZMobDB_Avatar_GetScale(self:GetChildren());
			scale = ZMobDB_Avatar_GetControlConstraint(scale + (mod * changeY), 0.05, 20, false);
			ZMobDB_Avatar_SetZoom(self:GetChildren(), scale);
		end
	end
end
function ZMobDB_Avatar_Scale(self)
	if ZMobDB_CursorControl_IsActive(self,"Change_Scale") then
		local changeX, changeY = ZMobDB_GetCursorMovement();
		if (changeY ~= 0) then
			local mod = ZMobDB_Avatar_GetControlIntensity(self, 0.070);
			local scale = ZMobDB_Avatar_GetScale(self:GetChildren());
			scale = ZMobDB_Avatar_GetControlConstraint(scale + (mod * changeY), 0.05,20, false);
			ZMobDB_Avatar_SetScale(self:GetChildren(), scale);
		end
	end
end


--
-- Avatar Pan
-- Allows 3D model to be positioned on a 2D plane within the bounding box.
--
function ZMobDB_Avatar_Pan(self)
	if ZMobDB_CursorControl_IsActive(self,"Pan") then
		local changeX, changeY = ZMobDB_GetCursorMovement();
		if (changeX ~= 0 or changeY ~= 0) then
			local mod = ZMobDB_Avatar_GetControlIntensity(self, 0.133);
			local h, v = ZMobDB_Avatar_GetPosition(self:GetChildren());
			h = ZMobDB_Avatar_GetControlConstraint(h + (mod * changeX), -50, 50, true);
			v = ZMobDB_Avatar_GetControlConstraint(v + (mod * changeY), -50, 50, true);
			ZMobDB_Avatar_SetPosition(self:GetChildren(), h, v);
		end
	end
end
