// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_flutter_project/core/utils/result.dart';
import 'package:e_commerce_flutter_project/core/utils/use_case.dart';
import 'package:e_commerce_flutter_project/features/products_feature/data/models/product_model.dart';
import 'package:e_commerce_flutter_project/features/products_feature/domain/repo/product_repo.dart';

class GetAllProductsUseCase implements UseCase<List<Product>, GetProductParams> {

  final ProductRepo productRepo;
  
  const GetAllProductsUseCase({
    required this.productRepo,
  });


  @override
  Future<Result<List<Product>>> call(GetProductParams params)async{
      Result<List<Product>> result = await productRepo.getAllProducts(pageNumber: params.pageNumber, limit: params.limit);
      if(result.error != null){
        return Result.failure(error: result.error!);
  }else{
        return Result.success(successData: result.successData!);
      }
  }
}

class GetProductParams{
final int pageNumber;
final int limit;
GetProductParams({required this.pageNumber,required this.limit});
}
