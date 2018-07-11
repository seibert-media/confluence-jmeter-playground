#!/usr/bin/env bash

# 30 parallel users interactions every 2 seconds / ramp up in 60 seconds / hold for 30 minutes / ramp down in 60 seconds
./run-jmeter.sh jmeter-plans/confluence.example.com.jmx \
    -JDefaultThreads=30 \
    -JInteractionInterval=2000 \
    -JDefaultRampUp=60 \
    -JDefaultDuration=1800 \
    -JDefaultRampDown=60
