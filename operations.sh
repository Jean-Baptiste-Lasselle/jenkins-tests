#!/bin/bash

# - 


docker-compose down && docker system prune -f $& docker-compose build && docker-compose up -d