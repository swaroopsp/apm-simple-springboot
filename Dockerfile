FROM keaz/springbootbase:2.1.6-java-11 as builder
WORKDIR /app
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -Dmaven.test.skip=true

FROM openjdk:11.0.3-jdk-slim-stretch as customjre
LABEL maintainer="swaroop.sp@gmail.com"
ENV LOGGER_FILE_LOCATION="/home/strategy-logs-folder"

COPY --from=builder /home/app/target/apm-simple-springboot-*.jar /usr/local/lib/apm-simple-springboot.jar

RUN apt-get update -y && \
    apt-get install -y wget

RUN wget -O apm-agent.jar https://search.maven.org/remotecontent?filepath=co/elastic/apm/elastic-apm-agent/1.2.0/elastic-apm-agent-1.2.0.jar

CMD java -javaagent:/usr/local/lib/apm-agent.jar \
 -Delastic.apm.service_name=apm-simple-springboot-service \
 -Delastic.apm.application_packages=com.swaroop \
 -Delastic.apm.server_urls=http://apm-server:8200 \
 -jar /usr/local/lib/apm-simple-springboot.jar