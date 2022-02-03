# Demo 4: ConfigMaps

There are two ways to store configuration settings in ConfigMaps - either as key-value pairs, which you'll surface as environment variables, or as text data which you'll surface as files in the container filesystem.

## Setting config with environment variables in the Pod spec

The Pod spec is where you apply configuration:

- [deployment.yaml](specs/configurable/deployment.yaml) adds a config setting with an environment variable in the template Pod spec.

```
kubectl apply -f configmaps/
```

You can check the environment variable is set by running `printenv` inside the Pod container:

```
kubectl exec deploy/configurable -- printenv | grep __
```

And test the app at http://localhost:8010

## Setting config with environment variables in ConfigMaps

Environment variables in Pod specs are fine for single settings like feature flags. Typically you'll have lots of settings and you'll use a ConfigMap:

- [configmap-env.yaml](configmaps/config-env/configmap-env.yaml) - a ConfigMap with multiple environment variables
- [deployment-env.yaml](configmaps/config-env/deployment-env.yaml) - a Deployment which loads the ConfigMap into environment variables

```
kubectl apply -f configmaps/config-env/
```

Check the updated Pod:

```
kubectl exec deploy/configurable -- printenv | grep __
```

Test the app at http://localhost:8010

## Setting config with files in ConfigMaps

Environment variables are limited too. They're visible to all processes so there's a potential to leak sensitive information. There can also be collisions if the same keys are used by different processes.

The filesystem is a more reliable store for configuration; permissions can be set for files, and it allows for more complex config with nested settings.

The demo app can use JSON configuration as well as environment variables, and it supports loading additional settings from an override file:

- [configmap-json.yaml](configmaps/config-json/configmap-json.yaml) - stores the config settings as a JSON data item
- [deployment-json.yaml](configmaps/config-json/deployment-json.yaml) loads the JSON as a volume mount **and** loads environment variables

```
kubectl apply -f configmaps/config-json/
```

> Refresh http://localhost:8010 and you'll see new settings coming from the `config/override.json` file

Explore the container filesystem with `exec` commands:

```
kubectl exec deploy/configurable -- ls /app/

kubectl exec deploy/configurable -- ls /app/config/

kubectl exec deploy/configurable -- cat /app/config/override.json
```

> The first JSON file is from the container image, the second is from the ConfigMap volume mount.

Something's not quite right though - the release setting is still coming from the environment variable:

```
kubectl exec deploy/configurable -- printenv | grep __
```

> The config hierarchy in this app puts environment variables ahead of settings in files, so they get overidden. You'll need to understand the hierarchy for your apps to model config correctly.