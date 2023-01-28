import 'package:flutter/material.dart';
import 'package:yallabaity/application/types.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/shimmer_widget.dart';

import '../../network_layer/models/data_models/size_model.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import 'custom_checkbox.dart';
import 'food_size_item.dart';

class FoodSizesListWidget extends StatelessWidget {
  final bool? isLoaded;
  final List<SizeModel>? sizesList;
  final void Function(int index, int quantity)? onAddToCartPressed;
  final bool? isAdding;
  final Function(int index, int value)? onIncrementAndDecrementChange;
  final String buttonText;
  final bool showCircular;
  final Color buttonColor;
  const FoodSizesListWidget({
    this.sizesList,
    this.onIncrementAndDecrementChange,
    this.onAddToCartPressed,
    required this.showCircular,
    this.buttonColor = ColorsManager.maximumPurple,
    Key? key,
    this.buttonText = AppStrings.addToCart,
    this.isLoaded,
    this.isAdding,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int whichItem = 0;
    return isLoaded!
        ? ListView.separated(
            primary: false,
            itemCount: sizesList!.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => FoodSizeItem(
              foodSize: sizesList![index],
              buttonColor: sizesList![index].isAdding! ? ColorsManager.steelPink : ColorsManager.maximumPurple,
              buttonText: sizesList![index].isAdding! ? AppStrings.translate(AppStrings.adding) : AppStrings.translate(AppStrings.addToCart),
              showCircular: sizesList![index].isAdding!,

              // isAdding: isAdding! && whichItem == index,
              onCheck: (isChecked) {
                // Navigator.of(context).pushNamed(Routes.loginRoute);
              },
              onAddToCartPressed: () {
                onAddToCartPressed!(index, sizesList![index].quantity!);
              },
              onIncrementAndDecrementChange: (value) {
                sizesList![index].quantity = value;
              },
            ),
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppWidth.s17 * Constants.width,
              ),
              child: Divider(
                thickness: AppWidth.s1,
                height: AppHeight.s10 * Constants.height,
                color: ColorsManager.black.withOpacity(0.1),
              ),
            ),
          )
        : _buildFoodSizeShimmer();
  }

  _buildFoodSizeShimmer() => Column(//set widgets vertically
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidth.s25 * Constants.width),
            child: Row(// set widgets horizontally
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget.fromCircular(
                  radius: AppWidth.s14 * Constants.width,
                ),
                SizedBox(
                  width: AppWidth.s21 * Constants.width,
                ),
                Column(//set widgets vertically
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShimmerWidget(
                      height: AppHeight.s12 * Constants.height,
                      width: AppWidth.s150 * Constants.width,
                    ),
                    SizedBox(
                      height: AppHeight.s10 * Constants.height,
                    ),
                    ShimmerWidget(
                      height: AppHeight.s10 * Constants.height,
                      width: AppWidth.s100 * Constants.width,
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: AppHeight.s14 * Constants.height,
          ),
          Padding(
            padding: EdgeInsets.only(left: AppWidth.s70 * Constants.width, right: AppWidth.s24 * Constants.width),
            child: ShimmerWidget(
              height: AppHeight.s12 * Constants.height,
              width: AppWidth.s200 * Constants.width,
            ),
          ),
        ],
      );
}
