#!/bin/bash
#     -p for project prefix

while getopts p: option
do
case "${option}"
in
p) PREFIX=${OPTARG};;
esac
done

if [ -z "$PREFIX" ]
then
  PREFIX=jbl
fi


oc delete project $PREFIX-ab-pipeline-demo
oc delete project $PREFIX-dev
oc delete project $PREFIX-prod
