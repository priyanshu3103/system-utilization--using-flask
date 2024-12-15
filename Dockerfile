#----------------Stage1----------
FROM python:3.9 AS builder

WORKDIR /flaskapp

COPY . /flaskapp

RUN pip install -r requirements.txt



#---------------Stage2-----------------
FROM python:3.9-slim

WORKDIR /flaskapp

COPY --from=builder /usr/local/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/

COPY --from=builder /flaskapp /flaskapp

CMD ["python", "flaskapp.py"]
