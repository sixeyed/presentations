# Docker 101 & Workshop

These demo docs at https://is.gd/bekaxe.

Session slides at https://is.gd/fuwasi.

Video at https://youtu.be/smLgvYWr9iQ.

## Demo 1 - Nextcloud

Browse to https://nextcloud.com

- _Get Nextcloud_
- _Download for Server_
- _Instructions_ / _Web installer_ / _Appliances_ -> Docker Hub

```
docker run -d -p 8080:80 nextcloud

docker container ls
```

> Open http://localhost:8080


## Workshop

The workshop demos a simple NodeJS app which uses a SQL Server database, with both components running in Docker containers.

> The online workshop is here: https://dockr.ly/intro-workshop

The source for the demo app is on GitHub: [dockersamples/node-bulletin-board](https://github.com/dockersamples/node-bulletin-board.git).
