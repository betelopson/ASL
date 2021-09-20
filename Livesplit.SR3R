// SR:TTR Autosplitter/loadremover by Mr. Mary and hoxi(hoxiak)(hoxi___)(hoxiu_) and mossfiss
// original script and solutions by Mr. Mary and hoxi(hoxiak)(hoxi___)(hoxiu_)
// updated to work with Saints Row 3:Remastered (GOG 1.0.6.1_(64bit)_(47287)) by mossfiss
// - autostart
// - splitting on mission/activity end
// - splitting on cutscenes
// - final split (slightly delayed at times)

state("SRTTR")		
{
	string32 currentDialogue : 0x2569510;
	string32 debugString : 0x1B39914;           // cutscenes and credit splits
	string32 missionBank : 0x15B3F05;
	string13 voiceLine : 0x2569510;
	int totalMissions : 0x161FA60;
	int totalActivities : 0x161FAD0;
	int runStart : 0x11D1174;
	int missionPass : 0x11B7550;
	int isLoad : 0x10D4754;
	// collectibles
    int sexdolls : 0x161FDE0;
    int photoops : 0x161FE50;
    int moneypallet : 0x161FD70;
   	int drugpackage : 0x161FD00;
	// activities
	int escort : 0x1620080;
	int genki : 0x16202B0;
	int tank : 0x1620240;
	int heli : 0x1620160;
	int fraud : 0x16201D0;
	int trafficking : 0x16200F0;
	int mayhem : 0x1620470;
	int trail : 0x1620390;
	int snatch : 0x1620400;
	// cutscene stuff
	bool isCutscene : 0x10D488C;
	int cutsceneCheck : 0x1604CF4;
	// non-essential collectibles
	int assassinations: 0x161FFA0;
}

