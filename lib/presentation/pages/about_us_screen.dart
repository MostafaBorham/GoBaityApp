import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';

class AboutUsScreen extends StatefulWidget {
  AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  List<String> media = [
    AssetsManager.facebook,
    AssetsManager.instagram,
    AssetsManager.telegram,
  ];

  List<String> about = [
    'Lorem Ipsum is simply dummy text of thedebugPrinting and typesetting industry. Lorem Ipsum has been the industry\'s standard',
    'Lorem Ipsum is simply dummy text of thedebugPrinting and typesetting industry. Lorem Ipsum has been the industry\'s standard',
    'Lorem Ipsum is simply dummy text of thedebugPrinting and typesetting industry. Lorem Ipsum has been the industry\'s standard',
    'Lorem Ipsum is simply dummy text of thedebugPrinting and typesetting industry. Lorem Ipsum has been the industry\'s standard',
  ];
  ScrollController _scrollController = ScrollController();
  Color appBarColor = ColorsManager.transparent;
  Color appBarItemsColor = ColorsManager.eerieBlack;
  bool collapse = false;
  double height = 0;
  double width = 0;
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset > AppHeight.s119*Constants.height) {
       debugPrint(true.toString());
        setState(() {
          appBarColor = ColorsManager.maximumPurple;
          appBarItemsColor = ColorsManager.white;

          collapse = true;
          height = AppWidth.s30 * Constants.width;
          width = AppWidth.s30 * Constants.width;
        });
      } else {
        setState(() {
          collapse = false;
          appBarItemsColor = ColorsManager.eerieBlack;
          height = 0;
          width = 0;
          appBarColor = ColorsManager.transparent;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              height: AppHeight.s31*Constants.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorsManager.maximumPurple.withOpacity(0.8),
                    ColorsManager.white.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 1],
                ),
              ),
            ),
          ),
          CustomScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(),
              _buildBody(),
            ],
          ),
        ],
      ),
    );
  }

  _buildAppBar() => SliverAppBar(
        elevation: 0,
        floating: true,
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        pinned: true,
        flexibleSpace: collapse == false
            ? FlexibleSpaceBar(
                background: Column(//set widgets vertically
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top +
                          AppBar().preferredSize.height +
                          AppHeight.s51*Constants.height,
                    ),
                    SizedBox(
                      height: AppWidth.s78 * Constants.width,
                      width: AppWidth.s78 * Constants.width,
                      child: Image.asset(
                        AssetsManager.logoWithoutName,
                      ),
                    ),
                    SizedBox(
                      height: AppHeight.s43*Constants.height,
                    ),
                  ],
                ),
                titlePadding: EdgeInsets.zero,
              )
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsManager.cartAppBar),
                  ),
                ),
              ),
        expandedHeight: MediaQuery.of(context).padding.top +
            AppBar().preferredSize.height +
            AppHeight.s51*Constants.height +
            AppWidth.s78 * Constants.width +
            AppHeight.s43*Constants.height,
        toolbarHeight: AppHeight.s90*Constants.height,
        titleSpacing: AppWidth.s24 * Constants.width,
        title: Row(// set widgets horizontally
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(// set widgets horizontally
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    AssetsManager.back,
                    color: appBarItemsColor,
                  ),
                ),
                SizedBox(
                  width: AppWidth.s21*Constants.width,
                ),
                Text(
                  AppStrings.translate(AppStrings.aboutUs),
                  style: getSemiBoldStyle(
                    color: appBarItemsColor,
                    fontSize: AppWidth.s20*Constants.width,
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              height: height,
              width: width,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Image.asset(
                AssetsManager.logoWithoutName,
              ),
            ),
          ],
        ),
      );

  _buildBody() => SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppWidth.s24 * Constants.width),
          child: Column(//set widgets vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.zero,
                itemCount: about.length,
                itemBuilder: (context, index) => Text(
                  about[index],
                  style: getMediumStyle(
                      color: ColorsManager.graniteGray,
                      fontSize: AppWidth.s17 * Constants.width),
                ),
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: AppHeight.s45*Constants.height,
                ),
              ),
              SizedBox(
                height: AppHeight.s119*Constants.height,
              ),
              Text(
                'Follow us',
                style: getSemiBoldStyle(
                    fontSize: AppWidth.s17 * Constants.width,
                    color: ColorsManager.chineseBlack2),
              ),
              SizedBox(
                height: AppHeight.s10 * Constants.height,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: AppWidth.s35*Constants.width,
                children: media
                    .map((e) => SizedBox(
                        height: AppWidth.s37 * Constants.width,
                        width: AppWidth.s37 * Constants.width,
                        child: Image.asset(e)))
                    .toList(),
              ),
              SizedBox(
                height: AppHeight.s100 * Constants.height,
              )
            ],
          ),
        ),
      );
}
