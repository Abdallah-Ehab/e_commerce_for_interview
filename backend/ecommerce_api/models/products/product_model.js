const { default: mongoose } = require("mongoose");

const product_schema = mongoose.Schema({
    title:{
        "type": String,
        "required":true
    },
    price:{
        "type":number,
        "required":true
    },
    rating:{
        "type":Number,
        "min": 1,
        "max":5
    },
    description:{
        "type":String,
        "required":false
    },
    category:{
        "type":mongoose.Schema.Types.ObjectId,
        "ref":"Category",
        "required": true
    },
    thumbnail:{
        "type":String,
        "required": true
    },
    images:{
        "type":[String],
        "required":true,
    },
    reviews:[
        {
            reviewerName: {"type":String,},
            rating:{"type":Number, "min" : 1, "max" : 5},
            Comment: {"type":[String],"required":false},
            createdAt: { type: Date, default: Date.now }
        }
    ],
    "dimensions": {
        "width": Number,
        "height": Number,
        "depth": Number
      },
},{timestamps: true})


const ProductModel = new mongoose.model("Products",product_schema);


module.exports = ProductModel