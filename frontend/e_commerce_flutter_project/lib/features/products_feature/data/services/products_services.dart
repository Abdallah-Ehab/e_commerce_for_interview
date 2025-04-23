import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_project/core/constants.dart';
import 'package:e_commerce_flutter_project/core/network/error/handle_dio_exception.dart';
import 'package:e_commerce_flutter_project/core/utils/result.dart';
import '../../../../core/network/clients/dio_client.dart';

class ProductsServices {
  DioClient client;
  ProductsServices({required this.client});
  

  Future<Result<Response>> getProducts({required int pageNumber,required int limit}) async {
    try {
      final response = await client.get(path:Constants.getAllProductsEndpoint,queryParameters: {
        'page': pageNumber,
        'limit': limit,
      });
      return Result.success(successData:response);
    } on DioException catch (e) {
      if(e.response != null){
        return Result.failure(error: ServiceError(message: e.response!.data['message'],statusCode: e.response!.statusCode));
      }
      return handleDioExceptions(e,'getProducts', 'ProductsServices');
    }catch(e){
      return Result.failure(error: ServiceError(message: "unkown error from products services getProducts"));
    }
  }
}

