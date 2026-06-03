FROM python:3.10-slim

ENV PYTHONUNBUFFERED=1

# Instala SSH
RUN apt-get update && apt-get install -y openssh-server \
    && mkdir /var/run/sshd

# Define senha do root (para acesso SSH)
RUN echo 'root:root' | chpasswd

# Permitir login root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Porta do SSH
EXPOSE 2222

# Seu app
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

# Inicia SSH + sua aplicação
CMD service ssh start && gunicorn app:app --bind 0.0.0.0:${PORT:-8080} --workers 1 --threads 4 --timeout 120
