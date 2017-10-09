

# Demo 1

Build app in Docker


# Demo 2

Run with Docker Compose locally


# Demo 3 - run in test VM

Create secrets:

```
docker secret create audit-db-password ./secrets/audit-db-password

docker secret create backbone-db-password ./secrets/backbone-db-password

docker secret create chat-connection-strings ./secrets/chat-connection-strings
```

Run app:

```
docker stack deploy -c docker-stack-v1.yml chat
```

Find issue:

```
Bye!'); DELETE FROM ChatAudit; --
```

Fix issue:

```
docker stack deploy -c docker-stack-v2.yml chat
```

# Demo 4

Run in EE with stack