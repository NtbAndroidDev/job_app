import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/response/auth/profile_model.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/reusable_text.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:jobhub/views/ui/auth/profile_update.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: "Profile",
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: const DrawerWidget(),
            ),
          )),
      body: Consumer<ProfileNotifier>(
        builder: (context, profileNotifier, child) {
          profileNotifier.getProfile();
          return FutureBuilder<ProfileRes>(
              future: profileNotifier.profile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final userData = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                          width: width,
                          height: height * 0.12,
                          color: Color(kLight.value),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    // borderRadius: BorderRadius.all(Radius.circular(20)),
                                    // child: Image.asset("assets/images/user.png", width: 80.w, height: 100.h,),
                                    child: CachedNetworkImage(
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(44)),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill)
                                        ),
                                      ),
                                      width: 80.w,
                                      height: 80.h,
                                      imageUrl: userData!.profile,
                                    ),
                                  ),
                                  const WidthSpacer(size: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                          text: userData!.username,
                                          style: appstyle(
                                              20,
                                              Color(kDark.value),
                                              FontWeight.w600)),
                                      Row(
                                        children: [
                                          Icon(
                                            MaterialIcons.location_pin,
                                            color: Color(kDarkGrey.value),
                                          ),
                                          const WidthSpacer(size: 5),
                                          ReusableText(
                                              text: userData.location,
                                              style: appstyle(
                                                  16,
                                                  Color(kDarkGrey.value),
                                                  FontWeight.w600)),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  profile = userData.skills;
                                  Get.to(()=> const ProfileUpdate());
                                },
                                child: const Icon(
                                  Feather.edit,
                                  size: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        const HeightSpacer(size: 20),
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color(kLightGrey.value),
                              ),
                              width: width,
                              height: height * 0.12,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 12.w),
                                    width: 60.w,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Color(kLight.value),
                                    ),
                                    child: const Icon(
                                      FontAwesome5Regular.file_pdf,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ReusableText(
                                          text: "Resume from JobHub",
                                          style: appstyle(
                                              18,
                                              Color(kDark.value),
                                              FontWeight.w500)),
                                      ReusableText(
                                          text: "Resume from JobHub",
                                          style: appstyle(
                                              16,
                                              Color(kDarkGrey.value),
                                              FontWeight.w500)),
                                    ],
                                  ),
                                  const WidthSpacer(size: 1)
                                ],
                              ),
                            ),
                            Positioned(
                                top: 2.h,
                                right: 5.w,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: ReusableText(
                                      text: "Edit",
                                      style: appstyle(16, Color(kOrange.value),
                                          FontWeight.w500)),
                                ))
                          ],
                        ),
                        const HeightSpacer(size: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(kLightGrey.value),
                          ),
                          padding: EdgeInsets.only(left: 8.w),
                          width: width,
                          height: height * 0.06,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ReusableText(
                              text: userData.email,
                              style: appstyle(
                                  16, Color(kDark.value), FontWeight.w600),
                            ),
                          ),
                        ),
                        const HeightSpacer(size: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(kLightGrey.value),
                          ),
                          padding: EdgeInsets.only(left: 8.w),
                          width: width,
                          height: height * 0.06,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/usa.svg",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                                const WidthSpacer(size: 5),
                                ReusableText(
                                  text: userData.phone,
                                  style: appstyle(
                                      16, Color(kDark.value), FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const HeightSpacer(size: 20),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(kDarkGrey.value)),
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ReusableText(
                                    text: "Skills",
                                    style: appstyle(16, Color(kDark.value),
                                        FontWeight.w600)),
                              ),
                              const HeightSpacer(size: 3),

                              //
                              SizedBox(
                                height: height * 0.5,
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 8.h),
                                    child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: userData.skills.length,
                                        itemBuilder: (context, i) {
                                          final skill = userData.skills[i];
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: width,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  color: Colors.white,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: ReusableText(
                                                    text: skill,
                                                    style: appstyle(
                                                        16,
                                                        Color(kDark.value),
                                                        FontWeight.normal)),
                                              ),
                                              const HeightSpacer(size: 10),
                                            ],
                                          );
                                        })),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              });
        },
      ),
    );
  }
}
