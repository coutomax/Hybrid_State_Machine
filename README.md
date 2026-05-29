Hierarchical State Machine (HSM) for GameMaker

Files added/modified:
- `scripts/scr_state_machine/scr_state_machine.gml`: HSM utilities (state_create, state_machine_create, start, update, change, event)
- `objects/obj_player/Create_0.gml`: example state hierarchy (root -> grounded -> idle/walk, air)
- `objects/obj_player/Step_0.gml`: calls `state_machine_update` each step

Quick usage:
- Define states via `state_create(name, parent, handlers)`.
- Create a machine with `state_machine_create(rootState)` and start with `state_machine_start(hsm, id)`.
- Call `state_machine_update(hsm, id)` from the object's Step event.

Handlers receive the instance as the first argument and may call `state_machine_change(instance.hsm, targetState, instance)` to switch states.
