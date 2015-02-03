/**
* fnc_settingsMenuUpdateList.sqf
* @Descr: N/A
* @Author: Glowbal
*
* @Arguments: []
* @Return:
* @PublicAPI: false
*/
#include "script_component.hpp"

private ["_settingsMenu", "_ctrlList", "_settingsText", "_color", "_settingsColor", "_updateKeyView"];
DEFAULT_PARAM(0,_updateKeyView,true);

disableSerialization;
_settingsMenu = uiNamespace getVariable 'ACE_settingsMenu';
_ctrlList = _settingsMenu displayCtrl 200;

lbclear _ctrlList;

switch (GVAR(optionMenu_openTab)) do {
case (MENU_TAB_OPTIONS): {
    {
      _ctrlList lbadd (_x select 3);

      _settingsValue = _x select 7;

      // Created disable/enable options for bools
      _settingsText = if ((_x select 1) == "BOOL") then {
        [(localize "STR_ACE_OptionsMenu_Disabled"), (localize "STR_ACE_OptionsMenu_Enabled")] select _settingsValue;
      } else {
        (_x select 5) select _settingsValue;
      };

      _ctrlList lbadd (_settingsText);
    }foreach GVAR(clientSideOptions);
  };
case (MENU_TAB_COLORS): {
    {
      _color = +(_x select 7);
      {
        _color set [_forEachIndex, ((round (_x * 100))/100)];
      } forEach _color;
      _settingsColor = str _color;
      _ctrlList lbadd (_x select 3);
      _ctrlList lbadd (_settingsColor);
      _ctrlList lnbSetColor [[_forEachIndex, 1], (_x select 7)];
    }foreach GVAR(clientSideColors);
  };
};
if (_updateKeyView) then {
  [] call FUNC(settingsMenuUpdateKeyView);
};
