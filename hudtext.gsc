logo()
{

    hudtextstring1a = getCvar("scr_hud_text1");
    hudtextstring2a = getCvar("scr_hud_text2");
    hudtextstring3a = getCvar("scr_hud_text3");

	hudtext1 = makeLocalizedString(hudtextstring1a);
	hudtext2 = makeLocalizedString(hudtextstring2a);
	hudtext3 = makeLocalizedString(hudtextstring3a);

	level.logo = newHudElem();
	level.logo.x = 15;
	level.logo.y = 15;
	level.logo.alignx = "left";
	level.logo.aligny = "middle";
	level.logo.fontscale = 0.9;
	level.logo.archived = true;
	while ( 1 )
	{
		level.logo.alpha = 0;
		level.logo setText( hudtext1 );
		level.logo fadeOverTime( 2 );
		level.logo.alpha = 1;
		
		wait 8;
		
		level.logo fadeOverTime( 2 );
		level.logo.alpha = 0;
		
		wait 2;
		
		level.logo setText( hudtext2 );
		level.logo fadeOverTime( 2 );
		level.logo.alpha = 1;
		
		wait 8;
		
		level.logo fadeOverTime( 2 );
		level.logo.alpha = 0;
		
		wait 2;
		
		level.logo setText( hudtext3 );
		level.logo fadeOverTime( 2 );
		level.logo.alpha = 1;
		
		wait 8;
		
		level.logo fadeOverTime( 2 );
		level.logo.alpha = 0;
		
		wait 2;
	}
}