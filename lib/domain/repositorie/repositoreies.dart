import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
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
}
