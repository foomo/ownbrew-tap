#!/bin/bash

semver_compare() {
  var1=$1;
  var2=$2;
  for i in 1 2 3
  do
    part1=`echo $var1 | cut -d "." -f $i`
    part2=`echo $var2 | cut -d "." -f $i`
    if [ $part1 -lt $part2 ]
    then
      return 0
    fi
  done
  return 1
}