FROM openjdk:9-jdk-slim AS builder
WORKDIR /usr/src/workdir
COPY certificates /usr/local/share/ca-certificates/certificates
ENV PEM_ALIAS="debian:cacert.pem" \
    CER_ALIAS="cacert.cer"
RUN apt-get update && apt-get install --no-install-recommends -y -qq ca-certificates-java \
    && update-ca-certificates \
    && keytool \
        -export \
        -alias ${PEM_ALIAS} \
        -file ${CER_ALIAS} \
        -keystore /docker-java-home/lib/security/cacerts \
        -storepass changeit \
        -noprompt \
    && keytool \
        -import \
        -v \
        -trustcacerts \
        -alias ${PEM_ALIAS} \
        -file ${CER_ALIAS} \
        -keystore truststore.ts \
        -storepass changeit \
        -noprompt

FROM openjdk:9-jdk-slim
WORKDIR /home/java
ENTRYPOINT ["keytool", "-list", "-v", "-keystore", "truststore.ts", "-storepass", "changeit", "-alias"]
CMD ["debian:cacert.pem"]

RUN groupadd --gid 1000 java \
    && useradd --uid 1000 --gid java --shell /bin/bash --create-home java \
    && chmod -R a+w /home/java

USER java
COPY --chown=java:java --from=builder /usr/src/workdir/truststore.ts .
