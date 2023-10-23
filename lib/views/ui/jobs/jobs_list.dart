import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/ui/jobs/widgets/job_tile.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/custom_outline_btn.dart';
import '../../common/exports.dart';
import '../../common/height_spacer.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var jobList = Provider.of<JobsNotifier>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Jobs",
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Entypo.bookmark),
            )
          ],
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: FutureBuilder<List<JobsResponse>>(
        future: jobList.jobList,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }else{
            final jobs = snapshot.data;
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: jobs!.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return VerticalTileWidget(job: job);
                });
          }
        },
      ),
    );
  }
}
