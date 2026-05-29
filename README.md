# Hierarchical State Machine (HSM) for GameMaker
### • This is just a Hybrid State Machine that I created for use in my projects; feel free to use it.


# Setup
- You can download the .yymps file or just copy the raw script from the .gml file, both works fine. :shipit:

# Features

• Separated functions for every state level (on_enter, on_step and on_exit).  
• Easy transitions between states.  
• Choose between state transition type (with add_transition, or simply set_event functions).  
• Nest state behavior into a concise piece of code. 
• Has a parent like behavior, not exatly a hierarchy, but something between Hierarchical and a simple
  Finite State Machine, with a fixed state named "parent".

# Quick usage:

## Create Event:
- On create event, define states via `state_machine = new state_machine("Idle");`.
- Set a parent state that runs every step with `state_machine.parent_run = function(){ //parent things }`
- Add states using `state_machine.add_states("Name", { on_enter: function(){}})`. It can be used with on_step, that runs every step and with on_exit, that runs at the last frame.
- You can change states manually using `state_machine.set_state("State_Name");` or with `state_machine.add_transition(_from_state, _destination_state, _condition)`

- Example:

```gml
state_machine.add_transition("Idle", "Jump", function () {
    return jump_input && on_ground;
});
```
## Step Event:
- Finally, call `state_machine.update(id);`.
