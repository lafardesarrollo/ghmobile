import 'dart:convert';
import 'dart:io';

import 'package:ghmobile/src/models/cumpleaneros.dart';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

Future<Stream<List<Cumpleaneros>>> obtieneCumpleanerosDelMes() async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}cumpleaneros/';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lboleta = LCumpleaneros.fromJsonList(json.decode(response.body));
      return new Stream.value(lboleta.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}
