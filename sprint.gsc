precache()
{
    precacheShader("gfx/hud/hud@health_back.dds");
    precacheShader("gfx/hud/hud@health_bar.dds");
}

start(speed_increase, duration, recovery_time)
{
    self _hud_create();

    m_ticks = duration * 20; // Maximum sprint ticks
    s_ticks = m_ticks; // Sprint ticks left

    r_ticks = recovery_time * 20; // Maximum recovering ticks
    w_ticks = 0; // Ticks to fulfill recovering period

    speed_normal = getCvarInt("g_speed");
    speed_sprint = speed_normal + (speed_normal * speed_increase / 100);

    last_origin = self.origin;

    // Initialize current speed
    current_speed = self getSpeed();

    while (self.sessionstate == "playing") {
        if (
            self useButtonPressed()
            && !(self attackButtonPressed()) // Prevent sprint glitch.
            && s_ticks
            && self getStance() == "stand"
            && self.origin != last_origin
            && self _is_not_walking_backward(last_origin) // Only allow forward-facing sprint.
        ) {
            self setSpeed(speed_sprint); // Set sprinting speed
//            self disableWeapon();

            s_ticks--;
            self _hud_update(s_ticks * 128 / m_ticks);
        } else {
            // Reset to normal speed if not sprinting
            if (self getSpeed() != speed_normal) {
                self setSpeed(speed_normal); // Reset to normal speed
//                self enableWeapon();

                w_ticks = (m_ticks - s_ticks) * r_ticks / m_ticks;
            }

            // Manage recovery ticks
            if (w_ticks) {
                w_ticks--;
            } else if (s_ticks < m_ticks) {
                s_ticks++;
                self _hud_update(s_ticks * 128 / m_ticks);
            }
        }

        last_origin = self.origin;
        wait 0.05;
    }

    // Ensure default speed is restored at the end
    if (self.sessionstate == "playing" && self getSpeed() != 190) {
        self setSpeed(190);
//        self enableWeapon();
    }

    self _hud_destroy();
}

_is_not_walking_backward(previous_origin)
{
    look_angle = self.angles[1]; // [-180, 180)
    walk_angle = VectorToAngles(self.origin - previous_origin)[1]; // [0, 360)
    // Correct to [-180, 180).
    if (walk_angle > 180) {
        walk_angle -= 360;
    }

    delta = walk_angle - look_angle;
    if (delta > 180) {
        delta -= 360;
    } else if (delta < -180) {
        delta += 360;
    }

    return delta > -120 && delta < 120;
}

_hud_create()
{
    self._hud_sprint_bg = newClientHudElem(self);
    self._hud_sprint_bg setShader("gfx/hud/hud@health_back.dds", 128 + 2, 5);
    self._hud_sprint_bg.alignX = "left";
    self._hud_sprint_bg.alignY = "top";
    self._hud_sprint_bg.x = 488 + 13;
    self._hud_sprint_bg.y = 454;

    self._hud_sprint = newClientHudElem(self);
    self._hud_sprint setShader("gfx/hud/hud@health_bar.dds", 128, 3);
    self._hud_sprint.color = (0, 0, 1);
    self._hud_sprint.alignX = "left";
    self._hud_sprint.alignY = "top";
    self._hud_sprint.x = 488 + 14;
    self._hud_sprint.y = 455;
}

_hud_update(width)
{
    if (width == 0) {
        self._hud_sprint setShader("");
    } else {
        self._hud_sprint setShader("gfx/hud/hud@health_bar.dds", width, 3);
    }
}

_hud_destroy()
{
    if (isDefined(self._hud_sprint)) {
        self._hud_sprint destroy();
    }
    if (isDefined(self._hud_sprint_bg)) {
        self._hud_sprint_bg destroy();
    }
}
