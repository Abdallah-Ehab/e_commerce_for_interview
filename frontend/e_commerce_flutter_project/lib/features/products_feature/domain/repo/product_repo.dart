import 'package:e_commerce_flutter_project/core/utils/result.dart';
import 'package:e_commerce_flutter_project/features/products_feature/data/models/product_model.dart';

abstract class ProductRepo {

  Future<Result<List<Product>>> getAllProducts({required int pageNumber,required int limit});
  
}