#!/bin/bash

pastPoints="0"
let sleepTime=10

while true; do
# Get the milestone banner
	pageData=$(curl -s https://api.imgur.com/homepage/v1/milestones)
	error=$(echo $pageData | grep -oP "(\"success\":false)")

# If we actually got a response
# Else we go trough the response and record current total votes
	if [[ $error = "\"success\":false" ]]; then
		let delayedSleep=$sleepTime+600
		echo -ne "Unable to fetch, last recorded point: $pastPoints :emeraldupvote2: next update ${delayedSleep}s\033[0K\r"
		sleep $delayedSleep
	else
# 	RegExp to find the total points variable, and extract the number of votes
		let points=$(echo $pageData | grep -oP "(?<=let totalHype = )(\d*)")

# 	If the new value is the same as previous recorded value, we add to the sleep time for next curl
#	 	Else we format the value as csv and and log it in a file
		if [[ $pastPoints = $points ]]; then
			let sleepTime=$sleepTime+10
		else
			echo \"$points\",\"$(($(date +%s%N)/1000000))\" >> "log.txt"
			pastPoints=$points
		fi

#	 	Format the currently recorded value
#	 	Print the value along with the current sleepTime
		points=$(echo $points | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')
		echo -ne "$points :emeraldupvote2: next update ${sleepTime}s\033[0K\r"
		sleep $sleepTime
	fi
done