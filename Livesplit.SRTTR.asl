// SR:TTR Autosplitter/loadremover by Mr. Mary and hoxi(hoxiak)(hoxi___)(hoxiu_) and mossfis
// original script and solutions by Mr. Mary and hoxi(hoxiak)(hoxi___)(hoxiu_)
// updated to work with Saints Row: The Third Remastered (GOG/EGS/Steam) by mossfis
// what works:
// - autostart
// - splitting on mission/activity end
// - splitting on cutscenes
// - final split (slightly delayed at times)

state("SRTTR", "v1.0.0.1 (GoG)")		
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

state("SRTTR", "v1.0.0.1 (EGS)")		
{
	string32 currentDialogue : 0x257A380;
	string32 debugString : 0x1B395C4;           // cutscenes and credit splits
	string32 missionBank : 0x15B3655;
	string13 voiceLine : 0x257A380;
	int totalMissions : 0x161F1E0;
	int totalActivities : 0x161F250;
	int runStart : 0x11D1164;
	int missionPass : 0x11B7540;
	int isLoad : 0x10D4744;
	// collectibles
	int sexdolls : 0x161F560;
	int photoops : 0x161F5D0;
	int moneypallet : 0x161F4F0;
	int drugpackage : 0x161F480;
	// activities
	int escort : 0x161F800;
	int genki : 0x161FA30;
	int tank : 0x161F9C0;
	int heli : 0x161F8E0;
	int fraud : 0x161F950;
	int trafficking : 0x161F870;
	int mayhem : 0x161FBF0;
	int trail : 0x161FB10;
	int snatch : 0x161FB80;
	// cutscene stuff
	bool isCutscene : 0x10D487C;
	int cutsceneCheck : 0x1604444;
	// non-essential collectibles
	int assassinations: 0x161F720;
}

state("SRTTR", "v1.0.0.1 (Steam)")		
{
	string32 currentDialogue : 0x250FED0;
	string32 debugString : 0x1AE1094;           // cutscenes and credit splits
	string32 missionBank : 0x155B655;
	string13 voiceLine : 0x250FED0;
	int totalMissions : 0x15C7200;
	int totalActivities : 0x15C7270;
	int runStart : 0x11781D4;
	int missionPass : 0x115E550;
	int isLoad : 0x107B754;
	// collectibles
	int sexdolls : 0x15C7580;
	int photoops : 0x15C75F0;
	int moneypallet : 0x15C7510;
	int drugpackage : 0x15C74A0;
	// activities
	int escort : 0x15C7820;
	int genki : 0x15C7A50;
	int tank : 0x15C79E0;
	int heli : 0x15C7900;
	int fraud : 0x15C7970;
	int trafficking : 0x15C7890;
	int mayhem : 0x15C7C10;
	int trail : 0x15C7B30;
	int snatch : 0x15C7BA0;
	// cutscene stuff
	bool isCutscene : 0x107B88C;
	int cutsceneCheck : 0x15AC454;
	// non-essential collectibles
	int assassinations: 0x15C7740;
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
	
	/*
	 * This defines a function (delegate) for easier output of
	 * debug information. Something like this makes sense when you
	 * have code that is required several times around the script.
	 *
	 * The function is assigned to a local variable, but also assigned to the dynamic
	 * object "vars" so it can be accessed from other Actions.
	 * 
	 * You can assign all kinds of values to "vars" to exchange them between Actions.
	 */
	Action<string> DebugOutput = (text) => {
		print("[SRTTR Autosplitter] "+text);
	};
	vars.DebugOutput = DebugOutput;

	// Based on: https://github.com/NoTeefy/LiveSnips/blob/master/src/snippets/checksum(hashing)/checksum.asl
	Func<ProcessModuleWow64Safe, string> CalcModuleHash = (module) => {
		vars.DebugOutput("Calcuating hash of "+module.FileName);
		byte[] exeHashBytes = new byte[0];
		using (var sha = System.Security.Cryptography.MD5.Create())
		{
			using (var s = File.Open(module.FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
			{
				exeHashBytes = sha.ComputeHash(s);
			}
		}
		var hash = exeHashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
		vars.DebugOutput("Hash: "+hash);
		return hash;
	};
	vars.CalcModuleHash = CalcModuleHash;
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
	vars.passStates.Add(1017550954);
	vars.passStates.Add(1013841486);
	vars.passStates.Add(1015263374); //480p
	vars.passStates.Add(1006916358);
	vars.passStates.Add(1012801676);
	vars.passStates.Add(1008642441);
	
	vars.completeStates = new List<int>();
	vars.completeStates.Add(1016388967); //1080p
	vars.completeStates.Add(1016117967); //1050p
	vars.completeStates.Add(1015883100); //1024p
	vars.completeStates.Add(1014504363); //900p
	vars.completeStates.Add(1012697695); //800p
	vars.completeStates.Add(1012119562); //768p
	vars.completeStates.Add(1011252362); //720p
	vars.completeStates.Add(1006916358); //480p

	vars.cutLines = new List<string>();
	vars.cutLines.Add("mm_a_04_c2_ph");
	vars.cutLines.Add("mm_p_06_c2_ph");
	vars.cutLines.Add("mm_k_05_c2_ph");
	vars.cutLines.Add("mm_z_04_c2_ph");

	/*
	 * Detecting the game version can be useful if your script should either
	 * support different versions of the game or if you want to disable the
	 * script for unknown versions.
	 *
	 * For this, the special variable "modules" is accessed to get the
	 * ModuleMemorySize of the process, which is then checked against the
	 * known size for this version.
	 *
	 * Checking the size works fine as long as all different versions have
	 * a different size. In this case check hash is checked for newer version
	 * and only afterwards does it check the size for older versions in case
	 * the version wasn't detected yet (don't have the hash yet for the older
	 * ones).
	 *
	 * The special "version" variable is set, which can only be done in
	 * the "init" Action. If you had defined a State Descriptor with this
	 * version it would now switch to that State Descriptor. This also has
	 * the effect of displaying the version in the ASL Settings GUI and you
	 * can access the "version" variable from other Actions.
	 *
	 * Note that for simply accessing the version from other Actions, you
	 * could also save the detected version in "vars", for example like this:
	 *
	 * vars.gameVersion = "Steam v1.06";
	 *
	 * However this would *not* have the other effects that setting it to
	 * the special "version" variable has (switching State Descriptor and
	 * showing the version in the GUI).
	 */
	var module = modules.Single(x => String.Equals(x.ModuleName, "SRTTR.exe", StringComparison.OrdinalIgnoreCase));
	var moduleSize = module.ModuleMemorySize;
	vars.DebugOutput("Module Size: "+moduleSize+" "+module.ModuleName);
	var hash = vars.CalcModuleHash(module);
	if (hash == "9A173260A061E37D0AF97CC3727954B7")
	{
		// Module Size: 58175488
		version = "v1.0.0.1 (GoG)";
	}
	else if (hash == "17BB2948A52523C6147B5940DB41A33D")
	{
		// Module Size: 58245120
		version = "v1.0.0.1 (EGS)";
	}
	else if (hash == "1DE6296B4834C5C992CFBF62795D663A")
	{
		// Module Size: 57794560
		version = "v1.0.0.1 (Steam)";
	}
	// Fallback for different versions
	else if (moduleSize == 58175488)
	{
		version = "v1.0.0.1 (GoG)";
	}
	else if (moduleSize == 58245120)
	{
		version = "v1.0.0.1 (EGS)";
	}
	else if (moduleSize == 57794560)
	{
		version = "v1.0.0.1 (Steam)";
	}
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
