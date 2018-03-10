# ocp-pipelines

Demo examples of pipelines solving different problems. I've tried to keep examples simple to not blur with all kinds of other stuff.

## AB Deploy
Create example by running ./ab-deploy.sh

Still some work to do:
* Project names hardcoded.
* Other hardcoded values.
* First deploy will fail. Fix with oc expose svc/myproject -n jbl-prod
