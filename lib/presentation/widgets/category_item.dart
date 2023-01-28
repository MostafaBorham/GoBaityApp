import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yallabaity/application/app_api_constants/api_constants.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/fonts_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/shimmer_widget.dart';

import '../../domain/entities/requests_entites/category_entity.dart';

class CategoryItem extends StatelessWidget {
  final CategoryEntity? category;
  final int? index;
  final void Function()? onTap;
  final bool isLoaded;
  const CategoryItem({this.category, this.index,this.isLoaded=false, this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppWidth.s80*Constants.width,
      height: AppWidth.s80*Constants.width,
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: onTap,
        child: isLoaded?Column(//set widgets vertically
          children: [
            Container(
              width: AppWidth.s53*Constants.width,
              height: AppHeight.s53*Constants.height,
              clipBehavior: Clip.antiAliasWithSaveLayer,// is used to clip the internal child widget of container when u define border radius,
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),

              //        backgroundColor: Color.,
              child: Image.network(
                ApiConstants.fullUrl + category!.imagePath!,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: AppWidth.s35*Constants.width,
              width: AppWidth.s100*Constants.width,
              alignment: AlignmentDirectional.bottomCenter,
              child: AutoSizeText(
                category!.categoryName!,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: getSemiBoldStyle(fontSize: 13, height: 2,),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ):Column(//set widgets vertically
          children: [
            ShimmerWidget.fromCircular(
              radius: AppWidth.s53 * Constants.width / 2,
            ),
            SizedBox(
              height: AppHeight.s10 * Constants.height,
            ),
            ShimmerWidget(
              height: AppHeight.s10 * Constants.height,
              width: AppWidth.s40 * Constants.width,
            )
          ],
        ),
      ),
    );
  }
}
