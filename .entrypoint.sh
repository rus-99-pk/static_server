#!/bin/bash

# Запуск SSH демона
/usr/sbin/sshd -D -e

# Удержание контейнера запущенным
tail -f /dev/null
