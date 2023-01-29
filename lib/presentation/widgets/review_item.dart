import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yallabaity/network_layer/models/data_models/review_model.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/fonts_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/gobaity_app.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';

class ReviewItem extends StatelessWidget {
  ReviewModel? review;
  ReviewItem({super.key, this.review});
  @override
  Widget build(BuildContext context) {
    return Column(//set widgets vertically
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            height: AppWidth.s30 * Constants.width,
            width: AppWidth.s30 * Constants.width,
            child: IconButton(
                onPressed: () {
                 debugPrint('yes');
                },
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(
                  Icons.edit,
                  color: ColorsManager.black.withOpacity(0.19),
                )),
          ),
        ),
        SizedBox(
          height: AppHeight.s2 * Constants.height,
        ),
        Row(// set widgets horizontally
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${review!.userName}',
              style: getSemiBoldStyle(
                color: ColorsManager.eerieBlack,
                fontSize: AppWidth.s17 * Constants.width,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: AppWidth.s29 * Constants.width),
              child: Text(
                review!.ratingDate!,
                style: getMediumStyle(fontSize: AppWidth.s13 * Constants.width, color: ColorsManager.eerieBlack),
              ),
            ),
          ],
        ),
        SizedBox(
          height: AppHeight.s7 * Constants.height,
        ),
        Text(
          '${review!.description}',
          style: getMediumStyle(fontSize: AppWidth.s14*Constants.width, color: ColorsManager.graniteGray),
        ),
        SizedBox(
          height: AppHeight.s3*Constants.height,
        ),
        RatingBarIndicator(
          rating: review!.rating!,
          unratedColor: ColorsManager.graniteGray,
          itemSize: AppWidth.s18 * Constants.width,
          itemCount: 3,
          direction: Axis.horizontal,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: ColorsManager.sunglow,
          ),
        )
      ],
    );
  }
}
