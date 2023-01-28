import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yallabaity/application/app_prefs.dart';
import 'package:yallabaity/domain/repositories/ads_repo.dart';
import 'package:yallabaity/domain/repositories/cart_repo.dart';
import 'package:yallabaity/domain/repositories/categories_repo.dart';
import 'package:yallabaity/domain/repositories/cooks_repo.dart';
import 'package:yallabaity/domain/repositories/foods_repo.dart';
import 'package:yallabaity/domain/repositories/sizes_repo.dart';
import 'package:yallabaity/domain/repositories/user_repo.dart';
import 'package:yallabaity/domain/use_cases/ads_usecase.dart';
import 'package:yallabaity/domain/use_cases/cart_usescases.dart';
import 'package:yallabaity/domain/use_cases/cooks_usecase.dart';
import 'package:yallabaity/domain/use_cases/foods_usecases.dart';
import 'package:yallabaity/domain/use_cases/categories_usecases.dart';
import 'package:yallabaity/domain/use_cases/sizes_usecases.dart';
import 'package:yallabaity/domain/use_cases/user_usecases.dart';
import 'package:yallabaity/network_layer/data_sources/categories_local_datasource.dart';
import 'package:yallabaity/network_layer/data_sources/categories_remote_data_source.dart';
import 'package:yallabaity/network_layer/data_sources/cooks_local_datasource.dart';
import 'package:yallabaity/network_layer/data_sources/cooks_remote_datasource.dart';
import 'package:yallabaity/network_layer/data_sources/food_local_datasource.dart';
import 'package:yallabaity/network_layer/data_sources/food_remote_datasource.dart';
import 'package:yallabaity/application/network.dart';
import 'package:yallabaity/network_layer/data_sources/food_sizes_remote_datasource.dart';
import 'package:yallabaity/network_layer/data_sources/user_local_datasource.dart';
import 'package:yallabaity/network_layer/data_sources/user_remote_datasource.dart';
import 'package:yallabaity/network_layer/repositories/ads_repo_impl.dart';

import 'package:yallabaity/network_layer/repositories/categories_repo_impl.dart';
import 'package:yallabaity/network_layer/repositories/cooks_repo_impl.dart';
import 'package:yallabaity/network_layer/repositories/foods_repo_impl.dart';
import 'package:yallabaity/network_layer/repositories/sizes_repo_impl.dart';
import 'package:yallabaity/network_layer/repositories/user_repo_impl.dart';
import 'package:yallabaity/network_layer/services/network_services.dart';
import 'package:http/http.dart' as http;
import 'package:yallabaity/presentation/manager/bloc_sizes/sizes_bloc.dart';
import 'package:yallabaity/presentation/manager/cubit_cart_manager/cubit_cart_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_cooks_managers/cubit_cooks_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_food_operation_manager/cubit_food_operation_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_foods/foods_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_user_manager/cubit_user.dart';
import 'package:yallabaity/presentation/manager/google_apis_cubit_manager/google_apis_manager_cubit.dart';

import 'domain/repositories/google_apis_repo.dart';
import 'domain/use_cases/google_apis_usescases.dart';
import 'network_layer/data_sources/ads_local_datasource.dart';
import 'network_layer/data_sources/ads_remote_datasource.dart';
import 'network_layer/data_sources/cart_local_datasource.dart';
import 'network_layer/data_sources/cart_remote_datasource.dart';
import 'network_layer/data_sources/food_sizes_local_datasource.dart';
import 'network_layer/data_sources/google_apis_remote_datasource.dart';
import 'network_layer/repositories/cart_repo_impl.dart';
import 'network_layer/repositories/google_apis_repo_imple.dart';
import 'presentation/manager/cubit_ads_manager/cubit_ads_manager_cubit.dart';
import 'presentation/manager/cubit_categories/categories_manager_cubit.dart';
import 'presentation/manager/cubit_cook_foods_manager/cubit_cook_foods_manager_cubit.dart';

