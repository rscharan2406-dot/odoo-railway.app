FROM odoo:18

USER root
RUN apt-get update && apt-get install -y netcat-openbsd

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
