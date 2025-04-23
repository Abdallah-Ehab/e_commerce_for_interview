const { default: mongoose } = require("mongoose");


const category_schema = mongoose.Schema({
    name:{
        "type":String,
        "enum":[
            'Beauty',             'Fragrances',
            'Furniture',          'Groceries',
            'Home Decoration',    'Kitchen Accessories',
            'Laptops',            'Mens Shirts',
            'Mens Shoes',         'Mens Watches',
            'Mobile Accessories', 'Motorcycle',
            'Skin Care',          'Smartphones',
            'Sports Accessories', 'Sunglasses',
            'Tablets',            'Tops',
            'Vehicle',            'Womens Bags',
            'Womens Dresses',     'Womens Jewellery',
            'Womens Shoes',       'Womens Watches'
          ]
    },
    url:{
        "type":String,   
    }
})

const categoryModel = new mongoose.model("Category",product_category_schema);

module.exports = categoryModel;