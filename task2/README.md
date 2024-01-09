# Notes

- Resource usage calculations are converted to nearest integer to avoid bash floating point comparison annoyances
- Continuous execution of script can be handled by many methods (the simplest being a cronjob). I've included how I would deploy this script on a Kubernetes cluster in the k8s folder.
