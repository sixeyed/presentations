# Demo: Claude Web


## Chat basics

> https://claude.ai/new

```
what's new
```

And retry a few times. Answers vary from "not much - what would you like to know" to a general round-up of UK news. Claude is not deterministic, and vague questions get vague responses.

```
i've been away for a week with no internet access. what's new in uk news, f1, open weight AI models and jazz-adjacent electronic music. summarise each with links to key resources.
```

Expand thinking - tool use, web search.

Follow up in the same chat:

```
uk news all looks bad. any good news items?
```

_Context_ is the full conversation - request and response - which gets sent along with your latest prompt. It could be routed to any Claude instance, but there is caching so if you hit the same instance the response is faster.

## Images

Claude is not good at generating images. This is a very early chat about [Jonathan Trotman's style](https://jonathantrotman.co.uk/archive-paintings/):

- [Who is Jonathan Trotman?](https://claude.ai/chat/f6f986bc-b7e7-4560-a164-f10d11825f88)

But it can interpret them.

Grab a screenshot of the architecture diagram from chapter 1:

- https://github.com/sixeyed/claude-at-work/tree/main/chapters/ch01

```
what do you make of this?
```

Interpreted as a software architecture diagram, and identified the components and flow. Responses varied from key design decisions to focus on, to Claude wanting more information.

## Session management

Sessions never die. You can return to them at any point and pick up where you left off. Organization helps:

- rename
- pin
- search

Previous chats:

- [Where to fit the disk in an HP-Z6 workstation](https://claude.ai/chat/750a388a-d8d4-4cb2-839e-1607447b838d)
- [Alex Honnold's Skyscraper Live](https://claude.ai/share/ebc3a789-f2fc-4f3f-9c63-4031855de08b)

Sessions can be shared publicly or to invitees.

## Skills and connectors

> https://claude.ai/customize/skills

Skills are repeatable tasks with instructions and examples for Claude to follow.

- File & documents
- Data
- Engineering

> https://claude.ai/customize/connectors

Connectors link Claude to external services - so it can search your email, create calendar invites etc. Connectors use the MCP protocol via OAuth so Claude never knows your credentials.

