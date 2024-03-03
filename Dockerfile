FROM python:3.10

# poetry disable virtualenv creation
ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_CACHE_DIR='/var/cache/pypoetry' \
    POETRY_HOME='/usr/local'

# poetry installation
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && poetry --version

WORKDIR /app/

# caching dependencies
COPY ./poetry.lock ./pyproject.toml /app/

# install dependencies
RUN poetry install --no-interaction

# copy the rest of the files
COPY ./rinha_de_backend /app/

# run the application
EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--reload"]
