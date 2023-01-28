import 'package:flutter/material.dart';
import 'package:yallabaity/presentation/pages/about_us_screen.dart';
import 'package:yallabaity/presentation/pages/account_info_screen.dart';
import 'package:yallabaity/presentation/pages/add_food_screen.dart';
import 'package:yallabaity/presentation/pages/address_details.dart';
import 'package:yallabaity/presentation/pages/cart_screen.dart';
import 'package:yallabaity/presentation/pages/category_screen.dart';
import 'package:yallabaity/presentation/pages/checkout_screen.dart';
import 'package:yallabaity/presentation/pages/client_apply_screen.dart';
import 'package:yallabaity/presentation/pages/home_screen.dart';
import 'package:yallabaity/presentation/pages/client_location_screen.dart';
import 'package:yallabaity/presentation/pages/client_profile_screen.dart';
import 'package:yallabaity/presentation/pages/cook_profile_screen.dart';
import 'package:yallabaity/presentation/pages/done_screen.dart';
import 'package:yallabaity/presentation/pages/food_details_screen.dart';
import 'package:yallabaity/presentation/pages/login_screen.dart';
import 'package:yallabaity/presentation/pages/my_foods_screen.dart';
import 'package:yallabaity/presentation/pages/orders_history_screen.dart';
import 'package:yallabaity/presentation/pages/provider_apply_screen.dart';
import 'package:yallabaity/presentation/pages/provider_orders_screen.dart';
import 'package:yallabaity/presentation/pages/provider_profile_screen.dart';
import 'package:yallabaity/presentation/pages/saved_screen.dart';
import 'package:yallabaity/presentation/pages/see_all_screen.dart';
import 'package:yallabaity/presentation/pages/get_started_screen.dart';
import 'package:yallabaity/splash_screen.dart';
import 'package:yallabaity/presentation/pages/verification_screen.dart';
import 'package:yallabaity/presentation/pages/wallet_screen.dart';

import '../pages/test.dart';

class Routes {
  Routes._internal();
  static const String getStartedRoute = "/get started";
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String clientApplyRoute = "/register";
  static const String forgetPasswordRoute = "/forget";
  static const String mainRoute = "/main";
  static const String homeRoute = "/home";
  static const String cartRoute = "/cart";
  static const String foodDetailsRoute = "/foodDetails";
  static const String clientLocationRoute = "/my location";
  static const String verificationRoute = "/verification";
  static const String categoryRoute = "/category";
  static const String addFoodRoute = "/add food";
  static const String aboutUsRoute = "/about us";
  static const String seeAllRoute = "/see all";
  static const String clientProfileRoute = "/client profile";
  static const String ordersHistoryRoute = "/orders history";
  static const String savedRoute = "/saved";
  static const String accountInfoRoute = "/account info";
  static const String addressDetailRoute = "/address details";
  static const String checkoutRoute = "/checkout";
  static const String doneRoute = "/done";
  static const String cookProfileRoute = "/cook profile";
  static const String providerApplyRoute = "/provider apply";
  static const String providerOrdersRoute = "/provider orders";
  static const String providerProfileRoute = "/provider profile ";
  static const String walletRoute = "/wallet ";
  static const String myFoodsRoute = "/my foods ";
  static const String myTestRoute = "/test ";
}

