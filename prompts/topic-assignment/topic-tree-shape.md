# The topic tree

The user message gives you the current tree as `{existing_topics}`. Each topic
carries a path, a display name, and its parent path.

A path is the topic's stable identifier: a slash-delimited route from a root
topic down to this one, for example `deployment` or `deployment/nix-rollout`. The
path is what you cite when you reuse a topic — copy it exactly as shown; never
invent, abbreviate, or reshape an existing path.

Topics nest. A child path extends its parent path by one segment. A root topic has
no parent. One topic is the seeded catch-all that the coordinator holds; every
session has it, and it is the fallback owner for work that has no better home.

Read the whole tree before deciding. A mission often fits a specific child topic
better than the broad parent it descends from; prefer the most specific existing
topic that still covers the mission.
