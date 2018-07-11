#!/usr/bin/env bash

set -e

current_report_symlink="current_report"
assertion_report="${current_report_symlink}/assertions.csv"

number_of_errors=$(tail -n +2 ${assertion_report} | wc -l | tr -d '[:space:]')

if [ $number_of_errors != 0 ]; then
    (>&2 echo "ERROR: Found ${number_of_errors} in ${assertion_report}")
    exit 1
fi
