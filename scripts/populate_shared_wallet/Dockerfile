FROM python:3.9

WORKDIR /app

COPY requirements.txt /app/requirements.txt
COPY populate_shared_wallet.py /app/populate_shared_wallet.py

RUN pip install -r requirements.txt

ENTRYPOINT ["python", "populate_shared_wallet.py"]