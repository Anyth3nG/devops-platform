const express = require('express');
const client = require('prom-client');

const app = express();
const register = new client.Registry();

client.collectDefaultMetrics({ register });

app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

app.listen(3000, () => {
  console.log('App running on port 3000');
});