state("Playtime_Prototype4-Win64-Shipping", "version_1")

{
	int isLoad : 0x3E54898;
	int runStart : 0x3E52270;
	int introCheck : 0x40FCB58;
}

state("UE4Game-Win64-Shipping", "version_2")

{
	int isLoad : 0x4033228;
	int runStart : 0x44DBDD0;
	int introCheck : 0x42ECF14;
}

startup
{
	vars.aslName = "Poppy Playtime";
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
}

start
{
	return ((current.introCheck != 0) && current.runStart == -1);
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading

{
	return current.isLoad == 0;
}
