// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: playerSetupGear.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

private ["_player", "_uniform", "_vest", "_backpack", "_headgear", "_goggles", "_donatorLevel"];
_player = _this;

_donatorEnabled = ["A3W_donatorEnabled"] call isConfigOn;
_donatorLevel = player getVariable ["donator", 0];
//empty

// Clothing is now defined in "client\functions\getDefaultClothing.sqf"

_uniform = [_player, "uniform"] call getDefaultClothing;
_vest = [_player, "vest"] call getDefaultClothing;
_headgear = [_player, "headgear"] call getDefaultClothing;
_goggles = [_player, "goggles"] call getDefaultClothing;

//if (_uniform != "") then { _player addUniform _uniform };
if (_uniform != "") then { _player forceAddUniform _uniform };
if (_vest != "") then { _player addVest _vest };
if (_headgear != "") then { _player addHeadgear _headgear };
if (_goggles != "") then { _player addGoggles _goggles };

sleep 0.1;

// Remove GPS
_player unlinkItem "ItemGPS";

// Remove radio
//_player unlinkItem "ItemRadio";

// Add NVG
_player linkItem "NVGoggles";

_player addBackpack "B_Kitbag_mcamo";

_player addMagazine "30Rnd_65x39_caseless_mag";
_player addWeapon "arifle_MXC_F";
_player addMagazine "30Rnd_65x39_caseless_mag";
_player addMagazine "30Rnd_65x39_caseless_mag";
_player addItem "FirstAidKit";
_player selectWeapon "arifle_MXC_F";

switch (true) do
{
	case (["_medic_", typeOf _player] call fn_findString != -1):
	{
		_player removeItem "FirstAidKit";
		_player addItem "Medikit";
	};
	case (["_engineer_", typeOf _player] call fn_findString != -1):
	{
		//_player addItem "MineDetector";
		_player addItem "Toolkit";
	};
	case (["_sniper_", typeOf _player] call fn_findString != -1):
	{
		_player addWeapon "Rangefinder";
	};
};

if (_player == player) then
{
	thirstLevel = 100;
	hungerLevel = 100;
};

switch (_donatorLevel) do
{
	default // Default Server Kit
	{
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addWeapon "hgun_ACPC2_F";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addItem "FirstAidKit";
		_player selectWeapon "hgun_ACPC2_F";
	};
	case 1: // Default Server Donator Kit
	{
		["Open",true] spawn BIS_fnc_arsenal;
	};
	case 2: // Expired Donator Kit
	{
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addWeapon "hgun_ACPC2_F";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addItem "FirstAidKit";
		_player selectWeapon "hgun_ACPC2_F";
		["Your Virtual Arsenal has expired.  Please e-mail septicide@open-sys.fr for more info."] spawn BIS_fnc_guiMessage;
	};
	case 3: // Admin kit
	{
		["Open",true] spawn BIS_fnc_arsenal;
	};
	case 4: // Server Owner Kit
	{
		["Open",true] spawn BIS_fnc_arsenal;
	};
};