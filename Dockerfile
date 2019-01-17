FROM node:10
LABEL Maintainer="Yann Ponzoni (Mobioos) <yann.ponzoni@redfabriq.com>"

ARG SONAR_SCANNER_VERSION="sonar-scanner-cli-3.3.0.1492-linux"

ENV SONAR_HOST_URL 'http://localhost:9000'
ENV SONAR_LOGIN 'changeme'
ENV SONAR_PASSWORD 'changeme'

# Install Typescript
RUN npm install -g typescript

# Install sonar-scanner
ADD https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${SONAR_SCANNER_VERSION}.zip /tmp/sonarscanner.zip
RUN unzip /tmp/sonarscanner.zip -d /opt/                                                                               \
 && mv -v /opt/sonar-scanner*/                       /opt/sonar-scanner/                                               \
 && ln -s /opt/sonar-scanner/bin/sonar-scanner       /usr/local/bin/                                                   \
 && ln -s /opt/sonar-scanner/bin/sonar-scanner-debug /usr/local/bin/


ENV NODE_PATH "/usr/local/lib/node_modules/"

# Define entrypoint
COPY entrypoint.sh /entrypoint.sh

# Write the configuration file from envvars
ENTRYPOINT ["/entrypoint.sh"]
