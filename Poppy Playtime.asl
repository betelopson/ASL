state("Playtime_Prototype4-Win64-Shipping")

{
	int isLoad : 0x3E54898;
}

exit
{
    timer.IsGameTimePaused = true;
}

isLoading

{
	return current.isLoad == 0;
}
