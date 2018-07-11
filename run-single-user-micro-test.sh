#!/usr/bin/env bash

# 1 parallel users interactions every 0,5 seconds / ramp up in 0 seconds / hold for 30 seconds / ramp down in 0 seconds
./run-jmeter.sh jmeter-plans/confluence.example.com.jmx \
    -JDefaultThreads=1 \
    -JInteractionInterval=500 \
    -JDefaultRampUp=0 \
    -JDefaultDuration=30 \
    -JDefaultRampDown=0
