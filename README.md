# Hierarchical State Machine (HSM) for GameMaker

Quick usage:
- On create event, define states via `state_machine = new state_machine("Idle");`.
- Set a parent state that runs every step with `state_machine.parent_run = function(){ //parent things }`
- Add states usin `state_machine.add_states("Name", { on_enter: function(){}})`. It can be used with on_step, that runs every step and with on_exit, that runs at the last frame.
- You can change states manually using `state_machine._set_state("State_Name");` or with `state_machine.add_transition(_from_state, _destination_state, _condition)`

- Example:

```gml
state_machine.add_transition("Idle", "Jump", function () {
    return jump_input && on_ground;
});
```

- Finally, call `state_machine.update(id);` at step event.
