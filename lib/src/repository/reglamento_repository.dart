// Obtiene boletas por codigo de boleta
import 'dart:convert';

import 'package:ghmobile/src/models/libro.dart';
import 'package:ghmobile/src/models/libro_detalle.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<Stream<Libro>> obtieneLibroPorId(int idLibro) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}reglamento/1';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final libro = Libro.fromJson(json.decode(response.body));
      return new Stream.value(libro);
    } else {
      return new Stream.value(new Libro());
    }
  } catch (e) {
    return new Stream.value(new Libro());
  }
}

// OBtener titulos del Libro
Future<Stream<List<LibroDetalle>>> obtieneTitulos(int idLibro) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}reglamento/GetTituloDetallePorTitulo/${idLibro}';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final detalles = LLibroDetalle.fromJsonList(json.decode(response.body));
      return new Stream.value(detalles.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

Future<Stream<List<LibroDetalle>>> obtieneLibroDetallePorTitulo(
    int idTitulo) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}reglamento/getdetalleportitulo/${idTitulo}';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final detalles = LLibroDetalle.fromJsonList(json.decode(response.body));
      return new Stream.value(detalles.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}
