const mongoose = require("mongoose");
const ProductModel = require("../models/products/product_model");
const axios = require("axios");

const db_connect = ()=>{
    mongoose.connect(process.env.DB_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
    .then(() => console.log(`connected to mongodb ${mongoose.connection.db.databaseName}`))
    .catch((err) => console.error('Error connecting to MongoDB:', err));
}

const seedData = async()=>{
  try{
  const products = await ProductModel.find();
  if(products.length > 0){ 
    const response = await axios.get("https://dummyjson.com/products");
    const newProducts = response.data['products']
    await ProductModel.insertMany(newProducts);
    mongoose.connection.close();
  }
  }catch(e){
    console.error('Error seeding products:', error);
    mongoose.connection.close();
  }
}

module.exports = {db_connect, seedData};