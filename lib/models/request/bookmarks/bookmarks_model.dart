import 'dart:convert';

BookmarkReqModel bookmarkReqModelFromJson(String str) => BookmarkReqModel.fromJson(json.decode(str));

String bookmarkReqModelToJson(BookmarkReqModel data) => json.encode(data.toJson());

class BookmarkReqModel {
    String job;

    BookmarkReqModel({
        required this.job,
    });

    factory BookmarkReqModel.fromJson(Map<String, dynamic> json) => BookmarkReqModel(
        job: json["job"],
    );

    Map<String, dynamic> toJson() => {
        "job": job,
    };
}