final GetIt getIt = GetIt.instance; // get instance from getIt

Future<void> init() async {
  /* features - categories feature  */
  /********************* app ******************************/
  getIt.registerLazySingleton<AppPrefs>(() => AppPrefs(preferences: getIt()));

  /********************* bloc ******************************/
  /*                                       categories cubit                                           */
  getIt.registerFactory<CategoriesManagerCubit>(() => CategoriesManagerCubit(categoriesUseCases: getIt()));
  getIt.registerFactory<SizesBloc>(() => SizesBloc(sizesUseCases: getIt()));
  /*                                       foods cubit                                              */
  getIt.registerFactory<FoodsManagerCubit>(() => FoodsManagerCubit(foodUseCases: getIt()));
  /*                                       foods cubit                                              */
  getIt.registerFactory<FoodOperationManagerCubit>(() => FoodOperationManagerCubit(foodsUseCase: getIt()));
  /*                                       user cubit                                               */
  getIt.registerFactory<UserCubit>(() => UserCubit(userUseCase: getIt(), appPrefs: getIt()));
  /*                                       ads cubit                                                */
  getIt.registerFactory<AdsManagerCubit>(() => AdsManagerCubit(adsUseCase: getIt()));
  /*                                       cooks cubit                                                */
  getIt.registerFactory<CooksManagerCubit>(() => CooksManagerCubit(cooksUseCase: getIt()));
  /*                                       cook foods cubit                                                */
  getIt.registerFactory<CookFoodsManagerCubit>(() => CookFoodsManagerCubit(foodsUseCase: getIt()));
  /*                                       cook foods cubit                                                */
  getIt.registerFactory<CartManagerCubit>(() => CartManagerCubit(cartUseCases: getIt()));

  /********************* use cases ******************************/
  /*                                       foods use case                                           */
  getIt.registerLazySingleton<FoodsUseCases>(() => FoodsUseCases(foodsRepo: getIt()));
  /*                                       categories use case                                       */
  getIt.registerLazySingleton<CategoriesUseCase>(() => CategoriesUseCase(categoriesRepo: getIt()));
  /*                                       sizes use case                                            */
  getIt.registerLazySingleton<SizesUseCase>(() => SizesUseCase(sizesRepo: getIt()));
  /*                                      users use case                                             */
  getIt.registerLazySingleton<UserUseCase>(() => UserUseCase(userRepo: getIt()));
  /*                                       ads use case                                              */
  getIt.registerLazySingleton<AdsUseCase>(() => AdsUseCase(adsRepo: getIt()));
  /*                                       cooks use case                                              */
  getIt.registerLazySingleton<CooksUseCase>(() => CooksUseCase(cooksRepo: getIt()));
  /*                                       cooks use case                                              */
  getIt.registerLazySingleton<CartUseCases>(() => CartUseCases(cartRepo: getIt()));

  /********************* data sources ******************************/
  /*                                       foods data sources                                         */
  getIt.registerLazySingleton<FoodsRemoteDataSource>(() => FoodRemoteWithHttp(networkService: getIt()));
  getIt.registerLazySingleton<FoodsLocalDataSource>(() => FoodsImplWithPrefs(preferences: getIt()));
  /*                                       categories data sources                                    */
  getIt.registerLazySingleton<CategoriesRemoteDataSource>(() => CategoriesImplWithHttp(networkService: getIt()));
  getIt.registerLazySingleton<CategoriesLocalDataSource>(() => CategoriesImplWithPrefs(preferences: getIt()));
  /*                                       sizes data sources                                         */
  getIt.registerLazySingleton<SizesRemoteDataSource>(() => SizesImplWithHttp(client: getIt()));
  getIt.registerLazySingleton<SizesLocalDataSource>(() => SizesImplWithPrefs(preferences: getIt()));
  /*                                       users data sources                                          */
  getIt.registerLazySingleton<UserRemoteDataSource>(() => UserImplWithHttp(networkService: getIt()));
  getIt.registerLazySingleton<UserLocalDataSource>(() => UserImplWithPrefs(preferences: getIt()));
  /*                                       ads data sources                                            */
  getIt.registerLazySingleton<AdsRemoteDataSource>(() => AdsImplWithHttp(networkService: getIt()));
  getIt.registerLazySingleton<AdsLocalDataSource>(() => AdsImplWithPrefs(preferences: getIt()));
  /*                                       cooks data sources                                            */
  getIt.registerLazySingleton<CooksRemoteDataSource>(() => CooksImplWithHttp(networkService: getIt()));
  getIt.registerLazySingleton<CooksLocalDataSource>(() => CooksImplWithPrefs(preferences: getIt()));
  /*                                       cooks data sources                                            */
  getIt.registerLazySingleton<CartRemoteDataSource>(() => CartImplWithHttp(networkService: getIt()));
  getIt.registerLazySingleton<CartLocalDataSource>(() => CartImplWithPrefs(preferences: getIt()));
  /********************* repos ******************************/
  /*                                       categories repo                                             */
  getIt.registerLazySingleton<CategoriesRepo>(
      () => CategoriesRepoImpl(categoriesRemoteDataSource: getIt(), categoriesLocalDataSource: getIt(), networkStatus: getIt()));
  /*                                       foods repo                                             */
  getIt.registerLazySingleton<FoodsRepo>(
      () => FoodRepoImpl(foodsRemoteDataSource: getIt(), foodsLocalDataSource: getIt(), networkStatus: getIt()));
  /*                                       sizes repo                                             */
  getIt.registerLazySingleton<SizesRepo>(
      () => SizesRepoImpl(sizesRemoteDataSource: getIt(), sizesLocalDataSource: getIt(), networkStatus: getIt()));
  /*                                       user repo                                             */
  getIt.registerLazySingleton<UserRepo>(
      () => UserRepoImpl(userRemoteDataSource: getIt(), userLocalDataSource: getIt(), networkStatus: getIt()));
  /*                                       ads repo                                             */
  getIt.registerLazySingleton<AdsRepo>(
      () => AdsRepoImpl(adsRemoteDataSource: getIt(), adsLocalDataSource: getIt(), networkStatus: getIt()));
  /*                                       cooks repo                                             */
  getIt.registerLazySingleton<CooksRepo>(
      () => CooksRepoImpl(cooksRemoteDataSource: getIt(), cooksLocalDataSource: getIt(), networkStatus: getIt()));
  /*                                       cooks repo                                             */
  getIt.registerLazySingleton<CartRepo>(
      () => CartRepoImpl(cartRemoteDataSource: getIt(), cartLocalDataSource: getIt(), networkStatus: getIt()));

  /********************* network ******************************/
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => NetworkService(client: getIt()));
  getIt.registerLazySingleton(() => Dio()); /*  core */
  getIt.registerLazySingleton<NetworkStatus>(() => NetworkStatusImpl(checker: getIt()));
  getIt.registerLazySingleton(() => InternetConnectionChecker());
  /********************* local ******************************/
  SharedPreferences preferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => preferences);
  /********************* google apis ******************************/

  /*data source*/
  getIt.registerLazySingleton<GoogleApisRemoteDataSource>(() => GoogleApisImplWithHttp(networkService: getIt()));
  /*repo*/
  getIt.registerLazySingleton<GoogleApisRepo>(() => GoogleApisRepoImpl(googleRemoteDataSource: getIt(), networkStatus: getIt()));
  /*use case*/
  getIt.registerLazySingleton<GoogleApisUseCases>(() => GoogleApisUseCases(googleApisRepo: getIt()));
  /*cubit*/
  getIt.registerLazySingleton<GoogleApisManagerCubit>(() => GoogleApisManagerCubit(googleApisUseCases: getIt()));
}
