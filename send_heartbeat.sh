#!/bin/bash

# Define your namespace and metric name
NAMESPACE="dns7"
METRIC_NAME="heartbeat"
# Optionally, add an instance identifier to distinguish between different servers or applications
SOURCE="t6"
# The value for the heartbeat; since it's a signal, the actual number doesn't matter much, 1 is a common choice
HEARTBEAT_VALUE=1

# Infinite loop to send the heartbeat every minute
while true; do
  # Use AWS CLI to publish the metric to CloudWatch
  aws cloudwatch put-metric-data \
    --namespace "$NAMESPACE" \
    --metric-name "$METRIC_NAME" \
    --value $HEARTBEAT_VALUE \
    --dimensions source=$SOURCE
  
  # Wait for 60 seconds (1 minute) before sending the next heartbeat
  sleep 60
done
