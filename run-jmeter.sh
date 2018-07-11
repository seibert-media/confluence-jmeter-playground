#!/usr/bin/env bash

function help() {
    echo "
Usage: ${0} <jmeter_config_path> <options>

Example: ${0} jmeter-plans/confluence.example.com.jmx -JDefaultThreads=20 -JDefaultRampUp=20 -JDefaultDuration=60

Threads per group (= concurrent users)

    -JDefaultThreads=<value> (Default: 0)       - Default for all groups

Interaction interval per thread

    -JInteractionInterval (Default: 10000ms)    - Value for all groups

Ramp up time (until all thread are started)

    -JDefaultRampUp=<value> (Default: 0)        - Default for all groups

Ramp down time (before all thread are shut down)

    -JDefaultRampDown=<value> (Default: 0)      - Default for all groups

Duration

    -JDefaultDuration=<value> (Default: 30)     - Default for all groups

InfluxDB URL

    -JInfluxDbUrl=<url> (Default: http://localhost:8086) - InfluxDB URL for backend listener
    "

}

# Read and check Parameters
jmeter_config_path="${1}"

if [ ! -f $jmeter_config_path ]; then
    echo "ERROR: Config file  ${jmeter_config_path} not found."
    help
    exit 1
fi

if [ -z $2 ]; then
    echo "ERROR: No options given"
    help
    exit 1;
fi

# Set variables
jmeter_config="${jmeter_config_path##*/}"
jmeter_config_name="${jmeter_config%.*}"
timestamp=$(date +%s)
folder="report-${jmeter_config_name}-${timestamp}"
current_report_symlink="current_report"
assertion_report="${current_report_symlink}/assertions.csv"

mkdir -p "${folder}/responses"

rm -f "${current_report_symlink}"
ln -s "${folder}" "${current_report_symlink}"

JVM_ARGS="-Xms1g -Xmx1g"
export JVM_ARGS

parameters=$(echo $@ | sed s:$jmeter_config_path::)

echo "Config path: ${jmeter_config_path} / Further parameters: ${parameters}"

./apache-jmeter-4.0/bin/jmeter.sh -n \
    -t "${jmeter_config_path}" \
    -l "${current_report_symlink}/report.log" \
    -e -o "${current_report_symlink}/web-report" \
    $parameters

echo "Config path: ${jmeter_config_path} / Further parameters: ${parameters}"
