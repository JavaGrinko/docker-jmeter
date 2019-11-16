FROM openjdk:8-alpine
ENV JMETER_VERSION=5.1.1
ENV JMETER_PLUGINS_MANAGER_VERSION=1.3
ENV JMETER_HOME=/opt/jmeter/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN=${JMETER_HOME}/bin
ENV PATH=${JMETER_BIN}:${PATH}
RUN mkdir /opt/jmeter
RUN wget -P /opt/jmeter https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz \
    && tar x -z -f /opt/jmeter/apache-jmeter-${JMETER_VERSION}.tgz -C ./opt/jmeter
RUN wget -P ${JMETER_HOME}/lib https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-cmn-jmeter/0.3/jmeter-plugins-cmn-jmeter-0.3.jar
RUN wget -P ${JMETER_HOME}/lib/ext http://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-manager/${JMETER_PLUGINS_MANAGER_VERSION}/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar \
    && wget -P ${JMETER_HOME}/lib http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/2.2/cmdrunner-2.2.jar \
    && java -cp ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller
COPY plugins/ ${JMETER_HOME}/lib/ext
RUN ${JMETER_HOME}/bin/PluginsManagerCMD.sh status
WORKDIR /jmeter