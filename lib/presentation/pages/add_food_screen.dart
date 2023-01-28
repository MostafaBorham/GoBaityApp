import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yallabaity/application/app_failures/app_errors.dart';
import 'package:yallabaity/application/extensions.dart';
import 'package:yallabaity/application/utils.dart';
import 'package:yallabaity/domain/entities/requests_entites/category_entity.dart';
import 'package:yallabaity/network_layer/models/data_models/category_model.dart';
import 'package:yallabaity/network_layer/models/data_models/food_post_model.dart';
import 'package:yallabaity/network_layer/models/data_models/size_model.dart';
import 'package:yallabaity/network_layer/models/data_models/user_model.dart';
import 'package:yallabaity/network_layer/models/item_model.dart';
import 'package:yallabaity/presentation/manager/bloc_sizes/sizes_bloc.dart';
import 'package:yallabaity/presentation/manager/cubit_categories/categories_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_errors/errors_manager_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_food_sizes_listview/food_sizes_cubit.dart';
import 'package:yallabaity/presentation/manager/cubit_image_picker/image_picker_cubit.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/custom_appbar.dart';
import 'package:yallabaity/presentation/widgets/custom_button.dart';
import 'package:yallabaity/presentation/widgets/custom_dialog.dart';
import 'package:yallabaity/presentation/widgets/custom_drop_down.dart';
import 'package:yallabaity/presentation/widgets/custom_image.dart';
import 'package:yallabaity/presentation/widgets/custom_textfield.dart';
import 'package:yallabaity/presentation/widgets/custom_tile_%20button.dart';
import 'package:yallabaity/presentation/widgets/error_widget.dart';
import 'package:yallabaity/presentation/widgets/images_preview_dialog.dart';
import 'package:yallabaity/presentation/widgets/sections.dart';
import 'package:yallabaity/presentation/widgets/size_item.dart';

import '../../application/app_failures/app_errors.dart';
import '../manager/cubit_food_operation_manager/cubit_food_operation_manager_cubit.dart';
import '../manager/cubit_user_manager/cubit_user.dart';
import '../resources/assets_manager.dart';

class AddFoodScreen extends StatelessWidget {
  AddFoodScreen({super.key});

