
## Demo 1 - From W2K3 to Docker

### 1.1 - Classic ASP

Runs on IIS Windows Server Core image. Uses the [classic-asp Dockerfile](./docker/classic-asp/Dockerfile).

```
docker image build `
  -t sixeyed/w2k3-classic-asp `
  -f .\docker\classic-asp\Dockerfile .   #1.1

docker container run -d sixeyed/w2k3-classic-asp
```

### 1.2 - Static HTML

Runs on IIS Nano Server image. Uses the [static-html Dockerfile](./docker/static-html/Dockerfile).

```
docker image build `
  -t sixeyed/w2k3-static-html `
  -f .\docker\static-html\Dockerfile .   #1.2

docker container run -d sixeyed/w2k3-static-html
```

### - 1.3 - ASP.NET WebForms

Runs on IIS Windows Server Core image, with ASP.NET 3.5. Uses the [webforms-v1 Dockerfile](./docker/webforms-v1/Dockerfile).

```
docker image build `
  -t sixeyed/w2k3-webforms:v1 `
  -f .\docker\webforms-v1\Dockerfile .   #1.3

docker container run -d sixeyed/w2k3-webforms:v1
```

## Demo 2 - ship & run on new Win2016 VM

From dev machine:

```
docker image ls `
  --filter reference=sixeyed/w2k3*   #2.1

docker image ls `
  --filter reference=sixeyed/w2k3* `
  --format '{{ .Repository }}'   #2.2

docker image ls `
  --filter reference=sixeyed/w2k3* `
  --format '{{ .Repository }}' | `
  foreach { docker image push $_ }   #2.3
```

On cloud machine:

```
docker-compose up -d
```

## Demo 3

Lap around v5 Dockerfile


### Credits

Static HTML site from [Vuetify Simple sample](https://github.com/vuetifyjs/simple)