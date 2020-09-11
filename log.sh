#!/bin/sh

logMessage() {
  colorCode=$1
  message=$2
  echo -e "\e[${colorCode}m${message}\e[0m"
}

logInfo() {
  logMessage 34 "$1"
}

logSuccess() {
  logMessage 32 "$1"
}

log() {
  logMessage 37 "$1"
}

logWarning() {
  logMessage 33 "$1"
}

