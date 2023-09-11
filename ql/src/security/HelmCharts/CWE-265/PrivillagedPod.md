# Privileged Pod defined

Helms charts allow a pod to be defined as privileged which has many security concerns. This allows the pod to run with root privileges. This is a security risk as it allows the pod to access the host system and other pods running on the same node.

## Sample Code

The following Helm chart defines a privileged pod:

```yaml
spec:
  privileged: true
  # or
  containers:
    - name: mycontainer
      securityContext:
        privileged: true
```

## Recommendation

Ensure that the pod is not defined as privileged, remove the `privileged: true` line from the pod definition or define it as `privileged: false`:

```yaml
spec:
  privileged: false
  # or
  containers:
    - name: mycontainer
      securityContext:
        privileged: false
```
