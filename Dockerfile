FROM python:3.13-slim

WORKDIR /app

# No dependencies in the current python app, uncomment in case new dependencies are coming
# COPY requirements.txt /app/requirements.txt

# RUN python -m pip install \
#         --no-cache-dir \
#         --no-compile \
#         -r /app/requirements.txt \
#     && python -m pip check

# non-root execution.
RUN groupadd --system --gid 10001 admins \
    && useradd --system --uid 10001 \
       --gid 10001 --no-create-home app-admin

COPY --chown=10001:10001 app/app.py ./app.py

USER app-admin:admins

ENTRYPOINT ["python", "-u", "./app.py"]
