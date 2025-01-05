#!/bin/bash

# Our containers
declare -a jcon=("plain" "module" "graal")

# Function to get time in milliseconds
get_time_ms() {
    perl -MTime::HiRes=time -e 'printf "%.0f\n", time() * 1000'
}

# Make sure that no container already exist & run the containers
echo "Image| size| Startup"
for i in "${jcon[@]}"
do
    # Clean up old containers
    docker rm $i > /dev/null 2>&1

    # Get start time
    START=$(get_time_ms)

    # Run container and wait for it to be ready
    docker run --name $i $i java -version > /dev/null 2>&1

    # Get stop time
    STOP=$(get_time_ms)

    # Calculate size
    SIZE=$(docker image inspect $i --format='{{.Size}}' | awk '{ printf "%.2fMB", $1 / 1024 / 1024 }')

    # Calculate duration
    DURATION=$((STOP - START))

    echo "$i| $SIZE| $DURATION ms"

    # Clean up container
    docker rm $i > /dev/null 2>&1
done