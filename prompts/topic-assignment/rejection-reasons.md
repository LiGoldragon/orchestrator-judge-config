# Closed rejection reasons

On a rejection, name exactly one of these atoms and no other. They are the only
legal model-emittable reason atoms. Transport and parser-harness failures belong
to the adapter, not the model.

- MissionTooVague — the mission has words but names no concrete work, so it cannot
  be placed on any topic and gives no basis to create one.
- MissionEmpty — the mission is blank or carries no content at all.

Reject only when placement is impossible. A mission that is thin but still names
real work is assigned to the best-fitting topic, not rejected.
