sleep 60;

private ["_messages", "_timeout"];

_messages = [
	["GSI", "GSI A3Wasteland"],
	["Welcome", (name player)],
	["A3Wasteland", worldName],
	["Teamspeak", "ts.gamersinc.net"],
	["Website/Forums", "GamersInc.net"],
	["Saving", "Server resets EVERY 4 hours"],
	["MAIN RULES", "We are a Family Server. Hacking, Profanity and Racism WILL NOT be tolerated!!."],
	["Earplugs", "Put in your earplugs by using the END key."],
	["Mods", "Fullscreen Night Vision Enabled"],
	["Thank You!", "Thanks for joining GamersInc Wasteland Server. Enjoy your day!!"]
];

_timeout = 5;
{
	private ["_title", "_content", "_titleText"];
	uiSleep 2;
	_title = _x select 0;
	_content = _x select 1;
	_titleText = format[("<t font='TahomaB' size='0.40' color='#a81e13' align='left' shadow='1' shadowColor='#000000'>%1</t><br /><t shadow='1'shadowColor='#000000' font='TahomaB' size='0.60' color='#FFFFFF' align='left'>%2</t>"), _title, _content];
	[_titleText,[safezoneX + safezoneW - 0.8,0.50],[safezoneY + safezoneH - 0.8,0.7],_timeout,0.5] spawn BIS_fnc_dynamicText;
	uiSleep (_timeout * 1.1);
} forEach _messages;
