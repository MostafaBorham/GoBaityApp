import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallabaity/network_layer/models/item_model.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/custom_multiple_list_checkbox.dart';
import 'package:yallabaity/presentation/widgets/custom_single_list_checkbox.dart';
import 'package:yallabaity/presentation/widgets/custom_tabbar_widget.dart';
import 'package:yallabaity/presentation/widgets/tabbar_item_widget.dart';
import 'package:yallabaity/presentation/widgets/custom_button.dart';

import '../../network_layer/models/data_models/category_model.dart';
import '../manager/cubit_categories/categories_manager_cubit.dart';
import '../resources/strings_manager.dart';

class CustomBottomSheet extends StatefulWidget {
  final Function(ItemModel item)? onItemSelected;
  final Function(ItemModel item)? onCategorySelected;
  final Function()? onPressed;
  const CustomBottomSheet({this.onPressed,this.onItemSelected,Key? key, this.onCategorySelected}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int currentSelectedSortingFilterIndex=0;
  int currentSelectedCategoryFilterIndex=0;
  List<ItemModel> tabs = [
    //tabs list
    ItemModel(title: AppStrings.sorting, active: true), //sorting tab
    ItemModel(title: AppStrings.type), //type tab
  ];
  List<ItemModel> categoriesItems = [];
  List<ItemModel> sortingList = [
    ItemModel(title: 'Price : Low and average prices',id: 0),
    ItemModel(title: 'Delivery Time',id: 1),
    ItemModel(title: 'Rating',id: 2),
  ];
  List<ItemModel> categoriesList = [];

  final PageController _pageController = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return AnimatedFractionallySizedBox(
      // used to make widget height 0.75 of screen height, with animation
      duration: const Duration(milliseconds: 500), //animation duration
      heightFactor: 0.75, // widget height
      curve: Curves.bounceInOut, // widget animation when filter button is pressed
      child: Stack(
        //stack is used to show (show all results button)
        children: [
          Column(
            //set widgets vertically//set widgets vertically

            children: [
              Container(
                // draws first widget
                width: AppWidth.s44 * Constants.width, //container width
                height: AppHeight.s5 * Constants.height, //container height
                decoration:
                    BoxDecoration(color: ColorsManager.white, borderRadius: BorderRadius.circular(4)), // container border radius
              ),
              SizedBox(
                  height: AppHeight.s15 *
                      Constants.height), // vertical space between the small sized container and large sized container
              Expanded(
                // expand container
                child: Container(
                  // container widget
                  decoration: const BoxDecoration(
                      // container style
                      color: ColorsManager.white, // container color
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50), topRight: Radius.circular(50))), // container border radius
                  child: Column(
                    //set widgets vertically
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: AppHeight.s30 * Constants.height,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidth.s40 * Constants.width), // padding for the widget child widget
                        child: Row(
                          // set widgets horizontally
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              // filter text
                              AppStrings.filter, //filter constant string text
                              style: getSemiBoldStyle(
                                //text widget is semibold
                                color: ColorsManager.eerieBlack, // text color is eerie black
                                fontSize: AppWidth.s18 * Constants.width, // font size is 18
                              ),
                            ),
                            SizedBox(width: AppWidth.s75 * Constants.width), // horizontal space between filter and clear widget
                            Text(
                              // clear text
                              AppStrings.clear, //filter constant string text
                              style: getSemiBoldStyle(
                                  color: ColorsManager.eerieBlack, // text color is eerie black
                                  fontSize: AppWidth.s18 * Constants.width // font size is 18
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        // vertical space between filter,clear widget and tabs
                        height: AppHeight.s30 * Constants.height,
                      ),
                      CustomTabBarWidget( // tabs
                        itemCount: tabs.length,
                        itemBuilder: (index) {
                          return CustomTabBarItemWidget(
                            tab: tabs[index],
                            onTap: () {
                              changeItem(index);
                              _pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                            },
                          );
                        },
                      ), // tabs
                      SizedBox(
                        // vertical space between tabs and filter by text
                        height: AppHeight.s39 * Constants.height,
                      ),
                      Align(
                        // align filter by text to the left
                        alignment: Alignment.topLeft, //alignment to the left
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppWidth.s29 * Constants.width),
                          child: Text(
                            // filter by text
                            AppStrings.filterBy, //filter by constant string text
                            style: getMediumStyle(
                              color: ColorsManager.eerieBlack, // text color is eerie black
                              fontSize: AppWidth.s18 * Constants.width, // font size is 18
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        // vertical space between filter by and tabs pages
                        height: AppHeight.s24 * Constants.height,
                      ),
                      Expanded(
                        // make pages takes the available height
                        child: PageView(
                          // tab page
                          controller: _pageController, // tab controller controls, tab page
                          physics: const BouncingScrollPhysics(), //bouncing scrolling
                          onPageChanged: (index) {
                            //when tab pressed, tab item color will be changed
                            changeItem(index); // change tab item color when page changes
                          },
                          children: [
                            AnimatedContainer(
                                width: MediaQuery.of(context).size.width,
                                duration: const Duration(milliseconds: 500),
                                padding: EdgeInsets.symmetric(horizontal: AppWidth.s29 * Constants.width),
                                child: CustomSingleListCheckBox(
                                  onItemSelected: widget.onItemSelected,
                                  singleCheckBoxList: sortingList,
                                )),
                            BlocBuilder<CategoriesManagerCubit, CategoriesManagerState>(
                              builder: (context, categoriesState) {
                                if (categoriesState is CategoriesLoadedState) {
                                  categoriesList.clear();
                                  for (var element in categoriesState.categories) {
                                    categoriesList.add(ItemModel(title: element.categoryName!,id: element.categoryId));
                                  }
                                  debugPrint(categoriesList.length.toString());
                                }
                                return AnimatedContainer(
                                    width: MediaQuery.of(context).size.width,
                                    duration: const Duration(milliseconds: 500),
                                    padding: EdgeInsets.symmetric(horizontal: AppWidth.s29 * Constants.width),
                                    child: CustomSingleListCheckBox(
                                      onItemSelected: widget.onCategorySelected,
                                      singleCheckBoxList: categoriesList,
                                    ));
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: ColorsManager.cultured,
                padding: EdgeInsets.only(
                    top: AppHeight.s25 * Constants.height,
                    bottom: AppHeight.s40 * Constants.height,
                    right: Constants.margin,
                    left: Constants.margin),
                child: SizedBox(
                  width: double.maxFinite,
                  child: CustomButton(
                    text: 'Show all results',
                    onPressed: widget.onPressed,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeItem(index) {
    debugPrint(tabs[index].hashCode.toString());

    setState(() {
      if (index != currentPage) {
        tabs[currentPage].active = false;
        tabs[index].active = !tabs[index].active;
        currentPage = index;
      }
    });
  }
}
