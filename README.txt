"Mob Database for Zuxana's Model Citizen(ZMobDB) Advanced" Release Note

------------------------------------------------------------
	UPDATE
------------------------------------------------------------
Removed the code that disables Zoom, Rotation, etc. for portrait mode. In order to
accomplish this you must go type /zmob config in chat (a window will pop up) and goto
and uncheck "Hold Window" and in Specific DataBase, uncheck Player. Then close the 
Windows and now you should be able to rotation, Zoom, etc.


------------------------------------------------------------
	about this addon
------------------------------------------------------------
3D Animation portrait for your UI
This mod use "Zuxana's Model Citizen" system.
but ZMC author now not online.so I edit that and add new features

Zuxana's Model Citizen
Author:   Xageroth (xageroth@gmail.com)
Feedback: http://wowinterface.com/forums/showthread.php?t=3456&page=1&pp=10
Version:  0.9.3
Release:  2006-01-18
About:    A 3D model add-on which creates several adjustable cameras
          of differing unit types.


------------------------------------------------------------
	Install
------------------------------------------------------------
Just put the Addon in your Addon folder. no needs another addon/library.

*NOTE
 Needs to Disable "ZuxanaModelCitizen" if you installed it.


------------------------------------------------------------
	Mouse Controls
------------------------------------------------------------
CTRL Key + Left Mouse Button = Rotate and Zoom in on the model.
CTRL Key + Right Mouse Button = Pan the model horizontally or vertically.
ALT Key + Left Mouse Button = increace/decreace model scale.

SHIFT Key + Left Mouse Button = Drag the bounding box around.
SHIFT Key + Right Mouse Button = Resize the bounding box.

CTRL + SHIFT + Left Mouse Button = Auto Portrait ON
CTRL + SHIFT + Right Mouse Button = Auto Portrait OFF
CTRL + SHIFT + ALT + Left Mouse Button = Refresh Model View

Right Mouse Button or ALT Key + Right Mouse Button = Reflesh All Models.


------------------------------------------------------------
	Model Data
------------------------------------------------------------
Model Data will save to some categories and model fileName.

ex.
Player_UndeadMale: UndeadMale player
Self_Horde_UndeadMale: Player window's model
Party_Horde_Sheep: when Horde Player get Poly (PvP Mode ON),Party window specific
Player_Sheep: Alliance/Horde use Same Setting when get Poly(PvP Mode OFF)
NPC_GnomeMale: "all" GnomeMale "NPC" use same Setting(Simple Data Mode OFF)
Model_GnomeMale: "all" GnomeMale "Player/NPC" use same Setting(Simple Data Mode ON)


---- Special settings "Shape Shift" ----
Addon will serch you/pet/party/target/ToT's ModelFile.When it get shape-shift(Poly,DRU Form etc).another setting will save/load.

for example,if you target Poly unit and change model setting,Massage "Update Model Setting:Player_Sheep" and auto-load "Poly_unit" to target/player/pet/party model when it get Poly.

---- Supported Shape Shift List ----
"ALL" ShapeShift supported. will add when you find them.

*NOTE Some kind of shape-shift spells turns you to random type (ex. Nef's Greater Poly turns you to caw,cat,rat and so on).but addon CAN sence it to different type.

---- Auto Portrait Mode ----
you can set "Auto Portrait" to each model data.
Ctrl+Shift+Left Mouse Auto Portrait:ON
Ctrl+Shift+Right Mouse Auto Portrait:OFF
1) target mob
2) Ctrl+Shift+Left Mouse
3) Massage "Auto Portrait:ON"
that "model" turns to portrait view.

---- Event Animations ----
All models play emote when
Dead
take Drink/Food
HP Down
AFK
Ghost(TombStone,Skeleton,PvP Flag)
Stealth

---- Eye Catch Animations ----
All models turns to special effect

Frozen Trap
IceBlock
Shackle
Banish
Seduction
Fear etc.

user can set zoom/rotation to animation models.
ex:
Horde_UndeadMale_Rest
Party_UndeadMale_Random
Spell_Fear

---- Animation Test Window ----
/ZMC testbox

useage:
1) target mob ( players only)
2) set data format unit/animation
3) push Start button

 you can change model setting at Test box


---------------------------------------------------------------
	Option Window Desc
