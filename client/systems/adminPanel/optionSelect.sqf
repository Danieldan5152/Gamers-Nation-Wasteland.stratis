// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: optionSelect.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 20/11/2012 05:19

#define debugMenu_option 50003
#define adminMenu_option 50001
disableSerialization;

private ["_panelType","_displayAdmin","_displayDebug","_adminSelect","_debugSelect","_money"];
_uid = getPlayerUID player;
if (_uid call isAdmin) then
{
	_panelType = _this select 0;

	_displayAdmin = uiNamespace getVariable ["AdminMenu", displayNull];
	_displayDebug = uiNamespace getVariable ["DebugMenu", displayNull];

	switch (true) do
	{
		case (!isNull _displayAdmin): //Admin panel
		{
			_adminSelect = _displayAdmin displayCtrl adminMenu_option;

			switch (lbCurSel _adminSelect) do
			{
				case 0: // Player Management
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\playerMenu.sqf";
					hint "Player Management Menu LOADED!";
				};
				case 1: // Unstuck Player
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\unstuck.sqf";
					if (!isNil "notifyAdminMenu") then { ["UnstuckPlayer", "Used"] call notifyAdminMenu };
				};
				case 2: // Show server FPS
				{
					hint format["Server FPS: %1",serverFPS];
				};
				case 3: // ATM Interface
				{
					closeDialog 0;
					call mf_items_atm_access;
					hint "ATM Interface LOADED!";
				};
				case 4: // Add $10,000 to ATM account
				{
					_money = 10000;
					player setVariable ["bmoney", (player getVariable ["bmoney",0]) + _money, true];
					hint "You have just added $10,000 to your ATM account!";
				};
				case 5: // Add $50,000 to ATM account
				{
					_money = 50000;
					player setVariable ["bmoney", (player getVariable ["bmoney",0]) + _money, true];
					hint "You have just added $50,000 to your ATM account!";
				};
				case 6: // Add $100,000 to ATM account
				{
					_money = 100000;
					player setVariable ["bmoney", (player getVariable ["bmoney",0]) + _money, true];
					hint "You have just added $100,000 to your ATM account!";
				};
				case 7: // Add $500,000 to ATM account
				{
					_money = 500000;
					player setVariable ["bmoney", (player getVariable ["bmoney",0]) + _money, true];
					hint "You have just added $500,000 to your ATM account!";
				};
				case 8: // Add $1,000,000 to ATM account
				{
					_money = 1000000;
					player setVariable ["bmoney", (player getVariable ["bmoney",0]) + _money, true];
					hint "You have just added $1,000,000 to your ATM account!";
				};
				case 9: // Vehicle Management
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\vehicleManagement.sqf";
					hint "Vehicle Management interface LOADED!";
				};
				case 10: // Object Search 5000m
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\loadObjectSearch.sqf";
					hint "Object Search interface LOADED!! This will let you search for all objects within 5000 meters of your position!";
				};
				case 11: // Debug Menu
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\loadDebugMenu.sqf";
					hint "Debug menu LOADED!!";
				};
				case 12: // Teleport
				{
					closeDialog 0;
					["A3W_teleport", "onMapSingleClick",
					{
						vehicle player setPos _pos;
						["A3W_teleport", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
						true
					}] call BIS_fnc_addStackedEventHandler;
					hint "Open your map and click on a position to TELEPORT!";
				};
				case 13: // Teleport - player to me
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\tptome.sqf";
					hint "Select player from drop-down list on left to TELEPORT to YOUR position!";
				};
				case 14: // Teleport - me to player
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\tpmeto.sqf";
					hint "Select player from drop-down list on left to TELEPORT to THEIR position!";
				};
				case 15: // Toggle God-mode
				{
					execVM "client\systems\adminPanel\toggleGodMode.sqf";
				};
                case 16: // Player Markers
				{
					execVM "client\systems\adminPanel\playerTags.sqf";
				};
				case 17: // toggle God mode
				{
					execVM "client\systems\adminPanel\toggleInvisMode.sqf";
					//Is logged from inside target script
				};
			};
		};
		case (!isNull _displayDebug): // Debug panel
		{
			_debugSelect = _displayDebug displayCtrl debugMenu_option;

			switch (lbCurSel _debugSelect) do
			{
				case 0: // Access Gun Store
				{
					closeDialog 0;
					[] call loadGunStore;
					hint "Gun Store interface LOADED!";
				};
				case 1: // Access General Store
				{
					closeDialog 0;
					[] call loadGeneralStore;
					hint "General Store interface LOADED!";
				};
				case 2: // Access Vehicle Store
				{
					closeDialog 0;
					[] call loadVehicleStore;
					hint "Vehicle Store interface LOADED!";
				};
				case 3: // Access Respawn Dialog
				{
					closeDialog 0;
					true spawn client_respawnDialog;
					hint "Respawn Dialog interface LOADED!";
				};
				case 4: // Access Proving Grounds
				{
					closeDialog 0;
					createDialog "balca_debug_main";
					hint "Proving Grounds interface LOADED!"
				};
				case 5: // Unlock Base Objects (25m)
				{
					_confirmMsg = format ["This will UNLOCK ALL OBJECTS within 25 meters of your position...<br/>"];
					_confirmMsg = _confirmMsg + format ["<br/>UNLOCK ALL OBJECTS within 25 meters of your position? "];

					if ([parseText _confirmMsg, "Confirm", "CONFIRM", true] call BIS_fnc_guiMessage) then
					{
					{_x setVariable ["objectLocked",false,true];} forEach (position player nearObjects ["All",25]);
					hint format["You have UNLOCKED ALL OBJECTS within 25 meters of your position!"];
					};
				};
				case 6: // Delete Unlocked Base Objects (25m)
				{
					_confirmMsg = format ["This will DELETE ALL UNLOCKED OBJECTS within 25 meters of your position...<br/>"];
					_confirmMsg = _confirmMsg + format ["<br/>DELETE ALL UNLOCKED OBJECTS within 25 meters of your position?"];

					if ([parseText _confirmMsg, "Confirm", "CONFIRM", true] call BIS_fnc_guiMessage) then
					{
					
					{if !(_x getVariable ["objectLocked",false]) then {deleteVehicle _x};} forEach (position player nearObjects ["All",50]);
					hint format["You have DELETED ALL UNLOCKED OBJECTS within 25 meters of your position!"];
					};
				};
			};
		};
	};
};
