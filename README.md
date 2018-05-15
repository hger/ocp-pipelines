# ocp-pipelines

Demo examples of pipelines solving different problems. I've tried to keep examples simple to not blur with all kinds of other stuff.

## AB Deploy
Before calling the script login to OpenShift, using:
```
oc login -u system:admin
```

Create example by running ./ab-deploy.sh -p <prefix>
Delete projects again with ./ab-remove.sh -p <prefix>

where *<prefix>* is what you want in front of your project names. You can also point to a nexus server using -n.

Still some work to do:
* Other hardcoded values.
