import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:jobhub/models/response/jobs/get_job.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/services/helpers/jobs_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class JobsNotifier extends ChangeNotifier {

  late Future<List<JobsResponse>> jobList;

  late Future<JobsResponse> recent;

  late Future<GetJobRes> job;

  String img = "";


  getAllJob(){
    jobList = JobsHelper.getAllJobs();
  }

  getRecent(){
    recent = JobsHelper.getRecent();
  }

  getJob(String jobId){
    job = JobsHelper.getJob(jobId);
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    img = prefs.getString("profile")??"";

  }
}
