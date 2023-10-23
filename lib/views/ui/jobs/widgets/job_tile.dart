import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/width_spacer.dart';

import '../../../../models/response/jobs/jobs_response.dart';
import '../job_page.dart';

class VerticalTileWidget extends StatelessWidget {
  const VerticalTileWidget({super.key, required this.job});

  final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {
          Get.to(()=>  JobPage(title: job.company, id: job.id));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          height: height * 0.15,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(kLightGrey.value),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(job.imageUrl),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(text: job.company, style: appstyle(20.sp, Color(kDark.value), FontWeight.w600)),
                      SizedBox(
                        width: width*0.5,
                        child: ReusableText(text: job.title, style: appstyle(20.sp, Color(kDarkGrey.value), FontWeight.w600)),
                      ),

                    ],

                  ),
                  CircleAvatar(
                    radius: 18,
                    child: Icon(Ionicons.chevron_forward, color: Color(kOrange.value),),

                  )

                ],
              ),
              Padding(
                  padding: EdgeInsets.only(left: 75.w),
                child: Row(
                  children: [
                    ReusableText(text: job.salary, style: appstyle(22.sp, Color(kDark.value), FontWeight.w600)),
                    ReusableText(text: "/${job.period}", style: appstyle(22.sp, Color(kDarkGrey.value), FontWeight.w600)),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