startup
{
	vars.aslName = "SRTTR";
    if(timer.CurrentTimingMethod == TimingMethod.RealTime)
        {
            var timingMessage = MessageBox.Show(
                "This game uses Game Time (time without loads) as the main timing method.\n"+
                "LiveSplit is currently set to show Real Time (time INCLUDING loads).\n"+
                "Would you like the timing method to be set to Game Time for you?",
                vars.aslName+" | LiveSplit",
                MessageBoxButtons.YesNo,MessageBoxIcon.Question
            );
            if (timingMessage == DialogResult.Yes) timer.CurrentTimingMethod = TimingMethod.GameTime;
	}
	settings.Add("missions", true, "Missions");
	vars.missionTags = new Dictionary<string,string> {
		{"m01_media.bnk_pc","When Good Heists Go Bad"},
		{"m02_media.bnk_pc","I'm Free, Free Falling"},
		{"m03_media.bnk_pc","We're Going To Need Guns"},
		{"m04_media.bnk_pc","Steelport Here I Am"},
		{"m05_media.bnk_pc","Party Time"},
		{"pierceGA","Guardian Angel (Pierce)"},
		{"ttc","Takeover The City"},
		{"sh01_media.bnk_pc","Hit The Powder Room"},
		{"m06_media.bnk_pc","The Belgian Problem"},
		{"m07_media.bnk_pc","Return to Steelport"},
		{"m08_media.bnk_pc","Trojan Whores"},
		{"sh02_media.bnk_pc","Pimps Up, Hos Down"},
		{"kinzieGA","Guardian Angel (Kinzie)"},
		{"m09_media.bnk_pc","The Ho Boat"},
		{"m10_media.bnk_pc","Gang Bang"},
		{"m11_media.bnk_pc","Convoy Decoy"},
		{"m12_media.bnk_pc","Nyte Blayde's Return"},
		{"m13_media.bnk_pc","STAG Party"},
		{"m14_media.bnk_pc","Live! with Killbane"},
		{"m15_media.bnk_pc","Learning Computer"},
		{"sh03_media.bnk_pc","Stop All The Downloading"},
		{"m16_media.bnk_pc","http://deckers.die"},
		{"m17_media.bnk_pc","My Name Is Cyrus Temple"},
		{"m18_media.bnk_pc","Air Steelport"},
		{"m19_media.bnk_pc","Zombie Attack"},
		{"m20_media.bnk_pc","A Remote Chance"},
		{"sh04_media.bnk_pc","3 Count Beatdown"},
		{"m21_media.bnk_pc","Murderbrawl XXXI"},
		{"m22_media.bnk_pc","Three Way (Kill Killbane)"},
		{"saveShaundi","Three Way (Save Shaundi)"},
		{"m23_media.bnk_pc","STAG Film"},
		{"m24_media.bnk_pc","Gangstas in Space"},
	};
	vars.objList = new List<string>();
	foreach (var Tag in vars.missionTags) {
		settings.Add(Tag.Key, true, Tag.Value, "missions");
		vars.objList.Add(Tag.Key);
	}
	settings.Add("dlc", false, "DLC Missions");
	vars.dlcTags = new Dictionary<string,string> {
		{"dlc2_m01_media.bnk_pc", "Faster, More Intense!"},
		{"dlc2_m02_media.bnk_pc", "Hangar 18 1/2"},
		{"dlc2_m03_media.bnk_pc", "That's Not in the Script!"},
		{"DLC3_M01_media.bnk_pc", "Weird Science"},
		{"DLC3_M02_media.bnk_pc", "Tour de Farce"},
		{"DLC3_M03_media.bnk_pc", "Send in the Clones"},
	};
	foreach (var Tag in vars.dlcTags) {
		settings.Add(Tag.Key, true, Tag.Value, "dlc");
		vars.objList.Add(Tag.Key);
	}	
	settings.Add("cutscenes", true, "Cutscenes");
	vars.cutsceneIds = new Dictionary<int,string> {
		{1111001216,"We've Only Just Begun"},
		{1111438131,"Painting a Picture"},
		{1106439936,"Face Your Fear"},
		{1110826471,"Phone Phreak"},
	};
	vars.cutList = new List<int>();
	foreach (var Tag in vars.cutsceneIds) {
		settings.Add (Tag.Key.ToString(), true, Tag.Value, "cutscenes");
		vars.cutList.Add(Tag.Key);
	}
			
	settings.Add("activities", true, "Activities");
	settings.Add("blazing", true, "Cyber/Trail Blazing", "activities");
	settings.Add("escort", true, "Escort", "activities");
	settings.Add("heli", true, "Heli Assault", "activities");
	settings.Add("fraud", true, "Insurance Fraud", "activities");
	settings.Add("mayhem", true, "Mayhem", "activities");
	settings.Add("genki", true, "Professor Genki", "activities");
	settings.Add("snatch", true, "Snatch", "activities");
	settings.Add("tank", true, "Tank Mayhem", "activities");
	settings.Add("trafficking", true, "Trafficking", "activities");
	
	settings.Add("finalSplit", true, "Any% Final Split (credits roll)", "missions");
	settings.Add("collectibles", false, "Collectibles");
	settings.Add("drugpackage", true, "Drug Packages", "collectibles");
	settings.Add("moneypallet", true, "Money Pallets", "collectibles");
	settings.Add("photoops", true, "Photo Ops", "collectibles");
	settings.Add("sexdolls", true, "Sex Dolls", "collectibles");
	
	settings.Add("miscstuff", false, "Miscellanous");
	settings.Add("assassinations", true, "Assassinations", "miscstuff");
}

init
{
	vars.splits = new List<string>();
	vars.cuts = new List<int>();
	vars.ttc = false;
	vars.pirs = false;
	vars.kinz = false;
	vars.passStates = new List<int>();
	vars.passStates.Add(1024730783); //1080p
	vars.passStates.Add(1016388967);
	vars.passStates.Add(1023009950);
	vars.passStates.Add(1018330810);
	vars.passStates.Add(1024461083); //1050p
	vars.passStates.Add(1016117967);
	vars.passStates.Add(1022555034);
	vars.passStates.Add(1018005870);
	vars.passStates.Add(1024227343); //1024p
	vars.passStates.Add(1015883100);
	vars.passStates.Add(1022160773);
	vars.passStates.Add(1017724255);
	vars.passStates.Add(1022814985); //900p
	vars.passStates.Add(1014504363);
	vars.passStates.Add(1020280451);
	vars.passStates.Add(1016381168);
	vars.passStates.Add(1021016983); //800p
	vars.passStates.Add(1012697695);
	vars.passStates.Add(1018764063);
	vars.passStates.Add(1015298034);
	vars.passStates.Add(1020441622); //768p
	vars.passStates.Add(1012119562);
	vars.passStates.Add(1018278820);
	vars.passStates.Add(1014881295);
	vars.passStates.Add(1019578581); //720p
	vars.passStates.Add(1011252362);
	vars.passStates.Add(1013841486);
	vars.passStates.Add(1022230094);
	
	vars.completeStates = new List<int>();
	vars.completeStates.Add(1016388967);
	vars.completeStates.Add(1016117967);
	vars.completeStates.Add(1015883100);
	vars.completeStates.Add(1014504363);
	vars.completeStates.Add(1012697695);
	vars.completeStates.Add(1012119562);
	vars.completeStates.Add(1011252362);
	vars.cutLines = new List<string>();
	vars.cutLines.Add("mm_a_04_c2_ph");
	vars.cutLines.Add("mm_p_06_c2_ph");
	vars.cutLines.Add("mm_k_05_c2_ph");
	vars.cutLines.Add("mm_z_04_c2_ph");
}

