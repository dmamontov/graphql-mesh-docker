FROM node:20-buster-slim

ARG GIT_HASH="latest"
ARG GIT_BRANCH="unknown"
ARG GIT_TAG="unknown"
ARG BUILD_NUMBER="unknown"
ARG BUILD_DATE="unknown"

ENV YARN_CACHE_FOLDER=/root/.yarn \
    NODE_TLS_REJECT_UNAUTHORIZED=0 \
    LOGGER=json \
    GIT_BRANCH=${GIT_BRANCH} \
    GIT_TAG=${GIT_TAG} \
    GIT_HASH=${GIT_HASH} \
    BUILD_NUMBER=${BUILD_NUMBER} \
    BUILD_DATE=${BUILD_DATE} \
    APP_VERSION=release-${GIT_HASH}

WORKDIR /work

COPY . .
COPY ./docker-cmd.sh /usr/bin/docker-cmd.sh

RUN chmod +x /usr/bin/docker-cmd.sh

RUN yarn install --frozen-lockfile

RUN cp /work/node_modules/@dmamontov/graphql-mesh-resolve-to-by-delegate-transform/esm/resolve-to-by-directive.graphql /work/directives \
    &&  cp /work/node_modules/@dmamontov/graphql-mesh-public-schema-plugin/esm/private-directive.graphql /work/directives \
    &&  cp /work/node_modules/@dmamontov/graphql-mesh-constraint-plugin/esm/constraint-directive.graphql /work/directives

EXPOSE 8000

CMD if [ -f "/usr/bin/docker-cmd.sh" ]; then sh /usr/bin/docker-cmd.sh; fi && yarn dev
