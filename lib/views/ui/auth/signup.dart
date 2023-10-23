import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/auth/signup_model.dart';
import 'package:jobhub/views/common/app_style.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../common/app_bar.dart';
import '../../common/custom_btn.dart';
import '../../common/custom_textfield.dart';
import '../../common/height_spacer.dart';
import '../../common/reusable_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
 
 final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Consumer<SignUpNotifier>(
      builder: (context, signUpNotifier, child){
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: CustomAppBar(
                text: "Sign Up",
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(CupertinoIcons.arrow_left),
                ),
              )),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: signUpNotifier.signupFormKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const HeightSpacer(size: 50),
                  ReusableText(
                      text: "Hello, Welcome!",
                      style: appstyle(30, Color(kDark.value), FontWeight.w600)),
                  ReusableText(
                      text: "Fill the details to signup to for an account!",
                      style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600)),
                  const HeightSpacer(size: 50),
                  CustomTextField(
                    controller: name,
                    hintText: "Full Name",
                    keyboardType: TextInputType.text,
                    validator: (name) {
                      if (name!.isEmpty) {
                        return "Please enter your name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: email,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty || !email.contains("@")) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: password,
                    hintText: "Password",
                    keyboardType: TextInputType.text,
                    obscureText: signUpNotifier.isObsecure,
                    validator: (password) {
                      if (signUpNotifier.passwordValidator(password??"")) {
                        return "Please enter a valid password with at least one upper case, on lowercase, one digit, a special character and length of 8 characters";
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: GestureDetector(
                      onTap: (){
                        signUpNotifier.isObsecure = !signUpNotifier.isObsecure;
                      },
                      child: Icon(
                        signUpNotifier.isObsecure? Icons.visibility: Icons.visibility_off,
                        color: Color(kDark.value),
                      ),
                    ),
                  ),
                  const HeightSpacer(size: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Get.to(()=> const LoginPage());
                      },
                      child: ReusableText(
                          text: "Login",
                          style: appstyle(14, Color(kDark.value), FontWeight.w500)),
                    ),
                  ),
                  const HeightSpacer(size: 50),
                  CustomButton(
                      onTap: (){
                        loginNotifier.firstTime = !loginNotifier.firstTime;
                        if(signUpNotifier.validateAndSave()){
                          SignupModel model = SignupModel(username: name.text, email: email.text, password: password.text);
                          signUpNotifier.upSignup(model);
                        }else{
                          Get.snackbar("Sign Failed", "Please Check your credentials",
                              colorText: Color(kLight.value),
                              backgroundColor: Colors.red,
                              icon: const Icon(Icons.add_alert));
                        }
                      },
                      text: "Sign Up"
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}