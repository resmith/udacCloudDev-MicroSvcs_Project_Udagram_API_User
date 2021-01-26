import cors from 'cors';
import express from 'express';
import {sequelize} from './sequelize';

import {IndexRouter} from './controllers/v0/index.router';

import bodyParser from 'body-parser';
import {config} from './config/config';
import { V0_USER_MODELS} from './controllers/v0/model.index';


(async () => {
  console.log("Server.ts start")

  console.log("Connect to host:", process.env.POSTGRES_HOST)
  console.log("Connect to db:", process.env.POSTGRES_DB)

  console.log("addModels V0_USER_MODELS")
  await sequelize.addModels(V0_USER_MODELS);

  console.log("sequelize sync")
  await sequelize.sync();

  console.log("Start express")
  console.log("process.env.PORT:", process.env.PORT)
  const app = express();

  const port = process.env.PORT || 8080;

  app.use(bodyParser.json());

  app.use(cors({
    allowedHeaders: [
      'Origin', 'X-Requested-With',
      'Content-Type', 'Accept',
      'X-Access-Token', 'Authorization',
    ],
    methods: 'GET,HEAD,OPTIONS,PUT,PATCH,POST,DELETE',
    origin: config.url,
  }));

  app.use('/api/v0/', IndexRouter);

  // Root URI call
  app.get( '/', async ( req, res ) => {
    res.send( '/api/v0/' );
  } );


  // Start the Server
  app.listen( port, () => {
    console.log( `server running ${config.url}` );
    console.log( `press CTRL+C to stop server` );
  } );
})();
