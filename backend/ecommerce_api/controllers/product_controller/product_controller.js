const asyncHandler = require("../../config/async_handler");
const ProductModel = require("../../models/products/product_model");

exports.getAllProducts = asyncHandler(async(req,res,next)=>{
    const { page = 1, limit = 10,sort, category, price_min, price_max, fields } = req.query;
    const query = {};

    const pageNum = parseInt(page);
    const limitNum = parseInt(limit);
    const skipNum = (pageNum - 1) * limitNum;

    if (category) {
      query.category = category;
    }

    if (price_min || price_max) {
      query.price = {};
      if (price_min) query.price.$gte = Number(price_min);
      if (price_max) query.price.$lte = Number(price_max);
    }

    // Sorting
  if (sort) {
    const sortOptions = {};
    const sortFields = sort.split(','); //price:asc,discount:desc => [price:asc,discount:desc]
    sortFields.forEach((field) => {
      const [key, direction] = field.split(':'); //[price:asc,discount:desc] => {price:1,discount:-1}
      sortOptions[key] = direction === 'desc' ? -1 : 1; 
    });
    mongooseQuery = mongooseQuery.sort(sortOptions); 
  }

   
    let mongooseQuery = Product.find(query)
      .skip(skipNum) 
      .limit(limitNum);

    if (fields) {
      const selectedFields = fields.split(',').join(' ');
      mongooseQuery = mongooseQuery.select(selectedFields);
    }


    const allProducts = await mongooseQuery;
    if(allProducts.length > 0){
        res.status(200).json({
            status:"success",
            products:allProducts
        })
    }else{
        res.status(404).json({
            status:"failed",
            message :"error getting products"
        })
    }
})