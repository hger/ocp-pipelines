#!/bin/bash
# Use -n for nexus repo
#     -p for project prefix
#     -u for user to access project

while getopts n:p:u: option
do
case "${option}"
in
n) NEXUS=${OPTARG};;
p) PREFIX=${OPTARG};;
u) OCP_USER=${OPTARG};;
esac
done

if [ -z "$PREFIX" ]
then
  PREFIX=jbl
fi

if [ -z "$OCP_USER" ]
then
  OCP_USER=developer
fi


rm ab-pipeline.yml
cp ab-pipeline.yml.orig ab-pipeline.yml

if [ -n "$NEXUS" ]
then
  ex -sc "15i|            writeFile file: 'maven_openshift_settings.xml', text: '''<settings xmlns=\"http://maven.apache.org/SETTINGS/1.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"  xsi:schemaLocation=\"http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd\"> 
              <mirrors>
                <mirror>
                  <id>local-oc-repo</id>
                  <name>Local Openshift Repository</name>
                  <url>http://nexus-nexus.192.168.99.100.nip.io/nexus/content/groups/public</url>
                  <mirrorOf>*</mirrorOf>
                </mirror>
              </mirrors>
            </settings>'''
            def mvnCmd = \"mvn -s maven_openshift_settings.xml\"" -cx ab-pipeline.yml
else
  ex -sc "15i|            def mvnCmd = \"mvn\"" -cx ab-pipeline.yml
fi

sed -i -- 's/jbl-dev/'"$PREFIX"'-dev/g' ab-pipeline.yml
sed -i -- 's/jbl-prod/'"$PREFIX"'-prod/g' ab-pipeline.yml

oc new-project $PREFIX-ab-pipeline-demo
oc policy add-role-to-user edit $OCP_USER -n $PREFIX-ab-pipeline-demo
oc create -f ab-pipeline.yml
oc new-project $PREFIX-dev
oc policy add-role-to-user edit $OCP_USER -n $PREFIX-dev
oc policy add-role-to-user edit system:serviceaccount:$PREFIX-ab-pipeline-demo:jenkins
oc new-project $PREFIX-prod
oc policy add-role-to-user view $OCP_USER -n $PREFIX-prod
oc policy add-role-to-user edit system:serviceaccount:$PREFIX-ab-pipeline-demo:jenkins
