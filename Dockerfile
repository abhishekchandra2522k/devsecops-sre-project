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

RUN python -m compileall -q /app

USER app-admin:admins

HEALTHCHECK --interval=30s --timeout=3s --start-period=15s --retries=3 \
    CMD ["python", "-c", "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8080/healthcheck', timeout=2)"]


ENTRYPOINT ["python", "-u", "./app.py"]
