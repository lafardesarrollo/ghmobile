import 'dart:convert';

import 'package:ghmobile/src/models/regional_select.dart';
import 'package:http/http.dart' as http;
import 'package:ghmobile/src/models/regional.dart';
import 'package:global_configuration/global_configuration.dart';

Future<Stream<List<Regional>>> obtieneRegionales() async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}regional/';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final regionales = LRegional.fromJsonList(json.decode(response.body));
      return new Stream.value(regionales.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

Future<Stream<Regional>> obtieneRegionalPorId(int idRegional) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}regional/${idRegional.toString()}';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final regional = Regional.fromJson(json.decode(response.body));
      return new Stream.value(regional);
    } else {
      return new Stream.value(new Regional());
    }
  } catch (e) {
    return new Stream.value(new Regional());
  }
}

Future<Stream<List<RegionalSelect>>> obtieneRegionalSelect() async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}regional/RegionalSelect';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final regionales =
          LRegionalSelect.fromJsonList(json.decode(response.body));
      return new Stream.value(regionales.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}
