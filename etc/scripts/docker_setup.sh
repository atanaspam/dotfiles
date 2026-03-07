#!/bin/bash

docker mcp server enable terraform
docker mcp server enable grafana # Requires manual configuration
docker mcp server enable obsidian # Requires manual configuration
docker mcp client connect claude-code
docker mcp gateway run
