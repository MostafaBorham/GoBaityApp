import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallabaity/network_layer/models/data_models/category_model.dart';
import 'package:yallabaity/network_layer/models/data_models/food_model.dart';
import 'package:yallabaity/network_layer/models/data_models/foods_get_params_model.dart';
import 'package:yallabaity/presentation/manager/cubit_categories/categories_manager_cubit.dart';
import 'package:yallabaity/presentation/pages/see_all_screen.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/pages/food_details_screen.dart';
import 'package:yallabaity/presentation/widgets/horizontal_listview.dart';
import 'package:yallabaity/presentation/widgets/custom_bottom_sheet.dart';
import 'package:yallabaity/presentation/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';
import 'package:yallabaity/presentation/widgets/food_item.dart';
import 'package:yallabaity/presentation/widgets/search.dart';
import 'package:yallabaity/presentation/widgets/sections.dart';
import 'package:yallabaity/injection_container.dart' as di;
import 'package:lottie/lottie.dart';
import '../../application/app_api_constants/sorting_constants.dart';
import '../../domain/entities/requests_entites/food_entity.dart';
import '../manager/cubit_foods/foods_manager_cubit.dart';
import '../widgets/custom_circular_progressbar.dart';
import '../widgets/screen_with_keypad.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static const String categoryKey = 'category';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with TickerProviderStateMixin {
  List<CategoryModel> categoriesList = [];
  List<FoodEntity> mostSeenFoods = [];
  TabController? _tabController;
  int currentIndex = 0;
  bool loadingMoreMostPopularFoods = false;
  bool loadingMoreMostSeenFoods = false;
  String searchedText = '';
  BuildContext? mostPopularContext;
  BuildContext? mostSeenContext;
  int? categoryIndex;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (data != null) {
      categoryIndex = data[CategoryScreen.categoryKey];
      debugPrint('category index is $categoryIndex');
    }
    return ScreenWithKeypad(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.translate(AppStrings.categories), //categories title
          showBackgroundImage:
              true, //don't show appbar image, it will be shown only on maximum purple background
        ),
        body: BlocConsumer<CategoriesManagerCubit, CategoriesManagerState>(
          // cubit for categories, this cubit is initialized in gobaity_app.dart file
          listener: (context, categoriesState) {},
          builder: (context, categoriesState) {
            if (categoriesState is CategoriesLoadedState) {
              categoriesList = categoriesState
                  .categories; // if categories is loaded, updated categoriesList
              _tabController = TabController(
                  length: categoriesList.length,
                  initialIndex: categoryIndex!,
                  vsync: this); // update tab controller
            }
            return Column(
              //set widgets vertically
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                    height: AppHeight.s19 *
                        Constants.height), //vertical space before search
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Constants.margin), // margin for search widget
                  child: Search(
                    // search widget
                    hintText: AppStrings.translate(
                        AppStrings.search), //hint for textfield
                    showFilter: true, //show filter for search widget
                    onChanged: (text) {
                      /* on text updated use foods manager cubit to update most popular horizontal listview*/
                      FoodsManagerCubit.getFoodsEvent(mostPopularContext!,
                          foodGetParams: FoodsGetParamsModel(
                            categoryId: categoriesList[_tabController!.index]
                                .categoryId!, //category id
                            page: 0, // start from page 0
                            foodName: text, //the change value from text field
                            order: Sorting.mostPopular, //sort by most popular
                          ));
                      FoodsManagerCubit.getFoodsEvent(mostSeenContext!,
                          foodGetParams: FoodsGetParamsModel(
                            categoryId: categoriesList[_tabController!.index]
                                .categoryId!,
                            page: 0, // start from page 0
                            foodName: text, //the change value from text field
                            order: Sorting.mostWatched, //sort by most seen
                          ));
                      //  SearchManagerCubit.searchWordEvent(context: context, word: text);
                    },
                    onFilterPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, //set bottom sheet to full height
                        backgroundColor: ColorsManager
                            .transparent, //bottom sheet background color is transparent
                        builder: (context) =>
                            const CustomBottomSheet(// stateful custom widget

                                ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppHeight.s27 * Constants.height,
                ),
                categoriesState is CategoriesLoadedState
                    ? TabBar(
                        controller: _tabController,
                        unselectedLabelColor: ColorsManager.black,
                        labelColor: ColorsManager.maximumPurple,
                        labelStyle: getSemiBoldStyle(
                            fontSize: AppWidth.s14 * Constants.width),
                        unselectedLabelStyle: getMediumStyle(
                            color: ColorsManager.black,
                            fontSize: AppWidth.s14 * Constants.width),
                        physics: const BouncingScrollPhysics(),
                        indicator: CircleTabIndicator(
                            color: ColorsManager.maximumPurple, radius: 3),
                        isScrollable: true,
                        tabs: categoriesList
                            .map((e) => Tab(
                                  text: e.categoryName,
                                ))
                            .toList())
                    : const CircularProgressIndicator(
                        color: ColorsManager.maximumPurple,
                      ),
                SizedBox(
                  height: AppHeight.s34 * Constants.height,
                ),
                Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children: categoriesList
                          .map(
                            (e) => _buildPage(e),
                          )
                          .toList()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPage(CategoryModel e) => SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            //set widgets vertically
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Constants.margin),
                child: SectionName(
                  title: AppStrings.translate(AppStrings.mostPopular),
                  subtitle: AppStrings.translate(AppStrings.seeAll),
                  onTap: () {
                    Navigator.of(context)
                        .push(RouteGenerator.pageFadeTransition(
                      widget: BlocProvider.value(
                        value: BlocProvider.of<FoodsManagerCubit>(
                            mostPopularContext!),
                        child: SeeAllScreen(),
                      ),
                      routeSettings: RouteSettings(arguments: {
                        SeeAllScreen.categoryName: e,
                        SeeAllScreen.sectionName:
                            AppStrings.translate(AppStrings.mostPopular),
                      }),
                    ));
                  },
                ),
              ),
              SizedBox(height: AppHeight.s11 * Constants.height),
              BlocProvider(
                  create: (context) {
                    debugPrint('create new controller');
                    return di.getIt<FoodsManagerCubit>()
                      ..getFoods(
                          foodGetParams: FoodsGetParamsModel(
                        categoryId: e.categoryId!,
                        page: 0,
                        foodName: searchedText,
                        order: Sorting.mostPopular,
                      ));
                  },
                  child: BlocConsumer<FoodsManagerCubit, FoodsManagerState>(
                    listener: (context, state) {},
                    builder: (context, foodsState) {
                      mostPopularContext = context;
                      debugPrint(
                          'fooooooooooooood state is ${foodsState.runtimeType}');
                      if (foodsState is FoodsLoadedState ||
                          foodsState is LoadingMoreFoodsState ||
                          foodsState is AllFoodAreLoaded) {
                        List<FoodEntity> foods = [];
                        if (foodsState is FoodsLoadedState) {
                          foods = foodsState.foods;
                        }
                        if (foodsState is LoadingMoreFoodsState) {
                          foods = foodsState.foods;
                        }
                        if (foodsState is AllFoodAreLoaded) {
                          foods = foodsState.foods;
                        }
                        if (foods.isEmpty) {
                          return SizedBox(
                            height: AppHeight.s200 * Constants.height,
                            width: AppWidth.s200 * Constants.width,
                            child: Lottie.asset(AssetsManager.empty),
                          );
                        }
                        return Container(
                          color: ColorsManager.white,
                          child: NotificationListener(
                              onNotification: (notification) {
                                if (notification is ScrollEndNotification) {
                                  if (notification.metrics.maxScrollExtent -
                                          notification.metrics.extentBefore <
                                      600) {
                                    //load more from server
                                    debugPrint('load more from server');
                                    FoodsManagerCubit.getMoreFoodsEvent(
                                        context);
                                  }
                                }
                                return true;
                              },
                              child: HorizontalListView(
                                  itemCount: foods.length,
                                  itemBuilder: (index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: index == 0
                                            ? Constants.margin
                                            : AppWidth.s12 * Constants.width,
                                        right: index + 1 == foods.length
                                            ? Constants.margin
                                            : 0,
                                      ),
                                      child: Row(
                                        // set widgets horizontally
                                        children: [
                                          FoodItem(
                                            food: foods[index],
                                            isLoaded: true,
                                            width:
                                                AppWidth.s200 * Constants.width,
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  Routes.foodDetailsRoute,
                                                  arguments: {
                                                    FoodDetailsScreen.foodIdKey:
                                                        foods[index].foodId,
                                                    FoodDetailsScreen
                                                            .providerIdKey:
                                                        foods[index].userId
                                                  });
                                            },
                                            onFavouriteBtnPressed: (value) {
                                              setState(() {
                                                FoodModel.all[index]
                                                    .isFavorited = value;
                                              });
                                            },
                                          ),
                                          if (foodsState
                                                  is LoadingMoreFoodsState &&
                                              index + 1 == foods.length)
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: AppHeight.s20 *
                                                      Constants.height),
                                              child: CustomCircularProgressbar(
                                                  radius: AppWidth.s12 *
                                                      Constants.width),
                                            ),
                                          if (foodsState is AllFoodAreLoaded &&
                                              index + 1 == foods.length)
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Constants.margin),
                                              child:
                                                  Text('All foods Are Loaded'),
                                            ),
                                        ],
                                      ),
                                    );
                                  })),
                        );
                      }
                      return Container(
                        color: ColorsManager.white,
                        child: HorizontalListView(
                          itemCount: 2,
                          itemBuilder: (index) => Padding(
                            padding: EdgeInsets.only(
                              left: index == 0
                                  ? Constants.margin
                                  : AppWidth.s12 * Constants.width,
                              right: index + 1 == 2 ? Constants.margin : 0,
                            ),
                            child: FoodItem(
                              food: null,
                              isLoaded: false,
                              width: AppWidth.s200 * Constants.width,
                            ),
                          ),
                        ),
                      );
                    },
                  )),
              SizedBox(height: AppHeight.s40 * Constants.height),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Constants.margin),
                child: SectionName(
                  title: 'Most Seen',
                  subtitle: 'See All',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.seeAllRoute);
                    //   BlocProvider.value(value: BlocProvider.of<most>(context));
                  },
                ),
              ),
              SizedBox(
                height: AppHeight.s11 * Constants.height,
              ),
              BlocProvider(
                  create: (context) => di.getIt<FoodsManagerCubit>()
                    ..getFoods(
                        foodGetParams: FoodsGetParamsModel(
                            categoryId: e.categoryId!,
                            page: 0,
                            order: Sorting.mostWatched)),
                  child: BlocConsumer<FoodsManagerCubit, FoodsManagerState>(
                    listener: (context, state) {
                      debugPrint(state.runtimeType.toString());
                      if (state is FoodsLoadedState &&
                          loadingMoreMostSeenFoods) {
                        debugPrint('rebuild  ==>         ${e.categoryName}');
                        mostSeenFoods.addAll(state.foods);
                        debugPrint(state.foods.length.toString());
                        loadingMoreMostSeenFoods = false;
                      } else if (state is FoodsLoadedState) {
                        mostSeenFoods = state.foods;
                      }
                      if (state is LoadingMoreFoodsState) {
                        debugPrint('loading more');
                        loadingMoreMostSeenFoods = true;
                      }
                    },
                    builder: (context, foodsState) {
                      debugPrint(
                          'fooooooooooooood state is ${foodsState.runtimeType}');
                      mostSeenContext = context;
                      if (foodsState is FoodsLoadedState &&
                          mostSeenFoods.isEmpty) {
                        return SizedBox(
                            height: AppHeight.s200 * Constants.height,
                            width: AppWidth.s200 * Constants.width,
                            child: Lottie.asset(AssetsManager.empty));
                      }
                      return Container(
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
                                    FoodsManagerCubit.getMoreFoodsEvent(
                                        context);
                                  }
                                }
                                return true;
                              },
                              child: HorizontalListView(
                                  itemCount: foodsState is FoodsLoadedState
                                      ? (mostSeenFoods.isNotEmpty
                                          ? mostSeenFoods.length
                                          : 1)
                                      : 2,
                                  itemBuilder: (index) {
                                    if (foodsState is FoodsLoadedState &&
                                        mostSeenFoods.isEmpty) {
                                      return SizedBox(
                                          height:
                                              AppHeight.s200 * Constants.height,
                                          width:
                                              AppWidth.s200 * Constants.width,
                                          child: Lottie.asset(
                                              AssetsManager.empty));
                                    }
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: index == 0
                                            ? Constants.margin
                                            : AppWidth.s12 * Constants.width,
                                        right: index + 1 == mostSeenFoods.length
                                            ? Constants.margin
                                            : 0,
                                      ),
                                      child: Row(
                                        // set widgets horizontally
                                        children: [
                                          FoodItem(
                                            food: foodsState is FoodsLoadedState
                                                ? mostSeenFoods[index]
                                                : null,
                                            isLoaded:
                                                foodsState is FoodsLoadedState,
                                            width:
                                                AppWidth.s252 * Constants.width,
                                            onTap: () {
                                              //  FoodManagerCubit.getFoodByIdEvent(context, foods![index].foodId!);

                                              // CookFoodsManagerCubit.getCookFoodsEvent(context,
                                              //     cookGetParams: CookGetParamsModel(providerId: foods![index].userId!));
                                              Navigator.pushNamed(context,
                                                  Routes.foodDetailsRoute,
                                                  arguments: {
                                                    FoodDetailsScreen.foodIdKey:
                                                        mostSeenFoods[index]
                                                            .foodId,
                                                    FoodDetailsScreen
                                                            .providerIdKey:
                                                        mostSeenFoods[index]
                                                            .userId
                                                  });
                                            },
                                            onFavouriteBtnPressed: (value) {
                                              setState(() {
                                                FoodModel.all[index]
                                                    .isFavorited = value;
                                              });
                                            },
                                          ),
                                          if (foodsState
                                                  is LoadingMoreFoodsState &&
                                              index + 1 == mostSeenFoods.length)
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Constants.margin),
                                              child: CustomCircularProgressbar(
                                                radius: AppWidth.s12 *
                                                    Constants.width,
                                              ),
                                            )
                                        ],
                                      ),
                                    );
                                  })),
                        ),
                      );
                    },
                  ))
            ],
          ),
        ),
      );
/*
  void goToNextItem(int index) {
    setState(() {
      categories[currentIndex].active = false;
      categories[index].active = !categories[index].active;
      currentIndex = index;
      _pageController.jumpToPage(index);
      // if(index*AppWidth.s60.w>_scrollController.position.maxScrollExtent)
      _scrollController.animateTo(index * AppWidth.s60*Constants.width,
          duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
    });
  }*/
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
