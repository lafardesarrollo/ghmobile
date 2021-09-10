import 'dart:convert';
import 'dart:io';

import 'package:ghmobile/src/models/boleta_permiso.dart';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

Future<Stream<List<BoletaPermiso>>> obtenerPermisosPorEmpleado(
    int idSap) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}permiso/' +
          idSap.toString();

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lboleta = LBoletaPermiso.fromJsonList(json.decode(response.body));
      return new Stream.value(lboleta.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

Future<Stream<bool>> saveBoletaPermiso(BoletaPermiso boleta) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}permiso/';

  final client = new http.Client();
  String _body = json.encode(boleta.toJson());
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: _body,
  );
  try {
    if (response.statusCode == 200) {
      return new Stream.value(true);
    } else {
      return new Stream.value(false);
    }
  } catch (e) {
    return new Stream.value(false);
  }
}
