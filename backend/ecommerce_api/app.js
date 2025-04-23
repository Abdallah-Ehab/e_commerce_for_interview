const express = require("express");
const dotenv = require("dotenv").config();
const { db_connect, seedData } = require("./config/db_connect");
const router = require("./routes/routes.js");
const bodyParser = require("body-parser");
const errorHandler = require("./middlewares/global_error_handler.js");

const app = express();
const port = process.env.PORT;

app.use(bodyParser.json());
app.use("/api/v1/", router);
app.use(errorHandler);

db_connect()
  .then(() => {
    return seedData();
  })
  .then(() => {
    app.listen(port, () => {
      console.log(`listening on port ${port}`);
    });
  })
  .catch((err) => {
    console.error("Failed to start the server:", err);
    process.exit(1);
  });