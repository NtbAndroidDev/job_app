import 'package:http/http.dart' as https;
import 'package:jobhub/models/response/jobs/get_job.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class JobsHelper {
  static var client = https.Client();

  static Future<List<JobsResponse>> getAllJobs() async {


    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.jobs);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var jobsList = jobsResponseFromJson(response.body);
      return jobsList;
    } else {
      throw Exception("Failed to get the jobs");
    }
  }


  static Future<JobsResponse> getRecent() async {


    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.jobs);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var jobsList = jobsResponseFromJson(response.body);
      var recent = jobsList.first;
      return recent;
    } else {
      throw Exception("Failed to get the jobs");
    }
  }



  static Future<GetJobRes> getJob(String jobId) async {


    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.jobs}/$jobId");
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var job = getJobResFromJson(response.body);
      return job;
    } else {
      throw Exception("Failed to get a job");
    }
  }

  static Future<List<JobsResponse>> searchJobs(String keySearch) async {


    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.search}/$keySearch");
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var jobsList = jobsResponseFromJson(response.body);
      return jobsList;
    } else {
      throw Exception("Failed to get the jobs");
    }
  }


}
