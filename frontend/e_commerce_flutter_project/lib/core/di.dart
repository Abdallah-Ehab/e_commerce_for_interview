// this file is for dependency injection:
import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_project/core/network/clients/authentication_client.dart';
import 'package:e_commerce_flutter_project/core/network/clients/dio_client.dart';
import 'package:e_commerce_flutter_project/core/network/clients/product_client.dart';
import 'package:e_commerce_flutter_project/core/network/interceptors/refresh_token_interceptor.dart';
import 'package:e_commerce_flutter_project/features/authentication/data/repo/auth_repo_impl.dart';
import 'package:e_commerce_flutter_project/features/authentication/data/services/auth_services.dart';
import 'package:e_commerce_flutter_project/features/authentication/domain/repo/auth_repo.dart';
import 'package:e_commerce_flutter_project/features/authentication/domain/usecases/login_use_case.dart';
import 'package:e_commerce_flutter_project/features/authentication/domain/usecases/register_use_case.dart';
import 'package:e_commerce_flutter_project/features/ensure_logged_in_feature/cubit/ensure_logged_in_cubit.dart';
import 'package:e_commerce_flutter_project/features/products_feature/data/repo/product_repo_impl.dart';
import 'package:e_commerce_flutter_project/features/products_feature/data/services/products_services.dart';
import 'package:e_commerce_flutter_project/features/products_feature/domain/repo/product_repo.dart';
import 'package:e_commerce_flutter_project/features/products_feature/domain/usecases/get_all_products_use_case.dart';
import 'network/local_data_source/token_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Storage
  getIt.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  
  // Utility Classes
  getIt.registerLazySingleton<TokenManager>(() => TokenManager(storage: getIt<FlutterSecureStorage>()));
  
  // Network
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerFactory<AuthenticationClient>(() => AuthenticationClient(interceptors: []));
  getIt.registerFactory<ProductClient>(() => ProductClient(interceptors: [RefreshTokenInterceptor(authRepo: getIt<AuthRepo>(), dio: getIt<Dio>(),ensureLoggedInCubit: EnsureLoggedInCubit(authRepo: getIt<AuthRepo>()))]));
  
  // Services
  getIt.registerLazySingleton<AuthServices>(() => AuthServices(authClient: getIt<AuthenticationClient>()));
  getIt.registerLazySingleton<ProductsServices>(() => ProductsServices(client: getIt<DioClient>()));
  // Repositories
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
        authServices: getIt<AuthServices>(),
        tokenManager: getIt<TokenManager>(),
      ));

  getIt.registerLazySingleton<ProductRepo>(()=>ProductRepoImpl(
        productsServices: getIt<ProductsServices>(),
      ));
  
  // Use Cases
  getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(authRepo: getIt<AuthRepo>()));
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(authRepo: getIt<AuthRepo>()));
  getIt.registerLazySingleton<GetAllProductsUseCase>(() => GetAllProductsUseCase(productRepo: getIt<ProductRepo>()));
}