FROM node:24-slim AS builder

ARG RUNNER_VERSION=2.328.0

WORKDIR /opt/action-runner

COPY ./entrypoint.sh ./entrypoint.sh

RUN apt-get update \
  && apt-get -qq install -y curl libicu-dev \
  && rm -rf /var/lib/apt/lists/* \
  && cd /opt/action-runner \
  && curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
  && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
  && rm -f ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN groupadd -g 1100 action-runner \
  && useradd -m -s /bin/bash -u 1100 -g 1100 action-runner \
  && chown -R action-runner:action-runner /opt/action-runner \
  && chmod +x /opt/action-runner/run.sh \
  && chmod +x /opt/action-runner/entrypoint.sh

USER action-runner

ENTRYPOINT ["./entrypoint.sh"]

CMD ["./run.sh"]
