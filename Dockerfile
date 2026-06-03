FROM python:3.10-slim

ENV PYTHONUNBUFFERED=1

# Instala SSH
RUN apt-get update && apt-get install -y openssh-server \
    && mkdir /var/run/sshd

# Configura senha root
RUN echo 'root:root' | chpasswd

# Permite login root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# IMPORTANTE: porta do SSH para Azure
EXPOSE 2222

# App
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

# ✅ Start correto do SSH + app
CMD ["/bin/sh", "-c", "/usr/sbin/sshd -D & gunicorn app:app --bind 0.0.0.0:${PORT:-8080} --workers 1 --threads 4 --timeout 120"]
