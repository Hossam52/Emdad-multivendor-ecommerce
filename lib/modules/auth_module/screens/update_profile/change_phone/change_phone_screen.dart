import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/modules/auth_module/screens/register_view/register_screen.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/background_stack.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/custom_update_profile_app_bar.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/update_profile_text_field.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/ui_componants/default_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({Key? key}) : super(key: key);

  @override
  State<ChangePhoneScreen> createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  final formKey = GlobalKey<FormState>();

  final phoneNumberController = TextEditingController();
  final countryCodeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final user = AppCubit.get(context).getUser;

    phoneNumberController.text = user!.primaryPhoneNumber!.number;
    countryCodeController.text = user.primaryPhoneNumber!.countryCode;
  }

  @override
  Widget build(BuildContext context) {
    final sizedBox = SizedBox(
      height: SharedMethods.getHeightFraction(context, 0.03),
    );
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is UpdateProfileErrorState) {
                SharedMethods.showToast(context, state.error,
                    textColor: Colors.white, color: AppColors.errorColor);
              }
              if (state is UpdateProfileSuccessState) {
                SharedMethods.showToast(context, 'تم تعديل رقم الهاتف بنجاح',
                    textColor: Colors.white, color: AppColors.successColor);
              }
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  SharedMethods.unFocusTextField(context);
                },
                child: BackgroundStack(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomUpdateProfileAppBar(
                          title: 'تغيير رقم الهاتف',
                        ),
                        sizedBox,
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: UpdateProfileTextField(
                                hint: 'Enter new phone number',
                                textEditingController: phoneNumberController,
                                label: 'New phone',
                                validator: (val) {
                                  return SharedMethods.passwordValidation(val);
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: UpdateProfileTextField(
                                hint: 'Country code',
                                textEditingController: countryCodeController,
                                label: 'Country code',
                                validator: (val) {
                                  return SharedMethods.passwordValidation(val);
                                },
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 5,
                          endIndent:
                              SharedMethods.getWidthFraction(context, 0.3),
                          indent: SharedMethods.getWidthFraction(context, 0.3),
                        ),
                        sizedBox,
                        if (state is ChangePasswordLoadingState)
                          const DefaultLoader()
                        else
                          CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                AuthCubit.get(context).changePhoneNumber(
                                    phoneNumber: phoneNumberController.text);
                              }
                            },
                            backgroundColor: AppColors.primaryColor,
                            text: 'Change phone number',
                            height:
                                SharedMethods.getHeightFraction(context, 0.1),
                            textStyle: primaryTextStyle()
                                .copyWith(color: Colors.white),
                          ),
                        sizedBox,
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                            ),
                            child: const Text('Forget password?'),
                          ),
                        ),
                        SizedBox(
                            height:
                                SharedMethods.getHeightFraction(context, 0.05)),
                        Center(
                          child: RichText(
                              text: TextSpan(
                                  text: 'Don\'t have account? ',
                                  style: secondaryTextStyle()
                                      .copyWith(color: Colors.black),
                                  children: [
                                TextSpan(
                                    text: 'Register now',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          navigateTo(context, RegisterScreen()),
                                    style: secondaryTextStyle().copyWith(
                                        color: AppColors.myOrangeColor))
                              ])),
                        )
                      ],
                    ),
                  ),
                )),
              );
            },
          ),
        ),
      ),
    );
  }
}