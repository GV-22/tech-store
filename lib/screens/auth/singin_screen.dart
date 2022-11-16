import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/provider/user_provider.dart';
import 'package:responsive_app/screens/main_board.dart';
import 'package:responsive_app/utils/form_item.dart';
import 'package:responsive_app/utils/helpers.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/form/f_password_field.dart';
import 'package:responsive_app/widgets/form/f_text_field.dart';
import 'package:responsive_app/widgets/system/fill_btn.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "/auth/signin/";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailItem = FormItem.validEmail();
  final _passwordItem = FormItem.validPassword();

  // bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final device = getDeviceSize(context).width;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          alignment: isMobile ? null : Alignment.center,
          child: SizedBox(
            width: isMobile ? null : device * .4,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Happy to see you again",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: isMobile ? 18 : 28,
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  Form(
                    key: _formKey,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        FTextField(
                          formItem: _emailItem,
                          inputType: TextInputType.emailAddress,
                          label: "email",
                        ),
                        SizedBox(height: 12.sp),
                        FPasswordField(
                          label: "password",
                          formItem: _passwordItem,
                          onSubmitted: (_) => _submit(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  FillBtn(label: "Login", onPressed: _submit),
                  SizedBox(height: 16.sp),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 8.sp),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot password ?",
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_formKey.currentState!.validate()) return;

    Provider.of<UserProvider>(context, listen: false).login(_emailItem.value!);
    Navigator.of(context).pushReplacementNamed(MainBoard.routeName);
  }
}
