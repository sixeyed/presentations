
# Hybrid Docker Swarm

## Demo 1 - all Windows

Create services - all Windows containers - check in viz and test app:

```
./01-create-services.sh
```

## Demo 2 - Elastic on Linux

Replace Elasticsearch and Kibana with Linux containers:

```
./02-replace-elastic.sh
```

## Demo 2 - NATS on Linux

Replace NATS message queue with Linux container:

```
./03-replace-nats.sh
```

## Demo 3 - SQL Server on Linux

Replace SQL Server with Linux container:

```
./04-replace-mssql.sh
```