import request from 'supertest';
import { expect } from 'chai';
import app from '../app.mjs';

describe('GET /', () => {
  it('should return "Hello Nottingham"', async () => {
    const res = await request(app).get('/');
    expect(res.text).to.equal('Hello Nottingham');
  });
});

