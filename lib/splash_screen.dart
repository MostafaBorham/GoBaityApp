import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallabaity/application/app_prefs.dart';
import 'package:yallabaity/presentation/manager/cubit_user_manager/cubit_user.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/injection_container.dart' as di;

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  AppPrefs appPrefs = di.getIt<AppPrefs>();
  /*  late AnimationController _translationAnimationController;

  late AnimationController _opacityAnimationController;

  late Animation<double> _translationAnimation;

  late Animation<double> opacityAnimation;

  _translationAnimationEffect() {
    _translationAnimationController.forward();
    _translationAnimationController.addListener(() {
      setState(() {});
    });
    _translationAnimationController.addStatusListener((AnimationStatus status) {
      if (AnimationStatus.completed == status) {
        //  _animation.forward();
        _opacityAnimationEffect();
      }
    });
  }

  _opacityAnimationEffect() {
    _opacityAnimationController.forward();
    _opacityAnimationController.addListener(() {
      setState(() {});
    });
    _opacityAnimationController.addStatusListener((AnimationStatus status) {
      if (AnimationStatus.completed == status) {

        Navigator.of(context).pushReplacementNamed(Routes.homeRoute);

      }
    });
  }*/
/*   goNext()async{
     //debugPrint(await appPrefs.isUserLoggedIn);
   }
  @override
  void initState() {
*/ /*    _translationAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _translationAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _translationAnimationController,
        curve: Curves.linearToEaseOut));
    _opacityAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _opacityAnimationController, curve: Curves.linearToEaseOut));
    _translationAnimationEffect(); */ /*    goNext();
    super.initState();

  }*/
  getUser(BuildContext context){
     UserCubit.getUserEvent(context);
  }
  @override
  Widget build(BuildContext context) {

    //getUser(context);
   debugPrint('sppppppppppppppps');
    Constants.height = MediaQuery.of(context).size.height;
    Constants.width = MediaQuery.of(context).size.width;
    Constants.margin = AppWidth.s23 * Constants.width;
    return Scaffold(
      backgroundColor: ColorsManager.steelPink,
      body: BlocListener<UserCubit,UserState>(
        listener: (context, state) {
         debugPrint(state.runtimeType.toString());
          if (state is AlreadyLoggedInState) {
            Timer(
              const Duration(seconds: 4),
              () {
                Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
                debugPrint('user is not registered');
              },
            );
          }
          if (state is NewUserState) {
            Timer(
              const Duration(seconds: 4),
              () {
                Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
                debugPrint('user is logged in');

              },
            );
          }
        },
        child: Center(
          child: Column(//set widgets vertically
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Constants.height * AppHeight.s100,
                child: Image.asset(
                  AssetsManager.gobaity1,
                ),
              ),
              SizedBox(
                height: AppHeight.s20 * Constants.height,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: AutoSizeText(
                  AppStrings.slogan,
                  style: getRegularStyle(fontSize: 15, color: ColorsManager.white),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
