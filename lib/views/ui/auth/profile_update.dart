import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:provider/provider.dart';

import '../../../controllers/exports.dart';
import '../../../models/request/auth/profile_update_model.dart';
import '../../common/custom_btn.dart';
import '../../common/custom_textfield.dart';
import '../../common/exports.dart';
import '../../common/height_spacer.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});


  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();


}

class _ProfileUpdateState extends State<ProfileUpdate> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController(text: profile[0]);
  TextEditingController skill1 = TextEditingController(text: profile[1]);
  TextEditingController skill2 = TextEditingController(text: profile[2]);
  TextEditingController skill3 = TextEditingController(text: profile[3]);
  TextEditingController skill4 = TextEditingController(text: profile[4]);

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
            text: "Update Profile",
            child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Icon(CupertinoIcons.arrow_left),
            ),
        ),
      ),
      body: Consumer<LoginNotifier>(
        builder: (context, loginNotifier, child){
          return Form(
            key: loginNotifier.profileFormKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: "Personal Details",
                        style: appstyle(35, Color(kDark.value), FontWeight.bold)),
                    Consumer<ImageUploader>(
                      builder: (context, imageUploader, child) {
                        return imageUploader.imageUrl.isEmpty
                            ? GestureDetector(
                          onTap: () {
                            imageUploader.pickImage();
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(kLightBlue.value),
                            child: const Center(
                                child: Icon(Icons.photo_filter_rounded)),
                          ),
                        )
                            : GestureDetector(
                          onTap: () {
                            imageUploader.imageUrl.clear();
                            setState(() {});
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(kLightBlue.value),
                            backgroundImage:
                            FileImage(File(imageUploader.imageUrl[0])),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const HeightSpacer(size: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: location,
                      hintText: "Location",
                      keyboardType: TextInputType.text,
                      validator: (location) {
                        if (location!.isEmpty) {
                          return "Please enter a valid location";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 20),
                    CustomTextField(
                      controller: phone,
                      hintText: "Phone",
                      keyboardType: TextInputType.phone,
                      validator: (phone) {
                        if (phone!.isEmpty) {
                          return "Please enter a valid phone";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 20),
                    ReusableText(
                        text: "Professional Skills",
                        style: appstyle(30, Color(kDark.value), FontWeight.bold)),

                    const HeightSpacer(size: 20),
                    CustomTextField(
                      controller: skill0,
                      hintText: "Professional Skills",
                      keyboardType: TextInputType.text,
                      validator: (skill0) {
                        if (skill0!.isEmpty) {
                          return "Please enter a valid skill";
                        } else {
                          return null;
                        }
                      },
                    ), //skill 1

                    const HeightSpacer(size: 20),
                    CustomTextField(
                      controller: skill1,
                      hintText: "Professional Skills",
                      keyboardType: TextInputType.text,
                      validator: (skill0) {
                        if (skill0!.isEmpty) {
                          return "Please enter a valid skill";
                        } else {
                          return null;
                        }
                      },
                    ), // skill 2

                    const HeightSpacer(size: 20),
                    CustomTextField(
                      controller: skill2,
                      hintText: "Professional Skills",
                      keyboardType: TextInputType.text,
                      validator: (skill2) {
                        if (skill2!.isEmpty) {
                          return "Please enter a valid skill";
                        } else {
                          return null;
                        }
                      },
                    ), // skill 3

                    const HeightSpacer(size: 20),
                    CustomTextField(
                      controller: skill3,
                      hintText: "Professional Skills",
                      keyboardType: TextInputType.text,
                      validator: (skill3) {
                        if (skill3!.isEmpty) {
                          return "Please enter a valid skill";
                        } else {
                          return null;
                        }
                      },
                    ),

                    /// skill 4

                    const HeightSpacer(size: 20),
                    CustomTextField(
                      controller: skill4,
                      hintText: "Professional Skills",
                      keyboardType: TextInputType.text,
                      validator: (skill4) {
                        if (skill4!.isEmpty) {
                          return "Please enter a valid skill";
                        } else {
                          return null;
                        }
                      },
                    ), //skill 5
                    const HeightSpacer(size: 20),
                    Consumer<ImageUploader>(
                        builder: (context, imageUpload, child) {
                          return CustomButton(
                              onTap: () {
                                if (loginNotifier.profileValidation()) {
                                  if (imageUpload.imageUrl.isEmpty &&
                                      imageUpload.img == null) {
                                    Get.snackbar("Image Missing",
                                        "Please upload an image to proceed",
                                        colorText: Color(kLight.value),
                                        backgroundColor: Colors.red,
                                        icon: const Icon(Icons.add_alert));
                                  } else {
                                    ProfileUpdateReq model = ProfileUpdateReq(
                                        location: location.text,
                                        phone: phone.text,
                                        profile: imageUpload.img.toString(),
                                        skills: [
                                          skill0.text,
                                          skill1.text,
                                          skill2.text,
                                          skill3.text,
                                          skill4.text,
                                        ]);

                                    loginNotifier.updateProfile(model);
                                  }
                                } else {
                                  Get.snackbar("Update Failed",
                                      "Please Check your credentials",
                                      colorText: Color(kLight.value),
                                      backgroundColor: Colors.red,
                                      icon: const Icon(Icons.add_alert));
                                }
                              },
                              text: "Update Profile");
                        }),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
