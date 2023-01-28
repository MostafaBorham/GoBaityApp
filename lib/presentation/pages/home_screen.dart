import 'package:animations/animations.dart';
import 'dart:developer' as developer;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:yallabaity/application/app_api_constants/api_constants.dart';
import 'package:yallabaity/application/app_api_constants/sorting_constants.dart';
import 'package:yallabaity/application/app_constants/app_constants.dart';
import 'package:yallabaity/application/utils.dart';
import 'package:yallabaity/domain/entities/requests_entites/category_entity.dart';
import 'package:yallabaity/domain/entities/requests_entites/food_entity.dart';
import 'package:yallabaity/network_layer/models/data_models/ad_model.dart';
import 'package:yallabaity/network_layer/models/data_models/cook_get_params_model.dart';
import 'package:yallabaity/network_layer/models/data_models/cook_model.dart';
import 'package:yallabaity/network_layer/models/data_models/favourite_model.dart';
import 'package:yallabaity/network_layer/models/data_models/food_model.dart';
import 'package:yallabaity/network_layer/models/data_models/foods_get_params_model.dart';
import 'package:yallabaity/network_layer/models/data_models/user_model.dart';
import 'package:yallabaity/presentation/items/drawer_items.dart';
import 'package:yallabaity/presentation/manager/cubit_ads_manager/cubit_ads_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_categories/categories_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_cook_foods_manager/cubit_cook_foods_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_cooks_managers/cubit_cooks_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_foods/foods_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_user_manager/cubit_user.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/pages/about_us_screen.dart';
import 'package:yallabaity/presentation/pages/category_screen.dart';
import 'package:yallabaity/presentation/pages/cook_profile_screen.dart';
import 'package:yallabaity/presentation/pages/saved_screen.dart';
import 'package:yallabaity/presentation/widgets/category_item.dart';
import 'package:yallabaity/presentation/widgets/chief_item.dart';
import 'package:yallabaity/presentation/widgets/circular_skeleton.dart';
import 'package:yallabaity/presentation/widgets/custom_circular_progressbar.dart';
import 'package:yallabaity/presentation/widgets/custom_data_button.dart';
import 'package:yallabaity/presentation/widgets/custom_drawer.dart';
import 'package:yallabaity/presentation/widgets/favourite_widget.dart';
import 'package:yallabaity/presentation/widgets/gradient_circular_progress_indicator.dart';
import 'package:yallabaity/presentation/widgets/icon_button.dart';
import 'package:yallabaity/presentation/widgets/mycart.dart';
import 'package:yallabaity/presentation/widgets/food_item.dart';
import 'package:yallabaity/presentation/widgets/no_foods_ui.dart';
import 'package:yallabaity/presentation/widgets/rectangle_skeleton.dart';
import 'package:yallabaity/presentation/widgets/search.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/horizontal_listview.dart';
import 'package:yallabaity/presentation/widgets/sections.dart';
import 'package:yallabaity/presentation/widgets/custom_appbar.dart';
import 'package:flutter/src/widgets/transitions.dart' as transition;
import 'package:yallabaity/presentation/widgets/slider_with_dots.dart';
import 'food_details_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yallabaity/injection_container.dart' as di;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int adSliderImage = 0;
  bool isProvider = false;
  bool isFavourite = false;
  List<AdsModel> ads = [];
  List<CookModel> cooks = [];
  FavouriteModel favouriteModel=FavouriteModel();
  final _scrollController = ScrollController();

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  List<CategoryEntity>? categories;
  List<FoodEntity>? foods = [];
  int selectedFoodFavouriteIndex = 0;
  int? selectedFavouriteFoodId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.hideKeyboard();
      },
      child: Scaffold(
        key: key,
        appBar: _buildCustomAppBar(),
        drawer: _buildCustomDrawer(),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context,state){
            if(state is AlreadyLoggedInState){
              favouriteModel.userId=state.user.userId;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(top: AppHeight.s10 * Constants.height),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    child: Column(
                      //set widgets vertically
                      children: [
                        SizedBox(height: AppHeight.s60 * Constants.height),
                        if (isProvider)
                          Column(
                            //set widgets vertically
                            children: [
                              SizedBox(
                                height: AppHeight.s20 * Constants.height,
                              ),
                              Text(
                                'You Have New Orders',
                                style: getSemiBoldStyle(
                                    fontSize: AppWidth.s18 * Constants.width,
                                    color: ColorsManager.maximumPurple),
                              ),
                              SizedBox(
                                height: AppHeight.s14 * Constants.height,
                              ),
                              CustomDataButton(
                                  text: 'View orders',
                                  suffix: SvgPicture.asset(
                                    AssetsManager.arrow,
                                    color: ColorsManager.white,
                                  )),
                            ],
                          ),
                        SizedBox(height: AppHeight.s22 * Constants.height),
                        _buildCategories(),
                        SizedBox(
                          height: AppHeight.s22 * Constants.height,
                        ),
                        _buildSeparator(),
                        SizedBox(
                          height: AppHeight.s22 * Constants.height,
                        ),
                        _buildAdsSlider(),
                        SizedBox(
                          height: AppHeight.s22 * Constants.height,
                        ),
                        _buildSeparator(),
                        SizedBox(
                          height: AppHeight.s13 * Constants.height,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants.margin),
                          child: SectionName(
                            title: 'Near You',
                            subtitle: 'See All',
                            onTap: () {
                              Navigator.pushNamed(context, Routes.seeAllRoute);
                            },
                          ),
                        ),
                        SizedBox(
                          height: AppHeight.s10 * Constants.height,
                        ),
                        _buildFoods(),
                        SizedBox(
                          height: AppHeight.s22 * Constants.height,
                        ),
                        _buildSeparator(),
                        SizedBox(
                          height: AppHeight.s22 * Constants.height,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants.margin),
                          child: SectionName(
                            title: 'Featured Cooks',
                          ),
                        ),
                        SizedBox(
                          height: AppHeight.s15 * Constants.height,
                        ),
                        _buildRatedCooks(),
                        SizedBox(
                          height: AppHeight.s50 * Constants.height,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.margin,
                    ),
                    child: Search(
                      hintText: 'Search foods, Cooks',
                      color: ColorsManager.cultured,
                      onChanged: (keySearch) async {
                        _scrollController.animateTo(Constants.height * 0.5,
                            duration: Duration(milliseconds: Constants.d2),
                            curve: Curves.linear);
                        await FoodsManagerCubit.getFoodsEvent(context,
                            foodGetParams: FoodsGetParamsModel(
                              categoryId: 1, //category id
                              page: 0, // start from page 0
                              foodName:
                                  keySearch, //the change value from text field
                              order: Sorting.mostPopular, //sort by most popular
                            ));
                        print("mojlkljk,jj= ${foods!.length}");
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

/*          BlocProvider(create: (context) => di.getIt<FoodsManagerCubit>()..getAllFoods(foodGetParams: const FoodsGetParamsModel())),
*/
  _buildSeparator() => Divider(
        /*divider color*/
        color: ColorsManager.platinum,
        /*to remove default padding*/
        height: 1,
        /* divider thickness*/
        thickness: AppHeight.s7 * Constants.height,
      );

  void openDrawer(GlobalKey<ScaffoldState> key) =>
      key.currentState!.openDrawer();
  void closeDrawer(GlobalKey<ScaffoldState> key) =>
      key.currentState!.closeDrawer();

  _buildCustomDrawer() => CustomDrawer(
        onTap: (item) {
          closeDrawer(key);
          debugPrint(item.title);
          if (item.title == DrawerItems.addFood.title) {
            Navigator.of(context).pushNamed(Routes.loginRoute);
          }
          if (item.title == DrawerItems.profile.title) {
            //  Get.toNamed(Routes.clientProfileRoute);
            /*        Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              reverseTransitionDuration: Duration(seconds: 1),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                Animation<double> opacity = animation.drive(
                    Tween(begin: 0, end: 1)
                      ..chain(CurveTween(curve: Curves.easeInOut)));
                return FadeScaleTransition(animation: opacity, child: child);
              },
              pageBuilder: (context, animation, secondaryAnimation) {
                return ClientProfileScreen();
              },
            ));*/
            Navigator.of(context).pushNamed(Routes.clientProfileRoute);
          }
          if (item.title == DrawerItems.aboutUs.title) {
            Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              reverseTransitionDuration: Duration(seconds: 1),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                Animation<Offset> slide = animation.drive(
                    Tween(begin: Offset(-.5, 0), end: Offset(0, 0))
                      ..chain(CurveTween(curve: Curves.easeInOut)));
                return transition.SlideTransition(
                  position: slide,
                  child: child,
                );
              },
              pageBuilder: (context, animation, secondaryAnimation) {
                return AboutUsScreen();
              },
            ));
          }
          if (item.title == DrawerItems.categories.title) {
            Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              reverseTransitionDuration: Duration(seconds: 1),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                Animation<Offset> slide = animation.drive(
                    Tween(begin: Offset(0.5, 0), end: Offset(0, 0))
                      ..chain(CurveTween(curve: Curves.easeInOut)));
                return transition.SlideTransition(
                    position: slide, child: child);
              },
              pageBuilder: (context, animation, secondaryAnimation) {
                return CategoryScreen();
              },
            ));
          }
          if (item.title == DrawerItems.saved.title) {
            // Get.toNamed(Routes.savedRoute);
            Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              reverseTransitionDuration: Duration(seconds: 1),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                Animation<double> scale = animation.drive(
                    Tween(begin: 0, end: 1)
                      ..chain(CurveTween(curve: Curves.fastOutSlowIn)));
                return transition.ScaleTransition(
                  scale: scale,
                  child: child,
                );
              },
              pageBuilder: (context, animation, secondaryAnimation) {
                return SavedScreen();
              },
            ));
          }
        },
      );

  _buildCustomAppBar() => CustomAppBar(
      prefix: CustomIconButton(
        asset: AssetsManager.drawer,
        height: AppWidth.s17_5 * Constants.width,
        width: AppWidth.s25 * Constants.width,
        onTap: () => openDrawer(key),
      ),
      title: 'Delivery to',
      titleColor: ColorsManager.nickel,
      titleFontSize: 13,
      subtitle: 'maadi, cairo',
      showSubtitleDropDownArrow: true,
      onTitlePressed: () =>
          Navigator.of(context).pushNamed(Routes.clientLocationRoute),
      suffix:
          MyCart(onTap: () => Navigator.pushNamed(context, Routes.cartRoute)));

  _buildCategories() {
    return SizedBox(
      height:
          AppWidth.s53 * Constants.width + AppHeight.s7 * Constants.height + 30,
      child: BlocConsumer<CategoriesManagerCubit, CategoriesManagerState>(
        listener: (context, state) {
          debugPrint(state.runtimeType.toString());
          if (state is CategoriesLoadedState) {
            categories = state.categories;
          }
        },
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(seconds: 2),
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount:
                  state is CategoriesLoadedState ? categories!.length : 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.only(left: index == 0 ? Constants.margin : 0),
                  child: CategoryItem(
                    category: state is CategoriesLoadedState
                        ? categories![index]
                        : null,
                    index: index,
                    isLoaded: state is CategoriesLoadedState,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.categoryRoute,
                          arguments: {CategoryScreen.categoryKey: index});
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: AppWidth.s25 * Constants.width,
              ),
            ),
          );
        },
      ),
    );
  }

  _buildAdsSlider() => BlocConsumer<AdsManagerCubit, AdsManagerState>(
        listener: (context, state) {
          if (state is AdsLoadedState) {
            ads.addAll(state.ads);
          }
        },
        builder: (context, state) => SliderWithDots(
          isLoaded: state is AdsLoadedState,
          ads: ads,
        ),
      );
  _buildRatedCooks() => BlocConsumer<CooksManagerCubit, CooksManagerState>(
        listener: (context, state) {
          debugPrint(state.toString());
          if (state is CooksLoadedState) {
            cooks.addAll(state.cooks);
            debugPrint(cooks[0].cookId.toString());
            debugPrint(cooks.length.toString());
            debugPrint(cooks[0].cookName);
          }
        },
        builder: (context, state) => NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              if (notification.metrics.maxScrollExtent -
                      notification.metrics.extentBefore <
                  600) {
                //load more from server
                //print('load more from server');
                // FoodsManagerCubit.getMoreFoodsEvent(context);
              }
            }
            return true;
          },
          child: HorizontalListView(
            itemCount: state is! CooksLoadingState ? cooks.length : 5,
            itemBuilder: (index) => Padding(
              padding: EdgeInsets.only(
                  left: index == 0
                      ? Constants.margin
                      : AppWidth.s28 * Constants.width / 2,
                  right: index + 1 == 5
                      ? Constants.margin
                      : AppWidth.s28 * Constants.width / 2),
              child: OpenContainer(
                openElevation: 0,
                closedElevation: 0,
                transitionType: ContainerTransitionType.fade,
                transitionDuration: const Duration(milliseconds: 400),
                middleColor: ColorsManager.grey.withOpacity(0.002),
                closedBuilder: (BuildContext context, void Function() action) {
                  debugPrint('closeContainer');
                  return CookItem(
                    isLoaded: state is! CooksLoadingState,
                    cook: state is! CooksLoadingState ? cooks[index] : null,
                    onTap: action,
                  );
                },
                openBuilder: (BuildContext context,
                    void Function({Object? returnValue}) action) {
                  developer.log(state is CooksLoadedState
                      ? state.cooks[index].cookId.toString()
                      : 'empty');
                  //my work
                  /* BlocProvider.of<CategoriesManagerCubit>(context)
                  .getUserCategories(2);*/
                  /*CookFoodsManagerCubit.getCookFoodsEvent(context,
                  cookGetParams: CookGetParamsModel(providerId: 1));*/
                  return CookProfileScreen(
                    cook: state is CooksLoadedState ? state.cooks[index] : null,
                  );
                },
              ),
            ),
          ),
        ),
      );
  _buildFoods() => BlocProvider(
    create: (context)=>di.getIt<UserCubit>(),
    child: BlocConsumer<FoodsManagerCubit, FoodsManagerState>(
          listener: (context, state) {
            debugPrint(state.runtimeType.toString());
            if (state is FoodsLoadedState) {
              //foods!.addAll(state.foods);
              foods = state.foods;
              debugPrint(state.foods.length.toString());
            }
            if (state is LoadingMoreFoodsState) {
              foods = state.foods;
              debugPrint('loading more');
            }
            if (state is AllFoodAreLoaded) {
              foods = state.foods;
            }
          },
          builder: (context, foodsState) => Container(
            color: ColorsManager.white,
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              child: NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification) {
                      if (notification.metrics.maxScrollExtent -
                              notification.metrics.extentBefore <
                          600) {
                        //load more from server
                        debugPrint('load more from server');
                        FoodsManagerCubit.getMoreFoodsEvent(context);
                      }
                    }
                    return true;
                  },
                  child: foods!.isEmpty && foodsState is FoodsLoadedState
                      ? const NoFoodsUi()
                      : HorizontalListView(
                          itemCount: foodsState is! FoodsLoadingState
                              ? foods!.length
                              : 2,
                          itemBuilder: (index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0
                                    ? Constants.margin
                                    : AppWidth.s12 * Constants.width,
                                right: index + 1 == foods!.length
                                    ? Constants.margin
                                    : 0,
                              ),
                              child: Row(
                                // set widgets horizontally
                                children: [
                                  BlocConsumer<UserCubit,UserState>(
                                    buildWhen: (c,p)=>foods![index].foodId==selectedFavouriteFoodId,
                                    listener: (context,favouriteState){
                                      if(favouriteState is AddedToFavouritesState){
                                        isFavourite=favouriteState.favouriteResponseEntity.data!;
                                      }
                                    },
                                    builder: (context,favouriteState)=> FoodItem(
                                      food: foodsState is! FoodsLoadingState
                                          ? foods![index]
                                          : null,
                                      isFavourited: isFavourite,
                                      isLoaded: foodsState is! FoodsLoadingState,
                                      width: AppWidth.s200 * Constants.width,
                                      onTap: () {
                                        //  FoodManagerCubit.getFoodByIdEvent(context, foods![index].foodId!);

                                        // CookFoodsManagerCubit.getCookFoodsEvent(context,
                                        //     cookGetParams: CookGetParamsModel(providerId: foods![index].userId!));
                                        Navigator.pushNamed(
                                            context, Routes.foodDetailsRoute,
                                            arguments: {
                                              FoodDetailsScreen.foodIdKey:
                                              foods![index].foodId,
                                              FoodDetailsScreen.providerIdKey:
                                              foods![index].userId
                                            });
                                      },
                                      onFavouriteBtnPressed: (value) {
                                        if(favouriteModel.userId!=null){
                                          favouriteModel.foodId=foods![index].foodId;
                                          selectedFavouriteFoodId=foods![index].foodId;
                                          UserCubit.addToFavouritesEvent(context, favouriteModel);
                                        }
                                        else{
                                          Navigator.pushNamed(context, Routes.loginRoute);
                                        }
                                      },
                                    ),
                                  ),
                                  if (foodsState is LoadingMoreFoodsState &&
                                      index + 1 == foods!.length)
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Constants.margin),
                                      child: CustomCircularProgressbar(
                                        radius: AppWidth.s12 * Constants.width,
                                      ),
                                    )
                                ],
                              ),
                            );
                          })),
            ),
          ),
        ),
  );
}
