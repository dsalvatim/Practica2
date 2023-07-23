#!/bin/bash

# Ejecutar el playbook del webserver
ansible-playbook Playbook_webserver.yaml

# Ejecutar el playbook de kubernetes
ansible-playbook Playbook_redis.yaml