  final List<List<ItemModel>> _selectedSizes = [];
  GlobalKey<FormState> formKey = GlobalKey();
  bool collapse = true;
  double height = 0;
  int countSizes = 0;
  String? title;
  String? description;
  List<int> tags = [];
  List<FoodPostModel> foods = [];
  List<ItemModel> foodSizesItems = [];
  List<SizeModel> foodSizesList = [];
  final List<String> images = [];
  BuildContext? dialogContext;
  BuildContext? screenContext;
  @override
  Widget build(BuildContext context) {
    screenContext = context;
    return GestureDetector(
      onTap: () {
        Utils.hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: ColorsManager.white,
        appBar: CustomAppBar(
          backgroundColor: ColorsManager.maximumPurple,
          showBackgroundImage: true,
          title: AppStrings.translate(AppStrings.postFood),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ErrorsManagerCubit()),
            BlocProvider(create: (context) => ImagePickerCubit()),
          ],
          child: BlocBuilder<ErrorsManagerCubit, ErrorsManagerState>(
            builder: (context, errorState) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                //set widgets vertically
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Constants.margin),
                    child: Column(//set widgets vertically
                        children: [
                      Form(
                        key: formKey,
                        child: Column(
                          //set widgets vertically
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppHeight.s20 * Constants.height),
                             SectionName(title: AppStrings.translate(AppStrings.info)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: AppWidth.s10 * Constants.width),
                              child: _buildTitle(context),
                            ),
                            SizedBox(
                              height: AppHeight.s20 * Constants.height,
                            ),
                            _buildImages(context),
                            _addFoodTextButton(context),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: ErrorsManagerCubit.contains(context, AppErrors.images)
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        ErrorsManagerCubit.getErrorMessage(context, AppErrors.images),
                                        style: getMediumStyle(
                                          fontSize: AppWidth.s14 * Constants.width,
                                          color: ColorsManager.red,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            SizedBox(
                              height: AppHeight.s20 * Constants.height,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: AppWidth.s10 * Constants.width),
                              child: _buildDescription(context),
                            ),
                            SizedBox(
                              height: AppHeight.s20 * Constants.height,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppWidth.s10 * Constants.width,
                              ),
                              child: _buildCategories(context),
                            ),
                            BlocBuilder<ErrorsManagerCubit, ErrorsManagerState>(
                              builder: (context, state) => CustomErrorWidget(
                                visible: ErrorsManagerCubit.contains(context, AppErrors.tags),
                                message: ErrorsManagerCubit.getErrorMessage(
                                  context,
                                  AppErrors.tags,
                                ).capitalizeFirst,
                              ),
                            ),
                            SizedBox(
                              height: AppHeight.s30 * Constants.height,
                            ),
                            const Divider(
                              color: ColorsManager.platinum,
                              thickness: 7,
                            ),
                            SizedBox(
                              height: AppHeight.s23 * Constants.height,
                            ),
                             SectionName(title: AppStrings.translate(AppStrings.sizes)),
                            SizedBox(
                              height: AppHeight.s24 * Constants.height,
                            ),
                            _buildSizes(),
                            SizedBox(
                              height: AppHeight.s30 * Constants.height,
                            ),
                            const Divider(
                              color: ColorsManager.platinum,
                              thickness: 7,
                            ),
                            SizedBox(
                              height: AppHeight.s20 * Constants.height,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppWidth.s10 * Constants.width,
                              ),
                              child: SizedBox(
                                width: double.maxFinite,
                                child: BlocConsumer<FoodOperationManagerCubit, FoodOperationManagerState>(
                                  listener: (context, state) {
                                    debugPrint(state.runtimeType.toString());
                                    if (state is AddOrUpdateOrDeleteFoodStartingState) {
                                      _showDialog(context, "Adding Food");
                                    }
                                    if (state is AddOrUpdateOrDeleteFoodsFailureState) {
                                      debugPrint(state.message);

                                      Navigator.pop(dialogContext!);
                                      _showDialog(context, state.message);
                                    }
                                    if (state is AddOrUpdateOrDeleteFoodStateSuccessState) {
                                      debugPrint(state.message);

                                      Navigator.pop(dialogContext!);
                                      _showDialog(context, state.message);
                                      Future.delayed(const Duration(seconds: 1)).then((value) => Navigator.pop(dialogContext!));
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomButton(
                                        text: AppStrings.translate(AppStrings.confirm.capitalizeFirst!),
                                        onPressed: () {
                                          uploadFood(context);
                                        });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppHeight.s30 * Constants.height,
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addFoodTextButton(BuildContext context) => TextButton(
        onPressed: () {
          if (ErrorsManagerCubit.contains(context, AppErrors.images)) {
            ErrorsManagerCubit.removeError(context, AppErrors.images);
          }
          ImagePickerCubit.getListOfImagesEvent(context);
        },
        style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            backgroundColor: ColorsManager.transparent,
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        child: Row(
          // set widgets horizontally
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.translate(AppStrings.addPhotos.capitalizeFirst!),
              style: getSemiBoldStyle(color: ColorsManager.maximumPurple, fontSize: AppWidth.s16 * Constants.width),
            ),
            SvgPicture.asset(
              AssetsManager.add,
              color: ColorsManager.maximumPurple,
            ),
          ],
        ),
      );

  _buildTitle(BuildContext context) => CustomTextField(
      hintText: AppStrings.translate(AppStrings.title.capitalizeFirst!),
      validator: (text) {
        if (text.isNullOrEmpty) {
          ErrorsManagerCubit.addErrorType(context, AppErrors.title); // title must provided
        }
        return null; /* no error */
      },
      onSaved: (text) {
        title = text;
      },
      onChanged: (text) {
        if (ErrorsManagerCubit.contains(context, AppErrors.title)) {
          ErrorsManagerCubit.removeError(context, AppErrors.title);
        }
      },
      alignment: Alignment.topLeft,
      showError: ErrorsManagerCubit.contains(context, AppErrors.title),
      message: ErrorsManagerCubit.getErrorMessage(context, AppErrors.title));

  _buildDescription(BuildContext context) => CustomTextField(
        hintText: AppStrings.translate(AppStrings.description.capitalizeFirst!),
        maxLines: 3,
        validator: (description) {
          if (description.isNullOrEmpty) {
            ErrorsManagerCubit.addErrorType(context, AppErrors.description);
          }
          return null;
        },
        onSaved: (text) => description = text,
        onChanged: (text) {
          if (ErrorsManagerCubit.contains(context, AppErrors.description)) {
            ErrorsManagerCubit.removeError(context, AppErrors.description);
          }
        },
        showError: ErrorsManagerCubit.contains(context, AppErrors.description),
        message: ErrorsManagerCubit.getErrorMessage(context, AppErrors.description).capitalizeFirst,
      );

  _buildSizes() => BlocBuilder<SizesBloc, SizesState>(builder: (context, sizesFromServerState) {
        if (sizesFromServerState is LoadedSizesState) {
          for (SizeModel item in sizesFromServerState.sizes) {
            foodSizesItems.add(ItemModel(
              title: item.sizeName!,
              id: item.sizeId,
            ));
          }
        }
        return BlocBuilder<FoodSizesMangerCubit, FoodSizesManagerState>(
          builder: (context, addListOfSizesState) => ListView.separated(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.zero,
              itemCount: addListOfSizesState.foodSizeList.length + 1,
              itemBuilder: (context, index) {
                List<ItemModel> list = List.generate(
                  foodSizesItems.length,
                  (index) => ItemModel(
                    title: foodSizesItems[index].title,
                    id: foodSizesItems[index].id,
                    active: index == 0,
                  ),
                );
                if (index == addListOfSizesState.foodSizeList.length) {
                  return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppWidth.s10 * Constants.width,
                      ),
                      child: _buildAddFoodSize(context, sizesFromServerState));
                }

                return SizeItem(
                  sizes: list,
                  isLoaded: sizesFromServerState is LoadedSizesState,
                  foodSize: addListOfSizesState.foodSizeList[index],
                  onSave: (SizeModel? foodSize) {
                    if (foodSize != null) {
                      FoodSizesMangerCubit.changeFoodSize(context: context, foodSize: foodSize, index: index);
                      foodSizesList.add(foodSize);
                    }
                  },
                  onCancel: () {
                    FoodSizesMangerCubit.removeEvent(
                      context: context,
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                if (index == _selectedSizes.length - 1) {
                  return SizedBox(
                    height: AppHeight.s30 * Constants.height,
                  );
                }
                return Divider(
                  color: ColorsManager.black.withOpacity(0.1),
                  height: AppHeight.s37 * Constants.height,
                );
              }),
        );
      });

  _buildAddFoodSize(BuildContext context, sizesFromServerState) => CustomTileButton(
        text: AppStrings.translate(AppStrings.addFood),
        suffixAsset: AssetsManager.add,
        onTap: () {
          if (sizesFromServerState is LoadedSizesState) {
            SizeModel foodSize = SizeModel();
            FoodSizesMangerCubit.addEvent(
              context: context,
              foodSize: foodSize,
            );
          }
        },
        isLoaded: sizesFromServerState is LoadedSizesState,
      );

  Future<dynamic> _showDialog(BuildContext context, String message) => showDialog(
        context: context,
        builder: (context) {
          dialogContext = context;
          return CustomDialog(
            message: message,
          );
        },
      );
  _buildImages(BuildContext context) => BlocBuilder<ImagePickerCubit, ImagePickerState>(
        builder: (context, state) {
          if (state is LoadedListOfImagesState) {
            images.addAll(state.pickedImages);
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.fastLinearToSlowEaseIn,
            child: state is LoadedListOfImagesState
                ? Padding(
                    padding: EdgeInsets.only(
                      left: AppWidth.s10 * Constants.width,
                      right: AppWidth.s10 * Constants.width,
                      bottom: AppHeight.s20 * Constants.height,
                    ),
                    child: SizedBox(
                      height: AppHeight.s66 * Constants.height,
                      child: ListView.separated(
                        itemCount: state.pickedImages.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        primary: false,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) => CustomImage(
                          asset: state.pickedImages[index],
                          onDelete: () {
                            ImagePickerCubit.deleteImageFromListEvent(
                              context,
                              index,
                            );
                          },
                          onImageTapped: () {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              useSafeArea: false,
                              barrierColor: ColorsManager.black.withOpacity(0.8),
                              builder: (context) {
                                return ImagesPreviewDialog(
                                  images: state.pickedImages,
                                  initialPage: index,
                                  onBackPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            );
                          },
                        ),
                        separatorBuilder: (BuildContext context, int index) => SizedBox(
                          width: AppWidth.s10 * Constants.width,
                        ),
                      ),
                    ),
                  )
                : null,
          );
        },
      );
  _buildCategories(BuildContext context) => BlocBuilder<CategoriesManagerCubit, CategoriesManagerState>(
        builder: (context, state) {
          debugPrint(state.runtimeType.toString());
          List<ItemModel> items = [];
          if (state is CategoriesLoadedState) {
            for (CategoryEntity element in state.categories) {
              items.add(ItemModel(
                title: element.categoryName!,
                id: element.categoryId,
              ));
            }
          }

          return CustomDropDown(
            text: AppStrings.translate(AppStrings.addCategories),
            items: items,
            isLoaded: state is CategoriesLoadedState,
            selectedTags: (List<ItemModel> selected) {
              if (ErrorsManagerCubit.contains(context, AppErrors.tags)) {
                ErrorsManagerCubit.removeError(context, AppErrors.tags);
              }
              for (ItemModel element in selected) {
                tags.add(element.id!);
              }
            },
          );
        },
      );
  uploadFood(BuildContext context) async {
    formKey.currentState!.validate();
    Utils.hideKeyboard();
    if (tags.isEmpty) {
      ErrorsManagerCubit.addErrorType(context, AppErrors.tags);
    }
    if (images.isEmpty) {
      ErrorsManagerCubit.addErrorType(context, AppErrors.images);
    }
    if (!ErrorsManagerCubit.hasErrors(context)) {
      formKey.currentState!.save();
      UserModel? user = await UserCubit.getUserFromStorage(context);
      FoodOperationManagerCubit.addFoodEvent(
        context: context,
        food: FoodPostModel(
          userId: (await UserCubit.getUserFromStorage(context))!.userId,
          foodName: title!,
          description: description!,
          longitude: '22.8',
          latitude: '88',
          price: 50,
          sizes: foodSizesList,
          categories: tags,
          images: images.map((e) => File(e).path).toList(),
        ),
      );
    }

    /*  Navigator.of(context)
                                      .pushNamed(Routes.myFoodsRoute);*/
  }
}
