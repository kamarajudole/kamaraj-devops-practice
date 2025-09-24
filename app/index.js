// simple node express app
const express = require('express');
const os = require('os');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({
    message: 'Hello from DevOps practice app',
    host: os.hostname(),
    time: new Date().toISOString()
  });
});

app.get('/health', (req, res) => res.sendStatus(200));

app.listen(PORT, () => console.log(`App listening on ${PORT}`));
