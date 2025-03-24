#!/bin/bash

echo "Starting Update"

sudo dnf update -y 

echo "Starting Clean Up"

sudo dnf clean all

echo "all done"
