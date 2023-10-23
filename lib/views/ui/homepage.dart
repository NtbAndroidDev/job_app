import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/app_style.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:jobhub/views/common/heading_widget.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/vertical_tile.dart';
import 'package:jobhub/views/ui/jobs/job_page.dart';
import 'package:jobhub/views/ui/jobs/jobs_list.dart';
import 'package:jobhub/views/ui/jobs/widgets/horizontal_tile.dart';
import 'package:jobhub/views/ui/search/searchpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return
      Consumer<JobsNotifier>(
        builder: (context, jobNotifier, child){
          jobNotifier.getAllJob();
          jobNotifier.getRecent();
          jobNotifier.getPrefs();
          return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(50.h),
                  child: CustomAppBar(
                    actions: [
                      Padding(
                        padding: EdgeInsets.all(12.h),
                        child:  CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(jobNotifier.img),
                        ),
                      )
                    ],
                    child: Padding(
                      padding: EdgeInsets.all(12.0.h),
                      child: const DrawerWidget(),
                    ),
                  )),
              body:
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeightSpacer(size: 10),
                        Text("Search \n Find & Apply",
                          style: appstyle(40, Color(kDark.value), FontWeight.bold),),
                        const HeightSpacer(size: 40),
                        SearchWidget(
                          onTap: () {
                            Get.to(() => const SearchPage());
                          },
                        ),
                        const HeightSpacer(size: 30),
                        HeadingWidget(
                          onTap: () {
                            Get.to(() => const JobListPage());
                          },
                          text: "Popular Jobs",
                        ),

                        const HeightSpacer(size: 15),
                        SizedBox(
                          height: height * 0.28,
                          child: FutureBuilder(
                            future: jobNotifier.jobList,
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
                                    itemCount: jobs!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final job = jobs[index];
                                      return JobHorizontalTile(
                                        onTap: () {
                                          Get.to(()=>  JobPage(title: job.company, id: job.id));
                                        },
                                        job: job,
                                      );
                                    }
                                );
                              }
                            },
                          ),
                        ),
                        const HeightSpacer(size: 20),


                        HeadingWidget(
                          onTap: () {

                          },
                          text: "Recently Posed",
                        ),

                        const HeightSpacer(size: 20),
                        FutureBuilder(
                          future: jobNotifier.recent,
                          builder: (context, snapshot){
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text("Error ${snapshot.error}");
                            }else{
                              final recent = snapshot.data;
                              return VerticalTile(
                                onTap: (){
                                  Get.to(()=>  JobPage(title: recent!.company, id: recent.id));
                                },
                                recent: recent,
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )

          );
        },
      );

  }
}
