import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RandomData extends Equatable {
  final List<File> imageFile;
  final String comments;
  final String date;
  final String area;
  final String task;
  final String tags;
  final String events;

  const RandomData(
      {required this.imageFile,
      required this.comments,
      required this.date,
      required this.area,
      required this.task,
      required this.tags,
      required this.events});

  Future sendRandomData() async {
    List<String> base64Images = [];

    for (var element in imageFile) {
      base64Images.add(fileToBase64(element));
    }
    print(base64Images[0]);
    String url = "https://reqres.in/api/users";
    Map<String, String> body = {
      'area': area,
      'comments': comments,
      'date': date,
      'task': task,
      'tags': tags,
      'events': events,
    };

    for (var element in base64Images) {
      body.addAll({"image": element});
    }
    print(body);

    Response r = await post(Uri.parse(url),
        body: json.encode(body), headers: {"Content-Type": "application/json"});

    if (r.statusCode == 201) {
      print("success");
      print(r.body);
    } else {
      print("fail");
    }
  }

  String fileToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  @override
  List<Object?> get props =>
      [imageFile, comments, date, area, task, tags, events];
}
