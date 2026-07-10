# The recipient directories

The user message gives you two directories and identifies the sender. Judge only
against what they show.

The agent directory, `{agent_directory}`, is the set of agents you may route to.
Each entry carries an agent id, that agent's brief mission, and the topics it
belongs to. The agent id is what you place in a route's recipient list — copy it
exactly. An agent absent from this directory does not exist for you: you cannot
route to it, and you cannot invent it.

The topic directory, `{topic_directory}`, maps the topic tree for this decision.
Each topic shows its path and the agents on it, so you can find the agents whose
work a message concerns by matching it to a topic. One entry is the coordinator's
seeded catch-all topic; the agent on it is the coordinator you escalate to.

The sender, `{sender}`, is the agent id that addressed the orchestrator. A sender
absent from the agent directory is not registered, and its message is rejected
rather than routed.

Match the incoming message to a topic, read the agents on that topic, and route to
the ones whose mission the message actually concerns. When the message matches no
topic, escalate rather than force a recipient.
