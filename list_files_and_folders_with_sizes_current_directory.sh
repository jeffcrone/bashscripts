#!/bin/bash
# Goes through all the files in the current directory and lists them with file sizes, also sorts them.

du -hs * | sort -h
