import express from 'express';

const app = express();

app.get('/', (req, res) => {
  res.send('Hello CS Tech Week - Nottingham');
});

const PORT = 3000;
const server = app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

export { app, server };
