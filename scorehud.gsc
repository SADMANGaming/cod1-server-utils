precache()
{
    precacheShader("gfx/hud/headicon@axis");
    precacheShader("gfx/hud/headicon@allies");
    level.myscoretext = makeLocalizedString("YOUR SCORE:");
}

makeHudScores()
{
    baseX = 628;
    baseY = 75;
    stepY = 14;
    
    // Create axis team score HUD
    hudScoreAxis = newHudElem();
    hudScoreAxis.x = baseX;
    hudScoreAxis.y = baseY + stepY * 2;
    hudScoreAxis.alignX = "center";
    hudScoreAxis.alignY = "middle";
    hudScoreAxis.fontScale = 1;
    hudScoreAxis.color = (1, 1, 0);  // Yellow color
    hudScoreAxis.sort = 10;

    // Axis team icon
    hudIconAxis = newHudElem();
    hudIconAxis.x = baseX - 18;  // Slightly offset for the icon
    hudIconAxis.y = baseY + stepY * 2;
    hudIconAxis.alignX = "center";
    hudIconAxis.alignY = "middle";
    hudIconAxis setShader("gfx/hud/headicon@axis", 12, 12);  // Axis icon
    hudIconAxis.sort = 5;

    // Create allies team score HUD
    hudScoreAllies = newHudElem();
    hudScoreAllies.x = baseX;
    hudScoreAllies.y = baseY + stepY * 3;
    hudScoreAllies.alignX = "center";
    hudScoreAllies.alignY = "middle";
    hudScoreAllies.fontScale = 1;
    hudScoreAllies.color = (1, 1, 0);  // Yellow color
    hudScoreAllies.sort = 10;

    // Allies team icon
    hudIconAllies = newHudElem();
    hudIconAllies.x = baseX - 18;
    hudIconAllies.y = baseY + stepY * 3;
    hudIconAllies.alignX = "center";
    hudIconAllies.alignY = "middle";
    hudIconAllies setShader("gfx/hud/headicon@allies", 12, 12);  // Allies icon
    hudIconAllies.sort = 5;

    thread updateHudScores(hudScoreAxis, hudScoreAllies);
}

updateHudScores(hudScoreAxis, hudScoreAllies)
{
    while(1)
    {
        scoreAxis = getTeamScore("axis");
        hudScoreAxis setValue(scoreAxis);

        scoreAllies = getTeamScore("allies");
        hudScoreAllies setValue(scoreAllies);

        wait 0.5;
    }
}


dmscore()
{
    for(;;)
    {
        baseX = 628;
        baseY = 75;
        stepY = 14;
        
        hudScore = newHudElem();
        hudScore.x = baseX;
        hudScore.y = baseY + i * stepY;
        hudScore.alignX = "center";
        hudScore.alignY = "middle";
        hudScore.fontScale = 1;
        hudScore.color = (1, 1, 0);
        hudScore.sort = 10;

        hudScore setText (level.myscoretext);
        hudScore setValue( self.score );

        wait .1;
    }     
}