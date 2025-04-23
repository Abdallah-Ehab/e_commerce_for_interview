import 'package:e_commerce_flutter_project/core/utils/result.dart';

abstract class UseCase<T,Params>{
  Future<Result<T>> call(Params params);
}