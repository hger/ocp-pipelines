#!/bin/bash

oc new-project ab-pipeline-demo
oc create -f ab-pipeline.yml
oc new-project jbl-dev
oc policy add-role-to-user edit system:serviceaccount:ab-pipeline-demo:jenkins
oc new-project jbl-prod
oc policy add-role-to-user edit system:serviceaccount:ab-pipeline-demo:jenkins
