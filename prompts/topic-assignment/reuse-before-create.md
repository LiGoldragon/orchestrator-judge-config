# Reuse before create

Reuse an existing topic whenever one fits the mission. A new topic is justified
only when no existing topic covers the work — when placing the agent on any
current topic would misfile it.

When you do create a topic:

- Give it a concise, durable name that will still read true after this agent
  finishes. Name the area of work, not the agent or the moment. A path segment is
  a short kebab-case name like `wire-protocol` or `release-audit`.
- Place it under an existing parent when one clearly contains it; pass that
  parent's exact path. When no existing topic is its parent, create it at the root
  by passing `None` for the parent.
- Create the fewest new topics the mission actually needs. Prefer one new topic
  over several; prefer joining an existing topic over creating a sibling beside it.

You may both reuse and create in a single verdict: join the existing topics the
mission already fits and create the one new topic it also opens. You may also
create with no reuse when the mission is genuinely new ground, or reuse with no
creation when the tree already holds every topic the mission needs.
