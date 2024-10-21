main()
{
    mapvote::init();
    oneshot::load();
    chat_commands::init();
    sprint::precache();
    credits::init();
    scorehud::precache();
}

startgt()
{
    level.gametype = getCvar("g_gametype");
    if((level.gametype != "dm" && level.gametype != "tdm" && level.gametype != "bel"))
    {
    thread aliveplayers::hud_alivePlayers_create();
    }

    if(level.gametype == "dm")
    {
    thread scorehud::dmscore();
    }

    if(level.gametype == "tdm")
    {
    thread scorehud::makeHudScores();
    }

    removeplaceditems::removeitems();
    credits::showCredit();
    hudtext::logo();
}

playerConnect()
{
    
}

playerKilled()
{

}

headicon()
{
    headicon::precache();
}
spawnplayer()
{
	antiff::antiFF();
    pingchecker::main();
    sprint::start(10, 10, 10);
    sprint::start(10, 10, 10);
}

endmap()
{
    sprint::_hud_destroy();
    mapvote::start();
}

playerDisconnect()
{
    sprint::_hud_destroy();
}