update
{
	if (current.voiceLine == "mm_p_03_start")
	{
		vars.ttc = true;
	}
	
	if (current.voiceLine == "_a_ga_nw_01_a")
	{
		vars.kinz = true;
	}
	
	if (current.voiceLine == "_a_ga_dt_03_a")
	{
		vars.pirs = true;
	}
}

start
{
	return ((current.currentDialogue == "m01_convo_2_wm.ctd" || current.currentDialogue == "m01_convo_2_wf.ctd") && current.runStart == old.runStart - 1);
}

split
{
	if (vars.completeStates.Contains(current.missionPass) && current.missionPass != old.missionPass)
	{
		if (vars.objList.Contains(current.missionBank) && settings[current.missionBank] && !vars.splits.Contains(current.missionBank))
		{
			vars.splits.Add(current.missionBank);
			return true;
		}
	}
	
	if (settings["blazing"])
    {
        if (current.trail == old.trail+1)
        {
            return true;
        }
    }
	
	if (settings["escort"])
	{
		if (current.escort == old.escort+1)
		{
			return true;
		}
	}

	if (settings["genki"])
    {
        if (current.genki == old.genki+1)
        {
            return true;
        }
    }
	
	if (settings["tank"])
	{
		if (current.tank == old.tank+1)
		{
			return true;
		}
	}	
	
	if (settings["snatch"])
	{
		if (current.snatch == old.snatch+1)
		{
			return true;
		}
	}
	
	if (settings["trafficking"])
	{
		if (current.trafficking == old.trafficking+1)
		{
			return true;
		}
	}
	
	if (settings["fraud"])
	{
		if (current.fraud == old.fraud+1)
		{
			return true;
		}
	}
	
	if (settings["heli"])
	{
		if (current.heli == old.heli+1)
		{
			return true;
		}
	}
	
	if (settings["mayhem"])
	{
		if (current.mayhem == old.mayhem+1)
		{
			return true;
		}
	}

	if (settings["kinzieGA"] && vars.kinz && vars.completeStates.Contains(current.missionPass) && current.missionPass != old.missionPass)
	{
			vars.kinz = false;
			return true;
	}	

	if (settings["pierceGA"] && vars.pirs && vars.completeStates.Contains(current.missionPass) && current.missionPass != old.missionPass)
	{
			vars.pirs = false;
			return true;
	}	

	if (vars.ttc)
	{
		if (settings["ttc"] && vars.completeStates.Contains(current.missionPass) && current.missionPass != old.missionPass)
		{
			vars.ttc = false;
			return true;
		}
	}
	
	if (current.missionBank == "m24_media.bnk_pc" && old.missionBank == "m22_media.bnk_pc")
	{ 
		if (settings["saveShaundi"])
		{
			return true;
		}
	}
	
	if (current.debugString == "credits_reel_peg_loaded" && current.debugString != old.debugString)
	{
		if (settings["finalSplit"])
		{
			return true;
		}
	}
	
	if (settings["sexdolls"])
    {
        if (current.sexdolls == old.sexdolls+1)
        {
            return true;
        }
    }

    if (settings["photoops"])
    {
        if (current.photoops == old.photoops+1)
        {
            return true;
        }
    }

    if (settings["moneypallet"])
    {
        if (current.moneypallet == old.moneypallet+1)
        {
            return true;
        }
    }

    if (settings["drugpackage"])
    {
        if (current.drugpackage == old.drugpackage+1)
        {
            return true;
        }
    }
    
    if (settings["assassinations"])
    {
        if (current.assassinations == old.assassinations+1)
        {
            return true;
        }
    }
	
	if (current.cutsceneCheck == 0 && old.cutsceneCheck != current.cutsceneCheck && vars.cutLines.Contains(current.voiceLine))
	{
		if (vars.cutList.Contains(old.cutsceneCheck) && settings[old.cutsceneCheck.ToString()] && !vars.cuts.Contains(old.cutsceneCheck))
		{
			vars.cuts.Add(old.cutsceneCheck);
			return true;
		}
	}
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading
{
	return (current.isLoad == 3 && !vars.passStates.Contains(current.missionPass));
}
