import 'dart:convert';
import 'dart:io';

import 'package:ghmobile/src/models/asistencia_calculo_general.dart';
import 'package:ghmobile/src/models/marcacion.dart';
import 'package:ghmobile/src/models/request_asistencia_persona.dart';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

Future<Stream<List<Marcacion>>> obtieneMarcacionesPorUsername(
    String username) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}marcacion/' +
          username;

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final marcaciones = LMarcaciones.fromJsonList(json.decode(response.body));
      return new Stream.value(marcaciones.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

Future<Stream<bool>> saveMarcacion(Marcacion marcacion) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}marcacion/';

  final client = new http.Client();
  String _body = json.encode(marcacion.toJson());
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

Future<Stream<String>> getDateTime() async {
  final nuevaFecha = DateTime.now().toString();
  final String url =
      '${GlobalConfiguration().getString('api_base_url_lfr')}marcacion/getdatetime';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final fechaActual = json.decode(response.body)['body'];
      return new Stream.value(fechaActual);
    } else {
      return new Stream.value(nuevaFecha);
    }
  } catch (e) {
    return new Stream.value(nuevaFecha);
  }
}

// obtiene la cantidad de minutos de atraso acumulados del mes
Future<Stream<AsistenciaCalculoGeneral>> obtieneAtrasosPorMes(
    RequestAsistenciaPersona data) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}NuevaAsistencia/CalculoGeneralApp';

  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: jsonEncode(data),
  );
  try {
    if (response.statusCode == 200) {
      final atraso =
          AsistenciaCalculoGeneral.fromJson(jsonDecode(response.body));
      // print(jsonEncode(atraso));
      return new Stream.value(atraso);
    } else {
      return new Stream.value(new AsistenciaCalculoGeneral());
    }
  } catch (e) {
    return new Stream.value(new AsistenciaCalculoGeneral());
  }
}
