
# sonar-scanner-node

Implementation of the sonar-scanner for node projects

Image is actually hosted under `registry.gitlab.com/kirrk/utils/sonarscanner-node:latest` 

## Requirements

This image assume you have a `sonar-project.properties` file at the root of your project.

> See https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner for more information

## Basic Usage

### Launch container

You'll need to define variables :
- `SOURCE_PATH` : The path to your local sources to scan
- `SONAR_HOST_URL` : The host of sonar (http://something:9000 )
- `SONAR_LOGIN` : The user sonar will use to perform analysis
- `SONAR_PASSWORD` : The password of the given user

```bash
docker run                                                      \
  -v ${SOURCE_PATH}:/app                                        \
  -e SONAR_HOST_URL=${SONAR_HOST_URL}                           \
  -e SONAR_LOGIN=${SONAR_LOGIN}                                 \
  -e SONAR_PASSWORD=${SONAR_PASSWORD}                           \
  -it                                                           \
  registry.gitlab.com/kirrk/utils/sonarscanner-node:latest
```

### Inside container

You'll need to define variables :
- `PROJECT_ROOT` : The root of the project to scan

```bash
cd ${PROJECT_ROOT}
sonar-scanner
```

## Advanced usage

### Gitlab-CI

Example of job into gitlab-ci.yml.
Assuming the existence of a stage "analysis". 
The following variables MUST be defined as **secret variables** in CI/CD configuration :
- `SONAR_HOST_URL` : The host of sonar (http://something:9000 )
- `SONAR_LOGIN` : The user sonar will use to perform analysis
- `SONAR_PASSWORD` : The password of the given user

```yaml  
##############################################################################
# Stage: Analysis
##############################################################################

analysis.sonar:
 stage: analysis
 image: registry.gitlab.com/kirrk/utils/sonarscanner-node:latest
 only:
  refs:
   - master
 variables:
  PROJECT_ROOT: <The_path_to_the_source_code_to_scan>
 script:
  - cd ${PROJECT_ROOT}
  - sonar-scanner
```

## TODO

- Build multiple images for multiple node versions (`10`, `11`, ...)
