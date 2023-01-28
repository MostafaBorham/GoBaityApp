import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:toast/toast.dart';
import 'package:yallabaity/application/app_localization.dart';
import 'package:yallabaity/application/app_prefs.dart';
import 'package:yallabaity/network_layer/models/data_models/foods_get_params_model.dart';
import 'package:yallabaity/presentation/manager/bloc_sizes/sizes_bloc.dart';
import 'package:yallabaity/presentation/manager/cubit_cart_manager/cubit_cart_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_categories/categories_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_cook_foods_manager/cubit_cook_foods_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_food_operation_manager/cubit_food_operation_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_food_sizes_listview/food_sizes_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_foods/foods_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_user_manager/cubit_user.dart';
import 'package:yallabaity/presentation/manager/drop_down_manager_cubit/drop_down_cubit.dart';
import 'package:yallabaity/presentation/manager/google_apis_cubit_manager/google_apis_manager_cubit.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';
import 'package:yallabaity/presentation/resources/theme_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'presentation/manager/cubit_ads_manager/cubit_ads_manager_cubit.dart';
import 'presentation/manager/cubit_cooks_managers/cubit_cooks_manager_cubit.dart';
import 'presentation/resources/strings_manager.dart';

class GoBaityApp extends StatelessWidget {
  const GoBaityApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('current local= ${context.locale.languageCode}');
    di.getIt<AppPrefs>().isAppEnglish? context.setLocale(AppLocalization.englishLocale) :context.setLocale(AppLocalization.arabicLocale);
    AppLocalization.setApiLocalCode(context.locale.languageCode);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    /*prevent device orientation changes and force portrait?*/
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.getIt<SizesBloc>()..add(GetSizesEvent())),
        BlocProvider(create: (context) => DropDownCubit()),
        BlocProvider(create: (context) => FoodSizesMangerCubit()),
        BlocProvider(create: (context) => di.getIt<UserCubit>()..getUser()),
        BlocProvider(create: (context) => di.getIt<FoodsManagerCubit>()..getFoods(foodGetParams: FoodsGetParamsModel())),
        BlocProvider(create: (context) => di.getIt<CookFoodsManagerCubit>()),
        BlocProvider(create: (context) => di.getIt<FoodOperationManagerCubit>()),
        BlocProvider(create: (context) => di.getIt<CategoriesManagerCubit>()..getCategories()),
        BlocProvider(create: (context) => di.getIt<AdsManagerCubit>()..getAds()),
        BlocProvider(create: (context) => di.getIt<CooksManagerCubit>()..getCooks()),
        BlocProvider(create: (context) => di.getIt<CartManagerCubit>()),
        BlocProvider(create: (context) => GoogleApisManagerCubit(googleApisUseCases: di.getIt())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getTheme(),
        title: AppStrings.translate(AppStrings.appName),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
