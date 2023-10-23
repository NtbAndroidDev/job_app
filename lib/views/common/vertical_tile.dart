import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/width_spacer.dart';

import '../../models/response/jobs/jobs_response.dart';

class VerticalTile extends StatelessWidget {
  const VerticalTile({super.key, this.onTap, required this.recent});

  final void Function()? onTap;

  final JobsResponse? recent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          height: height*0.15,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(kLightGrey.value),

          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(kLightGrey.value),
                        radius: 30,
                        backgroundImage: NetworkImage(recent!.imageUrl),
                      ),
                      WidthSpacer(size: 10.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(text: recent!.company, style: appstyle(20.sp, Color(kDark.value), FontWeight.w600)),
                          SizedBox(
                            width: width*0.5,
                            child: ReusableText(text: recent!.title, style: appstyle(18.sp, Color(kDark.value), FontWeight.w600)),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(kLight.value),
                        child: const Icon(Ionicons.chevron_forward),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Row(
                  children: [
                    ReusableText(text: recent!.salary, style: appstyle(23.sp, Color(kDark.value), FontWeight.w600)),
                    ReusableText(text: "/${recent!.period}", style: appstyle(23.sp, Color(kDarkGrey.value), FontWeight.w600)),
                  ],
                ),
              ),

            ],
          ),
        )
    );
  }
}