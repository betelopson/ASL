state("Playtime_Prototype4-Win64-Shipping")

{
	int isLoad : 0x3E54898;
	int runStart : 0x3E52270;
	int introCheck : 0x40FCB58;
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
