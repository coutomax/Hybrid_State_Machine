grav        = 0.25;
jump_spd    = -5;
xspd        = 0;
yspd        = 0;

states      = new state_machine("Idle");

states.parent_run   = function()
{
    h_input        = keyboard_check(ord("D")) - keyboard_check(ord("A"));
    jump_input     = keyboard_check_pressed(vk_space);

    if (h_input != 0)
    {
        xspd        = h_input * 2;
    }

    //apply gravity
    yspd            += grav;

    //horizontal collisions
    var _h_collision    = place_meeting(x + xspd, y, obj_wall);
    var _vx             = sign(xspd);

    if (_h_collision)
    {
        repeat (abs(xspd) + 1)
        {
            if (place_meeting(x + _vx, y, obj_wall))
            {
                break;
            }
            x           += _vx;
        }
        xspd            = 0;
    }

    //vertical collisions
    var _v_collision    = place_meeting(x, y + yspd, obj_wall);
    var _vy             = sign(yspd);

    if (_v_collision)
    {
        repeat (abs(yspd) + 1)
        {
            if (place_meeting(x, y + _vy, obj_wall))
            {
                break;
            }
            y           += _vy;
        }
        yspd            = 0;
    }

    on_ground       = place_meeting(x, y + 1, obj_wall);

    x           += xspd;
    y           += yspd;
}

states.add_state("Idle", {
    on_enter: function()
    {
        xspd        = 0;
        show_debug_message("Entering idle state");        
    },
    on_step: function() {},
    on_exit: function()
    {
        show_debug_message("Exiting idle state");
    }
});

states.add_state("Walk", {
    on_enter: function()
    {
        show_debug_message("Entering walk state");
    },
    on_step: function()
    {
        if (h_input != 0)
        {
            image_xscale    = sign(h_input);
        }
        //show_debug_message("In walk state");
    },
    on_exit: function()
    {
        show_debug_message("Exiting walk state");
    }
});

states.add_state("Jump", {
    on_enter: function()
    {
        show_debug_message("Entering jump state");
        yspd        = jump_spd;
    },
    on_step: function()
    {
        on_ground   = place_meeting(x, y + 1, obj_wall);
    },
    on_exit: function()
    {
        show_debug_message("Exiting jump state");
    }
});
    
states.add_transition("Idle", "Jump", function () {
    return jump_input && on_ground;
});

states.add_transition("Idle", "Walk", function () {
    return h_input != 0;
});

states.add_transition("Walk", "Jump", function () {
    return jump_input && on_ground;
});

states.add_transition("Walk", "Idle", function () {
    return h_input == 0;
});

states.add_transition("Jump", "Idle", function () {
    return on_ground && h_input == 0;
});

states.add_transition("Jump", "Walk", function () {
    return h_input != 0;
});