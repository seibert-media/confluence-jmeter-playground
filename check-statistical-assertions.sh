#!/usr/bin/env bash

set -e

current_report_symlink="current_report"
aggregate_report="${current_report_symlink}/report.log"
assertions_jar=$(ls apache-jmeter-4.0/jmeter-statistical-assertions-*-jar-with-dependencies.jar)

assertions_yml=$1;

if [ ! -f $assertions_yml ]; then
    echo "ERROR: Assertions file '${assertions_yml}' not found (given parameter: '$assertions_yml')";
    exit 1;
fi

echo
java -jar $assertions_jar report $aggregate_report
java -jar $assertions_jar check $aggregate_report ${assertions_yml}
