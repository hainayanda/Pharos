#!/bin/bash

set -eo pipefail

xcodebuild -workspace Example/Pharos.xcworkspace \
            -scheme Pharos-Example \
            -destination platform=iOS\ Simulator,OS=16.0,name=iPhone\ 13\ Pro \
            clean test | xcpretty
