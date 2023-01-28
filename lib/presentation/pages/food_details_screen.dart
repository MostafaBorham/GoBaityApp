import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yallabaity/application/app_api_constants/api_constants.dart';
import 'package:yallabaity/application/enums/app_messages.dart';
import 'package:yallabaity/application/app_prefs.dart';
import 'package:yallabaity/domain/entities/requests_entites/food_entity.dart';
import 'package:yallabaity/network_layer/models/data_models/cart_post_model.dart';
import 'package:yallabaity/network_layer/models/data_models/food_model.dart';
import 'package:yallabaity/network_layer/models/data_models/food_view_and_order_model.dart';
import 'package:yallabaity/network_layer/models/data_models/size_model.dart';
import 'package:yallabaity/network_layer/models/data_models/user_model.dart';
import 'package:yallabaity/network_layer/models/product_size_model.dart';
import 'package:yallabaity/presentation/manager/cubit_cart_manager/cubit_cart_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_categories/categories_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_cook_foods_manager/cubit_cook_foods_manager_cubit.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/circular_icon_button.dart';
import 'package:yallabaity/presentation/widgets/custom_network_image.dart';
import 'package:yallabaity/presentation/widgets/food_overview.dart';
import 'package:yallabaity/presentation/widgets/food_size_item.dart';
import 'package:yallabaity/presentation/widgets/shimmer_widget.dart';
import 'package:yallabaity/presentation/widgets/tags_widget.dart';
import 'package:yallabaity/presentation/widgets/custom_data_button.dart';
import 'package:yallabaity/presentation/widgets/food_item.dart';
import 'package:yallabaity/injection_container.dart' as di;

import '../../application/app_api_constants/sorting_constants.dart';
import '../../network_layer/models/data_models/category_model.dart';
import '../../network_layer/models/data_models/cook_get_params_model.dart';
import '../manager/cubit_food_operation_manager/cubit_food_operation_manager_cubit.dart';
import '../manager/cubit_user_manager/cubit_user.dart';
import '../widgets/description_and_reviews.dart';
import '../widgets/custom_image_slider.dart';
import '../widgets/food_sizes_widget.dart';
import 'package:yallabaity/injection_container.dart' as di;

import '../widgets/user_listtile.dart';
import 'package:toast/toast.dart';

class FoodDetailsScreen extends StatefulWidget {
  static String foodIdKey = 'food id';
  static String providerIdKey = 'provider id';

