FROM python:3.11-slim-buster
WORKDIR /app
COPY . /app

# RUN apt update -y && apt install awscli -y

# RUN apt-get update && pip install -r requirements.txt

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
       curl \
       unzip \
       ca-certificates \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt
CMD ["python3", "app.py"]