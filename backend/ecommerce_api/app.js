const express = require("express")
const dotenv = require("dotenv").config()
const db_connect = require("./config/db_connect")
const router = require("./routes/user_routes.js")
const bodyParser = require("body-parser")
const errorHandler = require("./middlewares/global_error_handler.js")

const app = express()


db_connect()

const port = process.env.PORT

app.use(bodyParser.json())
app.use("/api/v1/",router)


app.use(errorHandler)

app.listen(port,()=>{
    console.log("listening")
})