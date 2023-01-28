import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallabaity/application/app_failures/app_errors.dart';
import 'package:yallabaity/presentation/manager/cubit_errors/errors_manager_cubit.dart';
import 'package:yallabaity/presentation/pages/verification_screen.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/custom_background.dart';
import 'package:yallabaity/presentation/widgets/custom_subtitle.dart';
import 'package:yallabaity/presentation/widgets/custom_title.dart';
import 'package:yallabaity/presentation/widgets/custom_button.dart';
import 'package:yallabaity/presentation/widgets/forget_passwort.dart';
import 'package:yallabaity/presentation/widgets/password_textfield.dart';
import 'package:yallabaity/presentation/widgets/phone_textfield.dart';

import '../../application/app_failures/app_errors.dart';
import '../../network_layer/models/data_models/user_model.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  String? password;
  String? phone;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.black,
      body: BlocProvider(
          create: (context) => ErrorsManagerCubit(),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            physics: const BouncingScrollPhysics(),
            child: CustomBackground(
              onBackBtnPressed: () {
                Navigator.of(context).pop();
              },
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
                    CustomTitle(text: AppStrings.translate(AppStrings.login)),
                    SizedBox(
                      height: AppHeight.s10 * Constants.height,
                    ),
                    CustomRichText(
                      text: AppStrings.translate(AppStrings.dontHaveAccount),
                      btnText: AppStrings.translate(AppStrings.register),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.clientApplyRoute);
                      },
                    ),
                    SizedBox(
                      height: AppHeight.s38 * Constants.height,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppWidth.s33 * Constants.width),
                      child: _buildInputFormField(context),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  _buildInputFormField(BuildContext context) =>
      BlocConsumer<ErrorsManagerCubit, ErrorsManagerState>(
        builder: (context, state) => Form(
            key: formKey,
            child: Column(
              //set widgets vertically
              children: [
                _buildPhoneWidget(context),
                SizedBox(
                  height: AppHeight.s10 * Constants.height,
                ),
                _buildPasswordWidget(context),
                SizedBox(
                  height: AppHeight.s19 * Constants.height,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ForgetPassword(
                    onTap: () {},
                  ),
                ),
                SizedBox(
                  height: AppHeight.s8 * Constants.height,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: Constants.margin),
                    child: _buildLoginBtn(context))
              ],
            )),
        listener: (context, state) {},
      );

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
  _buildLoginBtn(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomButton(
        text: AppStrings.translate(AppStrings.signIn),
        onPressed: () {
          formKey.currentState!.validate();
          debugPrint(ErrorsManagerCubit.hasErrors(context).toString());
          if (!ErrorsManagerCubit.hasErrors(context)) {
            formKey.currentState!.save();
            Navigator.pushNamed(context, Routes.verificationRoute, arguments: {
              VerificationScreen.userInfo: UserModel(
                password: password,
                phone: '0$phone',
              ),
              VerificationScreen.userLoginOrRegister: AppStrings.translate(AppStrings.login)
            });
          }
          // Navigator.of(context).pushReplacementNamed(Routes.clientApplyRoute);
        },
      ),
    );
  }
}
