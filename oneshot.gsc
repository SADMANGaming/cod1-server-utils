load()
{
    precacheShader("gfx/hud/hud@fire_ready.tga");
}

_finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, spawnprotected)
{
		if(isDefined(self.spawnprotected) && self.spawnprotected)
			return;


	// Don't do knockback if the damage direction was not specified
	if (!isdefined(vDir))
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

	// Make sure at least one point of damage is done
	if (iDamage < 1)
		iDamage = 1;

    if( isDefined( self ) && getcvar("scr_oneshot") == "1") {
        if(isDefined(eAttacker) && sMeansOfDeath != "MOD_FALL" && isBoltWeapon(sWeapon))
           iDamage = iDamage * 100;
    }

    if( isDefined( self ) && getcvar("scr_hitmark") == "1") {
        if(isPlayer(eAttacker) && eAttacker != self)
            eAttacker thread showHit();
	        return (self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc));
    }

}

showHit() // Taken from AWE
{
  self endon("spawned");
	self endon("disconnect");
	
	if(isDefined(self.hitBlip))
		self.hitBlip destroy();

	self.hitBlip = newClientHudElem(self);
	self.hitBlip.alignX = "center";
	self.hitBlip.alignY = "middle";
	self.hitBlip.x = 320;
	self.hitBlip.y = 240;
	self.hitBlip.alpha = 0.5;
	self.hitBlip setShader("gfx/hud/hud@fire_ready.tga", 32, 32);
	self.hitBlip.color = (1, 0.7, 0);
	self.hitBlip scaleOverTime(0.15, 64, 64);

	wait 0.30;

	if(isDefined(self.hitBlip))
		self.hitBlip destroy();
}

isBoltWeapon(sWeapon)
{
    oneshot_pistol = getCvar("scr_oneshot_pistol") == "1";
  switch(sWeapon) {
    case "enfield_mp":
    case "fg42_mp":
    case "fg42_semi_mp":
    case "kar98k_mp":
    case "kar98k_sniper_mp":
    case "mosin_nagant_mp":
    case "mosin_nagant_sniper_mp":
    case "springfield_mp":
    case "enfieldscoped_mp":
    case "knife_mp":
    return true;
    case "colt_mp":
    case "luger_mp":
    if(oneshot_pistol)
    {
        return true;
    }
    break;
  }
  
  return false;
}