#!/usr/bin/env bash

set +e

# Write the configuration file from env vars
echo "
# Configure here general information about the environment, such as SonarQube server connection details for example
# No information about specific project should appear here
# See : https://docs.sonarqube.org/latest/analysis/analysis-parameters/

#----- Default SonarQube server
sonar.host.url=${SONAR_HOST_URL}
sonar.login=${SONAR_LOGIN}
sonar.password=${SONAR_PASSWORD}

#----- Default source code encoding
sonar.sourceEncoding=UTF-8

" > /opt/sonar-scanner/conf/sonar-scanner.properties

# Execute given CMD
exec "$@"
