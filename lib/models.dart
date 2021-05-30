import 'dart:async';

import 'package:flutter/material.dart';

class HistoryItem{
  String id;
  String name;
  String state;
  String createTime;
}

class History{
  String id;
  String name;

  History(id,name){
    this.id = id;
    this.name = name;
  }

  History.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'];
}