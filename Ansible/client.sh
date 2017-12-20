#!/bin/bash

# Loop for up to 20 consecutive failures
for (( failures=0; failures<200; ))
do
    # Issue the curl command with urls from script args
    ssh -p 2525 sambrentnall@rixter.net
    # save the exit code of curl for use in comparison and exit
    rc=$?
    if [ $rc = 0 ]
    then
        failures=0
        if [ ! "$CONTINUOUS" = "true" ]
        then
            echo SUCCESS
            break
        fi
    else
        failures=$((failures + 1))
        echo FAILURE $failures rc=$rc
    fi
    # Otherwise wait a second and try again
    sleep 5
done

exit $rc