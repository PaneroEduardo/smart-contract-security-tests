FROM python:3.9

WORKDIR /app

COPY requirements.txt /app/requirements.txt
COPY populate_bank.py /app/populate_bank.py

RUN pip install -r requirements.txt

ENTRYPOINT ["python", "populate_bank.py"]