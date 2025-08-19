FROM python:3.13.7-slim

ENV VIRTUAL_ENV=/opt/venv

WORKDIR /app
ENV PYTHONPATH="${PYTHONPATH}:/app"
COPY . .
RUN python3 -m venv ${VIRTUAL_ENV}
ENV PATH="${VIRTUAL_ENV}/bin:$PATH"
RUN python3 -m pip install -r ./buildserver/requirements.txt

WORKDIR /app/buildserver
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

