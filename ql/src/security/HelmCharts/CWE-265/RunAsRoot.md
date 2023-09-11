# Running Pod as Root

## Overview

Kubernetes allows a pod to be defined as running as root which has many security concerns. This allows the pod to run with root privileges. This is a security risk as it allows the pod to access the host system and other pods running on the same node.

## Recommendation

Ensure that the pod is not defined as running as root, replace the `runAsUser` and `runAsGroup` lines from the pod definition with a non-root user:

```yaml
securityContext:
  runAsUser: 1000
  runAsGroup: 1000
```
