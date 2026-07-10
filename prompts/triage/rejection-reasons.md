# Closed rejection reasons

On a rejection, name exactly one of these atoms and no other. They are the only
legal model-emittable reason atoms. Transport and parser-harness failures — a
provider being unavailable, a timeout — belong to the adapter, not the model.

- NoEligibleRecipient — no agent in the directory can receive this message and it
  does not warrant escalation to the coordinator.
- SenderNotRegistered — the sender is not present in the agent directory, so the
  message has no accountable origin.
- MalformedPayload — the message content is unreadable or carries no routable
  substance.

Reject only when neither routing nor escalation is possible. When no agent fits but
the coordinator should decide, escalate; do not reject.
