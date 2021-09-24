import 'dart:convert';

import 'package:ghmobile/src/models/publicacion.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<Stream<List<Publicacion>>> obtenerPublicaciones() async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_lfr')}publicacion/get';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final publicaciones =
          LPublicaciones.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(publicaciones.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}
