// To parse this JSON data, do
//
//     final bookmarkReqRes = bookmarkReqResFromJson(jsonString);

import 'dart:convert';

BookmarkReqRes bookmarkReqResFromJson(String str) => BookmarkReqRes.fromJson(json.decode(str));


class BookmarkReqRes {
    String job;

    BookmarkReqRes({
        required this.job,
    });

    factory BookmarkReqRes.fromJson(Map<String, dynamic> json) => BookmarkReqRes(
        job: json["job"],
    );

    Map<String, dynamic> toJson() => {
        "job": job,
    };
}
