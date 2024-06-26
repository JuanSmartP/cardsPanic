import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:widget_panic_button/models/panic_models.dart';

class DataRepository {
  Future<List<Info>> getPanicData() async {

  
 
    const url =
        '';

    Response response =
        await http.post(Uri.parse(url), body: {'segmento': 'G'});

    final List result = jsonDecode(response.body)['info'];

    return result.map((e) => Info.fromJson(e)).toList();
  }

  Future<void> sendState(String consecutivo, String value) async {

 
    final url = Uri.parse(
        '');

    final response = await http.post(
      url,
      body: {"codigo_panico": consecutivo, "estado": value},
    );


    print(response.statusCode);
  }
}

