import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';


Future<Response> authenticate(username, password) async{
  final response = await get(
    Uri.parse("http://galaxy.biowebdb.org/api/authenticate/baseauth"),
    headers:{
      HttpHeaders.authorizationHeader: 'Basic ' + base64Encode(utf8.encode('$username:$password'))
    }
  );
  return response;
}