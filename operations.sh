#!/bin/bash

# - 


docker-compose down --rmi all && docker system prune -f && docker-compose build && docker-compose up -d
