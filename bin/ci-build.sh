#!/bin/bash

mkdir -p ~/.config/oxidized
oxidized
bundle exec rake test:spec
