import 'package:galaxy_tracker/models.dart';
import 'dart:convert';

import 'package:http/http.dart';

class Requests {
  final String baseUrl = "galaxy.biowebdb.org";
  String apiKey;

  Requests(String apiKey) {
    this.apiKey = apiKey;
  }

  Future<List> get_histories() async {
    final response = await get(
      Uri.http(baseUrl, '/api/histories', {'key': apiKey}),
    );
    List<History> list = [for(var i in jsonDecode(response.body)) History.fromJson(i)];

    return list;
  }

  Future<List> get_history_items(id) async{
    final response = await get(
      Uri.http(baseUrl, '/api/histories/$id/contents', {'key': apiKey}),
    );
    List<HistoryItem> list = [for(var i in jsonDecode(response.body)) HistoryItem.fromJson(i)];
    
    return list;
  }
}
