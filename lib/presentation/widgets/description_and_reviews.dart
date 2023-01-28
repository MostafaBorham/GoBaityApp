import 'package:flutter/material.dart';
import 'package:yallabaity/network_layer/models/data_models/review_model.dart';
import 'package:yallabaity/presentation/widgets/review_item.dart';
import 'package:yallabaity/presentation/widgets/shimmer_widget.dart';

import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class DescriptionAndReviews extends StatefulWidget {
  final String? description;
  final List<ReviewModel>? reviews;
  final bool? isLoaded;
  const DescriptionAndReviews({this.isLoaded=false,required this.description,this.reviews,Key? key}) : super(key: key);

  @override
  State<DescriptionAndReviews> createState() => _DescriptionAndReviewsState();
}

class _DescriptionAndReviewsState extends State<DescriptionAndReviews> with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.isLoaded!?DecoratedBox(
      decoration: BoxDecoration(color: ColorsManager.maximumPurple.withOpacity(0.06), borderRadius: BorderRadius.circular(23)),
      child: Column(//set widgets vertically
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: tabController,
            indicatorColor: ColorsManager.maximumPurple,
            physics: BouncingScrollPhysics(),
            labelColor: ColorsManager.maximumPurple,
            unselectedLabelColor: ColorsManager.black,
            labelStyle: getSemiBoldStyle(color: ColorsManager.black, fontSize: AppWidth.s14 * Constants.width),
            unselectedLabelStyle: getMediumStyle(color: ColorsManager.white, fontSize: AppWidth.s14 * Constants.width),
            padding: EdgeInsets.symmetric(vertical: Constants.height * 0.01, horizontal: Constants.margin),
            tabs: [
              Tab(
                text: 'Description',
              ),
              Tab(
                text: 'Reviews',
              ),
            ],
          ),
          Container(
            height: AppHeight.s337 * Constants.height,
            padding: EdgeInsets.symmetric(horizontal: AppWidth.s24 * Constants.width),
            child: TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: AppHeight.s22 * Constants.height),
                    child: Text(
                      widget.description!,
                      style: getMediumStyle(color: ColorsManager.graniteGray, fontSize: AppWidth.s15 * Constants.width),
                    ),
                  ),
                ),
                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.reviews!.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return ReviewItem(
                      review: widget.reviews![index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Divider(
                    height: Constants.height * 0.04,
                    color: ColorsManager.black.withOpacity(0.11),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ):ShimmerWidget(
      height: AppHeight.s337 * Constants.height,
      width: double.maxFinite,
      borderRadius:  BorderRadius.circular(23),
    );
  }
}
