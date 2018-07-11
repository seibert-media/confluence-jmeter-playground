#!/usr/bin/env bash

# 150 parallel users interactions every 2 seconds / ramp up in 10 minutes / hold for 3 hours seconds / ramp down in 10 minutes
./run-jmeter.sh jmeter-plans/confluence.example.com.jmx \
    -JDefaultThreads=150 \
    -JInteractionInterval=2000 \
    -JDefaultRampUp=600 \
    -JDefaultDuration=10800 \
    -JDefaultRampDown=600
