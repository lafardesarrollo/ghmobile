import 'dart:convert';
import 'dart:io';

import 'package:ghmobile/src/models/boleta_permiso.dart';
import 'package:ghmobile/src/models/response_saldo_vacaciones.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<Stream<List<BoletaPermiso>>> obtenerPermisosVacacionesPorEmpleado(
    int idSap) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}vacacion/' +
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

Future<Stream<bool>> saveBoletaVacacion(BoletaPermiso boleta) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_ghapi')}vacacion/';

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

Future<Stream<ResponseSaldoVacaciones>> obtenerSaldoVacacionesPorEmpleado(
    int idEmpleado) async {
  // BoletaPago boleta = new BoletaPago();
  // Uri uri = Helper.getUriLfr('api/producto');
  // String idcli = currentUser.value.uid; /*cambiar por id del cliente*/
  final String url =
      '${GlobalConfiguration().getValue('api_base_url_apicore')}personavacacion/' +
          idEmpleado.toString();

  print(url);

  final client = new http.Client();
  final response = await client.get(
    Uri.parse(url),
  );
  try {
    if (response.statusCode == 200) {
      final saldo = ResponseSaldoVacaciones.fromJson(
          json.decode(response.body)['body'][0]);

      // final resp_saldo = saldo['body'];
      // final lreserva =  LReserva.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(saldo);
    } else {
      return new Stream.value(new ResponseSaldoVacaciones());
    }
  } catch (e) {
    return new Stream.value(new ResponseSaldoVacaciones());
  }
}