---------------------------------------------------------------
---- UnitFrames ----
*check ON what you want to show

	Portrait   : Use Portrait View(NOTE: while you set portrait mode,you can't change model settings.)

	Enable     : ON  Enable Mouse
	             OFF not Enable Mouse,Target background object
	FrameStrata: Set Frame Strata

---- Options ----

	Hold Windows          : All model windows will hold position,size.and can target when you crick it.
	Use Unit Menu         : pop-up drop down menu when right crick.only works while "Hold Windows" ON.
	Hide Party in Raid    : Hide Party Model while you in a Raid group
	PvP Mode              : ON  Use Alliance/Horde own data (Horde_Sheep etc)
                                OFF Use Alliance/Horde common data (Player_Sheep etc)
				(Works only while Simple Data Mode OFF)
	Simple Data Mode      : ON  Use common Model data (NPC_HumanMale etc)
                                OFF Use detail data (Model_HumanMale etc)
	Notice New Data       : Notice When Find New Model
	Add Control Tooltip   : Show Model/box Setting Key Tooltip
	Only Config Visible   : Show Tooltip only while Config window visible
	MouseOver Hide        : Change FrameStrata when MouseOver
	SlowMode              : While you in a Raid group,models will flicker and reset frequently.but "slow mode" decrease it.
                                ALL   all models turns to slow mode
                                Raid  all midels turns to slow mode while you in a raid group
                                Party only party models turns to slow mode
                                OFF   slow mode off(default)
	Box Style             : Select Window Style
                                Default tranceparent
                                Black   no border,black background
                                Edge    tooltip border,tranceparent background
                                Tooltip tooltip style
	Refresh Button        : Select "Refresh All Models" Key Bind
	Show Raid Target Icon : Use Raid Target Icon
		Position      : Select Icon Position
		RaidIcon_Size : Raid Icon Size (% of window width)
	Show PvP Icon         : Use PvP Icon (only while no-Raid Icon taken)
		PvPIcon_Size  : PvP Icon Size (pix)
	Specific DataBase     : OFF that unitframe use normal database.(same as target model) ex:Horde_UndeadMale_AFK
                                ON  that unitframe use specific database.(not same as target model) ex:Party_Horde_UndeadMale_AFK If No-setting found,addon load normal model setting.
	Fixed Rotation        : that unitframe will not change model facing. (use last model's facing) 

---- Animations1 ----
	Out of Sight Mark   : Use Mark while unit out of sight
	PainRate            : Play Pain Animation below this HP rate
	AlphaRate           : Stealth/Invisible Model use this alpha rate
	Ghost Model         : Select Model Style While Unit turns to Ghost
	EventAnimation      : Setting for Event Animations
	Eye Catch Animation : Setting for Eye Catch Animations

---- Aniamtions2 ----
	Setting for Rundom Animations

---- Controls ----
	Manual Setting for Box Position/Size
	and Adjust PvP Icon Position

---- Profiles ----
	Copy/Paste your Character's Setting
	Backup Current Setting/Database

--------------------------------------------------------------------
	Commands
--------------------------------------------------------------------
Add few slash commands.

/ZMOB delete DataName :delete data from database ("/ZMOB delete Undead_male" etc)
/ZMOB copy DataName1,DataName2 : copy DataName1 setting to DataName2 ("/ZMOB copy Undead_male,Troll_female" etc)
/ZMOB config : pop up Config Window
/ZMOB copymenu : pop up Copy Menu
/ZMOB reflesh :Reflesh All Models (or mouse right-crick)
/ZMOB testbox : pop up Animation Test Window
/ZMOB resetbox : reset window position/size when next login

--------------------------------------------------------------------
	UI Compilation Author Support
--------------------------------------------------------------------
ZMobDB profile has your(author's) character/server name.
so I prepare command when building UI Compilation

---- for author ----
1)make setting/window position etc.
2)open config menu Profiles tab
3)Push "Backup Current Setting/Database" button
(your character Name/Server will not copy)
4)logout
5)Delete profile data
World of Warcraft\WTF\Account\Account_Name\SavedVariables\ZobDB.lua
(this file has your(author's) character/server name)

* backuped file name
World of Warcraft\WTF\Account\Account_Name\Server_Name\Charactor_Name\SavedVariables\ZMobDB.lua
* backup data
  Model DataBase
  Window Position/Size
  Option Settings


---- for user ----
1)install UI compilation
2)login
3)ZMobDB Setting/Database will auto-restore from backuped file when 1st login if no setting found
