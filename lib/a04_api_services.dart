
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

var link = 'https://opentdb.com/api.php?amount=20';

getQuiz() async {
  var url = Uri.parse(link);
  var res = await http.get(url);

  if(res.statusCode==200){
    var data = jsonDecode(res.body.toString());
    debugPrint('Data is loaded');
    return data;
  }
}


getData() async{
  var uri = "";
  var url = Uri.parse(uri);
  var res = await http.get(url);

  if(res.statusCode==200){
    var data = jsonDecode(res.body.toString());
  }
}
