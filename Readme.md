## Introduction

The app takes a server log files and prints the list of pages sorted by visit count, both aggregated and uniquely.

## Operations

Using Ruby Version `2.7.4`

Run `bundle` first

Run `./app.rb data/webserver.log` to test with the sample log file or replace the parameter with the given filename

## Test

Run `rspec` to run the tests, we have `100%` code coverage


## Improvements

There can be multiple arguments added to limit the amount of output, or change the way output is formatted