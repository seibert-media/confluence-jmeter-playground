#!/usr/bin/env bash

JAVA="java"

# java fallback alias (example JAVA_CMD="/opt/jdk8/bin/java")
if command -v $JAVA; then
    echo "java exists"
else
    if command -v $JAVA_CMD; then
        echo "java not found. Set JAVA from variable JAVA_CMD (value ${JAVA_CMD})"
        JAVA="${JAVA_CMD}"
    else
        echo "Command ‘java' is missing and no working command for JAVA_CMD found";
        exit 1;
    fi
fi

jmeter_version="4.0"
jmeter_folder="apache-jmeter-${jmeter_version}"
jmeter_url="http://mirror.netcologne.de/apache.org//jmeter/binaries/${jmeter_folder}.tgz"

if [ -d ${jmeter_folder} ]; then
    echo "${jmeter_folder} exists"
else
    rm ${jmeter_folder}.*
    echo "${jmeter_folder} is missing. Downloading it now from ${jmeter_url}"
    wget "${jmeter_url}"
    tar -xzf "${jmeter_folder}.tgz"
fi

# Download Plugin Manager
# #######################

jmeter_plugin_manager_version="1.1"
jmeter_plugin_manager_filename="jmeter-plugins-manager-${jmeter_plugin_manager_version}.jar"
jmeter_plugin_manager_url="http://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-manager/${jmeter_plugin_manager_version}/${jmeter_plugin_manager_filename}"
jmeter_plugin_manager_path="${jmeter_folder}/lib/ext/${jmeter_plugin_manager_filename}"

if [ -f ${jmeter_plugin_manager_path} ]; then
    echo "${jmeter_plugin_manager_path} exists"
else
    echo "${jmeter_plugin_manager_path} is missing. Downloading it now from ${jmeter_plugin_manager_url}"
    wget -O "${jmeter_plugin_manager_path}" "${jmeter_plugin_manager_url}"
fi

# Download CMD-Runner
# ###################

jmeter_cmdrunner_name="cmdrunner"
jmeter_cmdrunner_version="2.2"
jmeter_cmdrunner_filename="${jmeter_cmdrunner_name}-${jmeter_cmdrunner_version}.jar"
jmeter_cmdrunner_url="http://central.maven.org/maven2/kg/apc/${jmeter_cmdrunner_name}/${jmeter_cmdrunner_version}/${jmeter_cmdrunner_filename}"
jmeter_cmdrunner_path="${jmeter_folder}/lib/${jmeter_cmdrunner_filename}"

if [ -f ${jmeter_cmdrunner_path} ]; then
    echo "${jmeter_cmdrunner_path} exists"
else
    echo "${jmeter_cmdrunner_path} is missing. Downloading it now from ${jmeter_cmdrunner_url}"
    wget -O "${jmeter_cmdrunner_path}" "${jmeter_cmdrunner_url}"
fi

# Install Plugin Manager
# ######################
jmeter_plugin_manager_cmd="apache-jmeter-4.0/bin/PluginsManagerCMD.sh"

if [ -f ${jmeter_plugin_manager_cmd} ]; then
    echo "${jmeter_plugin_manager_cmd} exists"
else
    echo "${jmeter_plugin_manager_cmd} is missing. Start installation..."
    $JAVA -cp ${jmeter_plugin_manager_path} org.jmeterplugins.repository.PluginManagerCMDInstaller
fi

# Install Custom Thread Group Plugin
# ##################################
${jmeter_plugin_manager_cmd} install jpgc-casutg

# Print version to check installation
# ###################################

./apache-jmeter-4.0/bin/jmeter.sh --version

# Download JMeter Statistical Assertions
# ######################################

jmeter_statistical_assertions="jmeter-statistical-assertions"
jmeter_statistical_assertions_version="0.2.2"
jmeter_statistical_assertions_filename="${jmeter_statistical_assertions}-${jmeter_statistical_assertions_version}-jar-with-dependencies.jar"
jmeter_statistical_assertions_url="https://github.com/seibert-media/jmeter-statistical-assertions/releases/download/v${jmeter_statistical_assertions_version}/${jmeter_statistical_assertions}-${jmeter_statistical_assertions_version}-jar-with-dependencies.jar"
jmeter_statistical_assertions_path="${jmeter_folder}/${jmeter_statistical_assertions_filename}"

if [ -f ${jmeter_statistical_assertions_path} ]; then
    echo "${jmeter_statistical_assertions_path} exists"
else
    rm "${jmeter_folder}/${jmeter_statistical_assertions}"*
    echo "${jmeter_statistical_assertions_path} is missing. Downloading it now from ${jmeter_statistical_assertions_url}"
    wget --no-check-certificate -O "${jmeter_statistical_assertions_path}" "${jmeter_statistical_assertions_url}"
fi
