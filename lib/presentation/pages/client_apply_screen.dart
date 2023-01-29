import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallabaity/application/app_failures/app_errors.dart';
import 'package:yallabaity/network_layer/models/data_models/user_model.dart';
import 'package:yallabaity/presentation/manager/cubit_errors/errors_manager_cubit.dart';
import 'package:yallabaity/presentation/pages/verification_screen.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/fonts_manager.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/custom_background.dart';
import 'package:yallabaity/presentation/widgets/custom_subtitle.dart';
import 'package:yallabaity/presentation/widgets/custom_textfield.dart';
import 'package:yallabaity/presentation/widgets/custom_title.dart';
import 'package:yallabaity/presentation/widgets/custom_button.dart';
import 'package:yallabaity/presentation/widgets/password_textfield.dart';
import 'package:yallabaity/presentation/widgets/phone_textfield.dart';

import '../../application/app_failures/app_errors.dart';

class ClientApplyScreen extends StatelessWidget {
  ClientApplyScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey();
  String? name;
  String? password;
  String? phone;
  @override
  Widget build(BuildContext context) {
   debugPrint('build all');
    return Scaffold(
      backgroundColor: ColorsManager.black,
      body: BlocProvider(
        create: (context) => ErrorsManagerCubit(),
        child: CustomBackground(
          onBackBtnPressed: () {},
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: TweenAnimationBuilder(
              tween: Tween<Offset>(begin:Offset(Constants.zero, Constants.height),end: Offset(Constants.zero, Constants.height*AppHeight.s5)),
              duration: Duration(milliseconds: Constants.dm2),
              builder: (context,Offset value, child) {
                return Transform.translate(offset: value,child: child,);
              },
              child: Column(
                //set widgets vertically
                children: [
                  SizedBox(
                    height: AppHeight.s31 * Constants.height,
                  ),
                  CustomTitle(text: AppStrings.translate(AppStrings.createAccount)),
                  SizedBox(
                    height: AppHeight.s10 * Constants.height,
                  ),
                  CustomRichText(
                    text: AppStrings.translate(AppStrings.alreadyHaveAccount),
                    btnText: AppStrings.translate(AppStrings.login),
                    textBtnColor: ColorsManager.maximumPurple,
                    onPressed: () {
                      _onLoginButtonPressed(context);
                    },
                  ),
                  SizedBox(
                    height: AppHeight.s38 * Constants.height,
                  ),
                  Column(
                    //set widgets vertically
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidth.s33 * Constants.width),
                        child: _buildInputFormField(context),
                      ),
                      SizedBox(
                        height: AppHeight.s27 * Constants.height,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidth.s40 * Constants.width),
                        child: Text(
                          AppStrings.translate(AppStrings.agreeSigningUp),
                          textAlign: TextAlign.center,
                          style: getMediumStyle(
                              fontSize: 13, color: ColorsManager.eerieBlack),
                        ),
                      ),
                      SizedBox(
                        height: AppHeight.s30 * Constants.height,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildInputFormField(BuildContext context) =>
      BlocConsumer<ErrorsManagerCubit, ErrorsManagerState>(
        listener: (context, state) {},
        builder: (context, state) {
         debugPrint('rebuild');
         debugPrint('$context');
          return Form(
              key: formKey,
              child: Column(//set widgets vertically
                children: [
                  _buildNameWidget(context),
                  SizedBox(
                    height: AppHeight.s10 * Constants.height,
                  ),
                  _buildPhoneWidget(context),
                  SizedBox(
                    height: AppHeight.s10 * Constants.height,
                  ),
                  _buildPasswordWidget(context),
                  SizedBox(
                    height: AppHeight.s30 * Constants.height,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Constants.margin),
                    child: _buildRegisterBtn(context),
                  ),
                ],
              ));
        },
      );
  _buildRegisterBtn(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomButton(
        text: AppStrings.translate(AppStrings.register),
        onPressed: () {
          _buildOnRegisterButtonPressed(context);
        },
      ),
    );
  }

  _onLoginButtonPressed(BuildContext context) =>
      Navigator.of(context).pushNamed(Routes.loginRoute);

  _buildPasswordWidget(BuildContext context) => PasswordTextField(
        text: AppStrings.translate(AppStrings.createPassword),
        showError: ErrorsManagerCubit.contains(context, AppErrors.password),
        message:
            ErrorsManagerCubit.getErrorMessage(context, AppErrors.password),
        validator: (text) {
          if (text!.isEmpty || text.length < 8) {
            ErrorsManagerCubit.addErrorType(context, AppErrors.password);
          }
          return null;
        },
        onSaved: (text) {
          password = text;
        },
        onChanged: (text) {
          if (ErrorsManagerCubit.contains(context, AppErrors.password)) {
            ErrorsManagerCubit.removeError(context, AppErrors.password);
          }
        },
      );

  _buildPhoneWidget(BuildContext context) => PhoneTextField(
        showError: ErrorsManagerCubit.contains(context, AppErrors.phoneEmpty) ||
            ErrorsManagerCubit.contains(context, AppErrors.phoneInvalid),
        message: ErrorsManagerCubit.contains(context, AppErrors.phoneEmpty)
            ? ErrorsManagerCubit.getErrorMessage(context, AppErrors.phoneEmpty)
            : ErrorsManagerCubit.contains(context, AppErrors.phoneInvalid)
                ? ErrorsManagerCubit.getErrorMessage(
                    context, AppErrors.phoneInvalid)
                : null,
        validator: (text) {
          if (text!.isEmpty) {
            ErrorsManagerCubit.addErrorType(context, AppErrors.phoneEmpty);
          } else if (text.length != 10) {
            ErrorsManagerCubit.addErrorType(
              context,
              AppErrors.phoneInvalid,
            );
          }
          return null;
        },
        onSaved: (text) {
          phone = text;
        },
        onChanged: (text) {
          if (ErrorsManagerCubit.contains(context, AppErrors.phoneEmpty)) {
            ErrorsManagerCubit.removeError(context, AppErrors.phoneEmpty);
          }
          if (text.length == 10 &&
              ErrorsManagerCubit.contains(context, AppErrors.phoneInvalid)) {
            ErrorsManagerCubit.removeError(context, AppErrors.phoneInvalid);
          }
        },
      );

  _buildNameWidget(BuildContext context) => CustomTextField(
        hintText: AppStrings.translate(AppStrings.name),
        showError: ErrorsManagerCubit.contains(context, AppErrors.name),
        message: ErrorsManagerCubit.getErrorMessage(context, AppErrors.name),
        validator: (text) {
          if (text!.isEmpty) {
            ErrorsManagerCubit.addErrorType(context, AppErrors.name);
          }
          return null;
        },
        onSaved: (text) {
          name = text;
        },
        onChanged: (text) {
          if (ErrorsManagerCubit.contains(context, AppErrors.name)) {
            ErrorsManagerCubit.removeError(context, AppErrors.name);
          }
        },
      );

  void _buildOnRegisterButtonPressed(BuildContext context) {
    formKey.currentState!.validate();
   debugPrint(ErrorsManagerCubit.hasErrors(context).toString());
    if (!ErrorsManagerCubit.hasErrors(context)) {
      formKey.currentState!.save();
     debugPrint(name);
     debugPrint(phone);
     debugPrint(password);
      Navigator.pushNamed(context, Routes.verificationRoute, arguments: {
        VerificationScreen.userInfo: UserModel(
          userId: 0,
          userName: name,
          password: password,
          phone: '0$phone',
        ),
        VerificationScreen.userLoginOrRegister: AppStrings.translate(AppStrings.register)
      });
    }
  }
}
