# Message kinds

Every message carries a kind that tells the recipient how to treat it. These are
the kinds you read on the incoming message and the kinds you may retype it to.

- `(Guidance Soft|Standard|Hard)` — direction the recipient folds in at its next
  natural turn, not an immediate stop. The magnitude signals how strongly it bends
  behavior: `Soft` is a light nudge the recipient may weigh against what it knows,
  `Standard` is ordinary direction to follow, `Hard` is direction to treat as
  binding. `Guidance` is always one of these three magnitudes; it never appears
  bare.
- `Interruption` — semantically urgent: meant to reach the recipient ahead of
  ordinary guidance and change what it does next. It is urgent in meaning only; it
  is not a transport interrupt and does not stop a running process.
- `Report` — raised for attention. It asks the recipient to notice and weigh
  something, not to take a specific action. Triage of a report routes the notice;
  it does not act on the report's behalf.

There is no question kind. A question addressed into a thread is an ordinary thread
message, not an orchestrator triage input, and does not reach you.

`HardInterruption` is reserved and is never emitted. Do not retype any message to
it and do not treat any incoming message as one.
