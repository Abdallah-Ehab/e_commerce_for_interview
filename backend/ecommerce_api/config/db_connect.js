const mongoose = require("mongoose")


const db_connect = ()=>{
    mongoose.connect(process.env.DB_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
    .then(() => console.log(`connected to mongodb ${mongoose.connection.db.databaseName}`))
    .catch((err) => console.error('Error connecting to MongoDB:', err));
}

module.exports = db_connect