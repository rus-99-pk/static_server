# Используем базовый образ Ubuntu (убедитесь, что выбранная версия доступна)
FROM ubuntu:24.04

# Определяем переменные окружения
ARG INSTALL_PKG \
    MANAGE_USER \
    MANAGE_PWD

# Обновление и установка необходимых пакетов
RUN apt-get update && \
    apt-get install -y --no-install-recommends ${INSTALL_PKG} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /run/sshd

# Создаем manage-пользователя
RUN useradd -m -s /bin/bash -G sudo ${MANAGE_USER} && \
    echo "${MANAGE_USER}:${MANAGE_PWD}" | chpasswd

# Открываем порты SSH и HTTP
EXPOSE 22 80

# Копирование скрипта для запуска
COPY .entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Команда для запуска sshd
CMD ["/entrypoint.sh"]
