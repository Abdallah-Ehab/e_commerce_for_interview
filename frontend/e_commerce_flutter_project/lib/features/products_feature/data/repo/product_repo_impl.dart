// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_project/core/utils/result.dart';
import 'package:e_commerce_flutter_project/features/products_feature/data/models/product_model.dart';
import 'package:e_commerce_flutter_project/features/products_feature/data/services/products_services.dart';
import 'package:e_commerce_flutter_project/features/products_feature/domain/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {

  ProductsServices productsServices;
  ProductRepoImpl({
    required this.productsServices,
  });

  @override
  Future<Result<List<Product>>> getAllProducts({required int pageNumber,required int limit})async {
    Result<Response> responseResult = await productsServices.getProducts(pageNumber:pageNumber, limit: limit);
    if(responseResult.error != null){
      return Result.failure(error: ServiceError(message: "message",statusCode: 400));
    }else{
      final products = responseResult.successData!.data['products'];
      return Result.success(successData: products.map<Product>((product) => Product.fromJson(product)).toList());
    }
  }
}
