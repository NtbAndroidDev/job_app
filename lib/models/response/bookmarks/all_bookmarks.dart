// To parse this JSON data, do
//
//     final allBookmark = allBookmarkFromJson(jsonString);

import 'dart:convert';

List<AllBookmark> allBookmarkFromJson(String str) => List<AllBookmark>.from(json.decode(str).map((x) => AllBookmark.fromJson(x)));


class AllBookmark {
    Job job;
    String userId;

    AllBookmark({
        required this.job,
        required this.userId,
    });

    factory AllBookmark.fromJson(Map<String, dynamic> json) => AllBookmark(
        job: Job.fromJson(json["job"]),
        userId: json["userId"],
    );

  
}

class Job {
    String id;
    String title;
    String location;
    String company;
    String salary;
    String period;
    String contract;
    List<String> requirements;
    String imageUrl;
    String agentId;

    Job({
        required this.id,
        required this.title,
        required this.location,
        required this.company,
        required this.salary,
        required this.period,
        required this.contract,
        required this.requirements,
        required this.imageUrl,
        required this.agentId,
    });

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        company: json["company"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        imageUrl: json["imageUrl"],
        agentId: json["agentId"],
    );

}
