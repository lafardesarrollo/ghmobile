import 'dart:convert';
import 'dart:io';

import 'package:ghmobile/src/models/response_saldo_vacaciones.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<Stream<ResponseSaldoVacaciones>> obtenerSaldoVacacionesPorEmpleado(
    int idEmpleado) async {
  // BoletaPago boleta = new BoletaPago();
  // Uri uri = Helper.getUriLfr('api/producto');
  // String idcli = currentUser.value.uid; /*cambiar por id del cliente*/
  final String url =
      '${GlobalConfiguration().getString('api_base_url_apicore')}personavacacion/' +
          idEmpleado.toString();

  final client = new http.Client();
  final response = await client.get(
    Uri.parse(url + idEmpleado.toString()),
  );
  try {
    if (response.statusCode == 200) {
      final saldo = json.decode(response.body);
      final resp_saldo = saldo['body'];
      // final lreserva =  LReserva.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(saldo);
    } else {
      return new Stream.value(new ResponseSaldoVacaciones());
    }
  } catch (e) {
    return new Stream.value(new ResponseSaldoVacaciones());
  }
}