class RouteGenerator {
  RouteGenerator._internal();
  static Route<dynamic>? getRoute(RouteSettings routeSettings) {
    debugPrint(routeSettings.name);
    switch (routeSettings.name) {
      case Routes.getStartedRoute:
        return pageFadeTransition(widget: const GetStartedScreen(), routeSettings: routeSettings);
         case Routes.splashRoute:
        return pageFadeTransition(widget: SplashScreen(), routeSettings: routeSettings);
      case Routes.loginRoute:
        return pageFadeTransition(widget: LoginScreen(), routeSettings: routeSettings);
      case Routes.homeRoute:
        return pageFadeTransition(widget:  HomeScreen(), routeSettings: routeSettings);
      case Routes.cartRoute:
        return pageFadeTransition(widget: CartScreen(), routeSettings: routeSettings);
      case Routes.foodDetailsRoute:
        return pageFadeTransition(widget: FoodDetailsScreen(), routeSettings: routeSettings);
      case Routes.clientLocationRoute:
        return pageFadeTransition(widget: ClientLocationScreen(), routeSettings: routeSettings);
      case Routes.clientApplyRoute:
        return pageFadeTransition(widget: ClientApplyScreen(), routeSettings: routeSettings);
      case Routes.verificationRoute:
        return pageFadeTransition(widget: VerificationScreen(), routeSettings: routeSettings);
      case Routes.categoryRoute:
        return pageFadeTransition(widget: const CategoryScreen(), routeSettings: routeSettings);
      case Routes.addFoodRoute:
        return pageFadeTransition(widget: AddFoodScreen(), routeSettings: routeSettings);
      case Routes.aboutUsRoute:
        return pageFadeTransition(widget: AboutUsScreen(), routeSettings: routeSettings);
      case Routes.seeAllRoute:
        return pageFadeTransition(widget: SeeAllScreen(), routeSettings: routeSettings);
      case Routes.clientProfileRoute:
        return pageBottomLeftToTopRightTransition(widget: const ClientProfileScreen(), routeSettings: routeSettings);
      case Routes.ordersHistoryRoute:
        return pageFadeTransition(widget: OrdersHistoryScreen(), routeSettings: routeSettings);
      case Routes.accountInfoRoute:
        return pageFadeTransition(widget: AccountInfoScreen(), routeSettings: routeSettings);
      case Routes.savedRoute:
        return pageFadeTransition(widget: SavedScreen(), routeSettings: routeSettings);
      case Routes.addressDetailRoute:
        return pageFadeTransition(widget: AddressDetailsScreen(), routeSettings: routeSettings);
      case Routes.checkoutRoute:
        return pageFadeTransition(widget: CheckOutScreen(), routeSettings: routeSettings);
      case Routes.doneRoute:
        return pageFadeTransition(widget: DoneScreen(), routeSettings: routeSettings);
      case Routes.cookProfileRoute:
        return pageFadeTransition(widget: CookProfileScreen(cook: null), routeSettings: routeSettings);
      case Routes.providerApplyRoute:
        return pageFadeTransition(widget: const ProviderApplyScreen(), routeSettings: routeSettings);
      case Routes.providerOrdersRoute:
        return pageFadeTransition(widget: ProviderOrdersScreen(), routeSettings: routeSettings);
      case Routes.providerProfileRoute:
        return pageFadeTransition(widget: ProviderProfileScreen(), routeSettings: routeSettings);
      case Routes.walletRoute:
        return pageFadeTransition(widget: WalletScreen(), routeSettings: routeSettings);
    case Routes.myTestRoute:
        return pageFadeTransition(widget: TestScreen(), routeSettings: routeSettings);
      case Routes.myFoodsRoute:
        return pageFadeTransition(widget: MyFoodScreen(), routeSettings: routeSettings);
    }
    return null;
  }

  static pageFadeTransition({required Widget widget, required RouteSettings routeSettings}) => PageRouteBuilder(
        settings: routeSettings,
        transitionDuration: const Duration(milliseconds: 100),
        reverseTransitionDuration: const Duration(milliseconds: 50),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          Animation<double> opacity =
              animation.drive(Tween(begin: 0.0, end: 1.0)..chain(CurveTween(curve: Curves.linearToEaseOut)));
          return FadeTransition(
            opacity: opacity,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) => widget,
      );
  static pageBottomLeftToTopRightTransition({required Widget widget, required RouteSettings routeSettings}) => PageRouteBuilder(
        transitionDuration: const Duration(seconds: 1),
        reverseTransitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          Animation<Offset> position = animation.drive(
              Tween(begin: const Offset(-0.5, 1), end: const Offset(0, 0))..chain(CurveTween(curve: Curves.linearToEaseOut)));
          return SlideTransition(
            position: position,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) => widget,
      );
}
