/* eslint-disable */
const { JsonLogger } = require('@dmamontov/graphql-mesh-json-logger');
const { DefaultLogger } = require('@graphql-mesh/utils');

const name = process.env.LOGGER_NAME || 'graphql-mesh';

const logger = process.env.LOGGER === 'json' ? new JsonLogger(name) : new DefaultLogger(name);

module.exports = logger;