FROM python:3.9

WORKDIR /app

COPY requirements.txt /app/requirements.txt
COPY attack_shared_wallet.py /app/attack_shared_wallet.py

RUN pip install -r requirements.txt

ENTRYPOINT ["python", "attack_shared_wallet.py"]