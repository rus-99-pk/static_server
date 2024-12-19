#!/bin/bash
#set -xe

# Устанавливаем ansible на уровне Python для избежания разлчных системных ошибок
python3 -m pip install ansible

# Читаем пароль из файла и экспортируем как переменную окружения
source .env

# Собираем образ и запускаем контейнер
docker compose up -d

# Используем sed для подстановки пароля и SSH-порта
sed -i "s/ansible_port= ansible_ssh_pass= ansible_become_pass=/ansible_port=${SSH_PORT} ansible_ssh_pass=${MANAGE_PWD} ansible_become_pass=${MANAGE_PWD}/" configure_infra/inventory/hosts

# Запускаем playbook
ansible-playbook configure_infra/playbook.yaml -i configure_infra/inventory/hosts && \
    echo -e "Все готово ✅\nМожно открывать http://localhost/ 😉"