  FoodDetailsScreen({super.key});
  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> with TickerProviderStateMixin {
  late TabController _categoriesTabController;
  FoodViewAndOrderModel? foodViewAndOrder;
  List<FoodModel> cookFoods = [];
  List<FoodModel> cookTopFoods = [];
  List<SizeModel>? sizes;
  int? foodId;
  int? providerId;
  int activeSizeIndex = 0;
  List<CategoryModel>? userCategories;
  double totalPrice=0.0;
  @override
  Widget build(BuildContext context) {
    //  _categoriesTabController = TabController(length: widget.categories.length, vsync: this);

    Map<String, dynamic>? arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (arguments != null) {
      foodId = arguments[FoodDetailsScreen.foodIdKey];
      providerId = arguments[FoodDetailsScreen.providerIdKey];
    }
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di.getIt<FoodOperationManagerCubit>()..getFoodById(foodId!),
          ),
          BlocProvider(
            create: (context) => di.getIt<CookFoodsManagerCubit>()
              ..getCookFoods(
                cookGetParams: CookGetParamsModel(providerId: providerId, order: Sorting.rate),
              ),
          ),
          BlocProvider(
            create: (context) => di.getIt<CategoriesManagerCubit>()..getUserCategories(providerId!),
          ),
        ],
        child: BlocConsumer<FoodOperationManagerCubit, FoodOperationManagerState>(
          listener: (context, foodState) {
           debugPrint(foodState.runtimeType.toString());
            if (foodState is FoodLoadedState) {
              foodViewAndOrder = foodState.foodViewAndOrder;
              sizes = foodViewAndOrder!.sizes;
            }
          },
          builder: (context, foodState) {
           debugPrint('rebuild from again');

            return SizedBox(
              height: double.maxFinite,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(//set widgets vertically
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageSliderWithBackAndFavouriteButton(
                          onBackPressed: () => Navigator.of(context).pop(),
                          isLoaded: foodState is FoodLoadedState?,
                          images:
                              foodState is FoodLoadedState ? foodViewAndOrder!.images!.map((e) => e.imagePath!).toList() : null,
                        ),
                        Column(//set widgets vertically
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: AppHeight.s10 * Constants.height,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Constants.margin),
                              child: Column(//set widgets vertically
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  foodState is FoodLoadedState
                                      ? Text(
                                          foodViewAndOrder!.food!.foodName!,
                                          style: getSemiBoldStyle(
                                            color: ColorsManager.eerieBlack,
                                            fontSize: AppWidth.s19 * Constants.width,
                                          ),
                                        )
                                      : ShimmerWidget(
                                          height: AppHeight.s19 * Constants.height,
                                          width: Constants.width,
                                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                  SizedBox(
                                    height: AppHeight.s14 * Constants.height,
                                  ),
                                  TagsWidget(
                                    isLoaded: foodState is FoodLoadedState,
                                    tags: foodState is FoodLoadedState
                                        ? foodViewAndOrder!.categories!.map((e) => e.categoryName!).toList()
                                        : null,
                                  ),
                                  SizedBox(
                                    height: AppHeight.s30 * Constants.height,
                                  ),
                                  FoodOverview(
                                    isLoaded: foodState is FoodLoadedState,
                                    review: foodState is FoodLoadedState ? foodViewAndOrder!.food!.rate! : null,
                                    nReview: foodState is FoodLoadedState ? foodViewAndOrder!.food!.rateCount! : null,
                                    distance: foodState is FoodLoadedState ? 150 : null,
                                    time: foodState is FoodLoadedState ? foodViewAndOrder!.food!.preparationTime! : null,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: AppHeight.s30 * Constants.height,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Constants.margin),
                              child: foodState is FoodLoadedState
                                  ? Text(
                                      AppStrings.translate(AppStrings.selectSize),
                                      style: getMediumStyle(
                                          color: ColorsManager.eerieBlack, fontSize: AppWidth.s17 * Constants.width),
                                    )
                                  : ShimmerWidget(
                                      height: AppHeight.s30 * Constants.height,
                                      width: AppWidth.s150 * Constants.width,
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                            ),
                            SizedBox(
                              height: AppHeight.s20 * Constants.height,
                            ),
                            BlocConsumer<CartManagerCubit, CartManagerState>(
                              builder: (context, cartState) {
                                return FoodSizesListWidget(
                                  isLoaded: foodState is FoodLoadedState,
                                  sizesList: foodState is FoodLoadedState ? sizes : null,
                                  isAdding: cartState is CartPostingState,
                                  onAddToCartPressed: (int index, int quantity) async {
                                    CartPostModel cart = CartPostModel(
                                        quantity: quantity,
                                        foodsSizesId: sizes![index].sizeId,
                                        foodId: foodViewAndOrder!.food!.foodId);
                                    sizes![index].isAdding = true;
                                    activeSizeIndex = index;
                                    UserModel? user = await UserCubit.getUserFromStorage(context);
                                    if (user != null) {
                                      CartManagerCubit.postCartEvent(context: context, id: user.userId!, cart: cart);
                                    } else {
                                      Navigator.pushNamed(context,Routes.clientApplyRoute);
                                    }
                                   debugPrint(user.toString());
                                  },
                                  showCircular: cartState is CartPostingState,
                                );
                              },
                              listener: (context, cartState) {
                               debugPrint(cartState.runtimeType.toString());
                                if (cartState is CartPostError) {
                                 debugPrint(cartState.message);
                                }
                                if (cartState is CartPostedState) {
                                  _buildToast(context, 'Added to your cart successfully');
                                  sizes![activeSizeIndex].isAdding = false;
                                  totalPrice=cartState.cartPostResponse.data!;
                                }
                              },
                            ),
                            SizedBox(
                              height: AppHeight.s10 * Constants.height,
                            ),
                            DescriptionAndReviews(
                              description: foodState is FoodLoadedState ? foodViewAndOrder!.food!.description : null,
                              reviews: foodState is FoodLoadedState ? foodViewAndOrder!.reviews! : null,
                              isLoaded: foodState is FoodLoadedState,
                            ),
                            SizedBox(
                              height: AppHeight.s40 * Constants.height,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: AppWidth.s31 * Constants.width),
                              child: Column(//set widgets vertically
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  foodState is FoodLoadedState
                                      ? AutoSizeText(
                                          AppStrings.translate(AppStrings.postedBy),
                                          style: getMediumStyle(color: ColorsManager.graniteGray, fontSize: 14),
                                        )
                                      : ShimmerWidget(
                                          height: AppHeight.s20 * Constants.height,
                                          width: AppWidth.s100 * Constants.width,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                  SizedBox(
                                    height: AppHeight.s30 * Constants.height,
                                  ),
                                  UserListTile(
                                    userName: foodState is FoodLoadedState ? foodViewAndOrder!.food!.cookName! : null,
                                    isLoaded: foodState is FoodLoadedState,
                                  ),
                                  SizedBox(
                                    height: AppHeight.s30 * Constants.height,
                                  ),
                                  foodState is FoodLoadedState
                                      ? Text(
                                          '${AppStrings.translate(AppStrings.othersBy)} ${foodViewAndOrder!.food!.cookName}',
                                          style: getMediumStyle(
                                              color: ColorsManager.eerieBlack, fontSize: AppWidth.s17 * Constants.width),
                                        )
                                      : ShimmerWidget(
                                          height: AppHeight.s20 * Constants.height,
                                          width: AppWidth.s100 * Constants.width,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: AppHeight.s30 * Constants.height,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Constants.margin),
                              child: Column(//set widgets vertically
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  foodState is FoodLoadedState
                                      ? Text(AppStrings.translate(AppStrings.topRated),
                                          style: getSemiBoldStyle(
                                            color: ColorsManager.eerieBlack,
                                            fontSize: AppWidth.s17 * Constants.width,
                                          ))
                                      : ShimmerWidget(
                                          height: AppHeight.s20 * Constants.height,
                                          width: AppWidth.s100 * Constants.width,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                  SizedBox(
                                    height: AppHeight.s22 * Constants.height,
                                  ),
                                  _buildTopRated(),
                                  SizedBox(
                                    height: AppHeight.s30 * Constants.height,
                                  ),
/*
                                  BlocConsumer<CategoriesManagerCubit, CategoriesManagerState>(
                                    listener: (context, state) {
                                     debugPrint(state.runtimeType);
                               */
/*       if (state is CookFoodsLoadedState) {
                                        cookFoods = state.cookFoods;
                                       debugPrint(cookFoods.length);
                                      }*//*

                                      if(state is CategoriesLoadedState){
                                        userCategories=state.categories;

                                      _categoriesTabController=TabController(length: state.categories.length, vsync: this);
                                      }
                                    },
                                    builder: (context, state) => Column(//set widgets vertically
                                      children: [
                                        state is CategoriesLoadingState? Row(// set widgets horizontally
                                          children: [
                                            ShimmerWidget(width: 80,height: 50,),
                                            SizedBox(width: 30,),
                                            ShimmerWidget(width: 80,height: 50,),

                                          ],
                                        ):Column(//set widgets vertically
                                          children: [
                                            TabBar(
                                              isScrollable: true,
                                              physics: const BouncingScrollPhysics(),
                                              labelColor: ColorsManager.maximumPurple,
                                              unselectedLabelColor: ColorsManager.black,
                                              labelStyle: getSemiBoldStyle(color: ColorsManager.black, fontSize: AppWidth.s14 * Constants.width),
                                              unselectedLabelStyle: getMediumStyle(color: ColorsManager.white, fontSize: AppWidth.s14 * Constants.width),
                                              indicator: const BoxDecoration(border: null),
                                              controller: _categoriesTabController,
                                              tabs: userCategories!.map((e) => Tab(child: Text(e.categoryName!))).toList(),

                                            ),
                      */
/*                      SizedBox(
                                              height: Constants.height * 0.3 * cookTopFoods.length,
                                              child: TabBarView(
                                                controller: _categoriesTabController,
                                                children: [
                                                  ListView.separated(
                                                    itemCount: state is! CookFoodsLoadedState ? 2 : cookTopFoods.length,
                                                    shrinkWrap: true,
                                                    primary: false,
                                                    itemBuilder: (context, index) {
                                                      return FoodItem(
                                                        food: state is CookFoodsLoadedState ? cookTopFoods[index] : null,
                                                        isLoaded: state is CookFoodsLoadedState,
                                                        onTap: () {
                                                         debugPrint('tappped');
                                                          Navigator.pushNamed(context, Routes.foodDetailsRoute, arguments: {
                                                            FoodDetailsScreen.foodIdKey: cookTopFoods[index].foodId,
                                                            FoodDetailsScreen.providerIdKey: cookTopFoods[index].userId
                                                          });
                                                        },
                                                      );
                                                    },
                                                    separatorBuilder: (BuildContext context, int index) => SizedBox(
                                                      height: AppHeight.s29 * Constants.height,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),*//*

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
*/
                                ],
                              ),
                            ),
                            SizedBox(
                              height: AppHeight.s30 * Constants.height,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: BlocConsumer<CartManagerCubit,CartManagerState>(
                        listener: (context, state) {
                         debugPrint('view bag changed');
                        },
                        builder: (context, state) => CustomDataButton(
                          count: 1,
                          text: AppStrings.translate(AppStrings.viewBag),
                          suffix: Text(
                            totalPrice.toString(),
                            style: getSemiBoldStyle(fontSize: AppWidth.s16 * Constants.width, color: ColorsManager.white),
                          ),
                          onTap: () async {
                            // Navigator.of(context).pushNamed(Routes.cartRoute);
                          },
                        ),
                      ),
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


  _buildTopRated() => BlocConsumer<CookFoodsManagerCubit, CookFoodsManagerState>(
        listener: (context, state) {
         debugPrint('cook foods loaded');
         debugPrint(state.runtimeType.toString());
          if (state is CookFoodsLoadedState) {
            cookTopFoods.addAll(state.cookFoods);
           debugPrint(cookFoods.length.toString());
          }
        },
        builder: (context, state) {
          return ListView.separated(
            itemCount: state is! CookFoodsLoadedState ? 2 : cookTopFoods.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return FoodItem(
                food: state is CookFoodsLoadedState ? cookTopFoods[index] : null,
                isLoaded: state is CookFoodsLoadedState,
                onTap: () {
                 debugPrint('tappped');
                  Navigator.pushNamed(context, Routes.foodDetailsRoute, arguments: {
                    FoodDetailsScreen.foodIdKey: cookTopFoods[index].foodId,
                    FoodDetailsScreen.providerIdKey: cookTopFoods[index].userId
                  });
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: AppHeight.s29 * Constants.height,
            ),
          );
        },
      );

/*
  _buildViewCartScreen() =>Positioned.fill(
    bottom: 0,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: CustomDataButton(
        count: 1,
        text: 'View Bag',
        suffix: Text(
          '213.00 EGP',
          style: getSemiBoldStyle(fontSize: AppWidth.s16 * Constants.width, color: ColorsManager.white),
        ),
        onTap: () async {
          if (basket.isNotEmpty) {
            cart = CartPostModel(
              basketSizes: basket,
              foodId: foodViewAndOrder!.food!.foodId,
            );
            UserModel? user = await UserCubit.getUserFromServer(context);
            if (user != null) {
              CartManagerCubit.postCartEvent(context: context, id: user.userId!, cart: cart!);
            }
           debugPrint(user);
          }

          // Navigator.of(context).pushNamed(Routes.cartRoute);
        },
      ),
    ),
  );
*/
  _buildToast(BuildContext context, String message) {
    FToast? fToast = FToast();
    fToast.init(context);
    fToast.showToast(
        toastDuration: const Duration(seconds: 1),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(color: ColorsManager.steelPink, borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(vertical: AppHeight.s15 * Constants.height, horizontal: AppWidth.s15 * Constants.width),
          child: Row(// set widgets horizontally
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(AssetsManager.gobaityIcon),
              ),
              SizedBox(
                width: AppWidth.s20 * Constants.width,
              ),
              AutoSizeText(
                message,
                style: getSemiBoldStyle(
                  color: ColorsManager.white,
                  fontSize: 12,
                ),
                maxLines: 2,
              )
            ],
          ),
        ));
  }
}
