#!/bin/bash

time=`date +%Y/%m/%d-%H:%M:%D`

git add *
git commit -m "auto push @ $time"
git push origin main

echo "auto pushed at $time"
