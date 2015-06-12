removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;


//tools
player addHeadgear "ARC_Common_TAN_M_Helmet";
player addWeapon "Binocular";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemGPS";
player linkItem "tf_anprc152";

//weapons (unload)
player addWeapon "SMA_HK416afg";
player addPrimaryWeaponItem "SMA_eotech552_3XDOWN";
player addWeapon "hgun_P07_F";

//uniform
player forceAddUniform "ARC_GER_Tropentarn_Uniform";
player addItemToUniform "ACE_Banana";
player addItemToUniform "ACE_EarPlugs";

//vest
player addVest "ARC_GER_Tropentarn_Plate_Carrier";
player addItemToVest "16Rnd_9x21_Mag";
for "_i" from 1 to 3 do {player addItemToVest "SMA_30Rnd_556x45_M855A1_Tracer";};
for "_i" from 1 to 1 do {player addItemToVest "HandGrenade";};
for "_i" from 1 to 6 do {player addItemToVest "SmokeShell";};

//backpack
player addBackpack "ARC_GER_Backpack_Carryall_Tropentarn";
for "_i" from 1 to 3 do {player addItemToBackpack "SMA_30Rnd_556x45_M855A1_Tracer";};

//medic stuff
//https://github.com/acemod/ACE3/blob/c47e0ce7964d91f97c2aaac8a4a2b3e4d97c83e7/documentation/missionmaker/classnames.md
//bandages
for "_i" from 1 to 20 do {player addItemToBackpack "ACE_fieldDressing";};
for "_i" from 1 to 25 do {player addItemToBackpack "ACE_elasticBandage";};
for "_i" from 1 to 20 do {player addItemToBackpack "ACE_quikclot";};
for "_i" from 1 to 15 do {player addItemToBackpack "ACE_packingBandage";};
for "_i" from 1 to 4 do {player addItemToBackpack "ACE_tourniquet";};
//medical facility / vehicle stuff
for "_i" from 1 to 3 do {player addItemToBackpack "ACE_personalAidKit";};
for "_i" from 1 to 3 do {player addItemToBackpack "ACE_surgicalKit";};
//infusion
for "_i" from 1 to 4 do {player addItemToBackpack "ACE_salineIV_500";};
//injectors
for "_i" from 1 to 10 do {player addItemToBackpack "ACE_epinephrine";};
for "_i" from 1 to 10 do {player addItemToBackpack "ACE_morphine";};
for "_i" from 1 to 15 do {player addItemToBackpack "ACE_atropine";};


