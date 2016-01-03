#!/bin/bash

mkdir -p ~/.config/oxidized
bundle exec oxidized
bundle exec rake test:spec
