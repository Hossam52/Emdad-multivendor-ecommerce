import 'package:emdad/modules/auth_module/screens/register_view/register_screen.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/background_stack.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/custom_update_profile_app_bar.dart';
import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/update_profile_text_field.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizedBox = SizedBox(
      height: SharedMethods.getHeightFraction(context, 0.03),
    );
    return Scaffold(
      body: GestureDetector(
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
                  title: 'تغيير الرقم السري',
                ),
                sizedBox,
                UpdateProfileTextField(
                  hint: 'Enter old password',
                  textEditingController: TextEditingController(),
                  label: 'Old password',
                ),
                UpdateProfileTextField(
                  hint: 'Enter the new password',
                  textEditingController: TextEditingController(),
                  label: 'New password',
                ),
                UpdateProfileTextField(
                  hint: 'Enter confirmation password',
                  textEditingController: TextEditingController(),
                  label: 'Confirm password',
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 5,
                  endIndent: SharedMethods.getWidthFraction(context, 0.3),
                  indent: SharedMethods.getWidthFraction(context, 0.3),
                ),
                sizedBox,
                CustomButton(
                  onPressed: () {},
                  backgroundColor: AppColors.primaryColor,
                  text: 'Send confirmation',
                  height: SharedMethods.getHeightFraction(context, 0.1),
                  textStyle: primaryTextStyle().copyWith(color: Colors.white),
                ),
                sizedBox,
                Center(
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: const Text('Forget password?'),
                  ),
                ),
                SizedBox(
                    height: SharedMethods.getHeightFraction(context, 0.05)),
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
                              ..onTap =
                                  () => navigateTo(context, RegisterScreen()),
                            style: secondaryTextStyle()
                                .copyWith(color: AppColors.myOrangeColor))
                      ])),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
