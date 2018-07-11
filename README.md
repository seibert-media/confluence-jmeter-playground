# Confluence JMeter Playground

## Setup

    # Download jmeter
    ./jmeter-setup.sh
    
    # Open JMeter UI
    open apache-jmeter-4.0/bin/ApacheJMeter.jar

## Run plan

    # 30 parallel users interactions every 2 seconds / ramp up in 60 seconds / hold for 10 minutes / ramp down in 60 seconds
    ./run-jmeter.sh jmeter-plans/confluence.example.com.jmx \
        -JDefaultThreads=30 \
        -JInteractionInterval=2000 \
        -JDefaultRampUp=60 \
        -JDefaultDuration=1800 \
        -JDefaultRampDown=60
