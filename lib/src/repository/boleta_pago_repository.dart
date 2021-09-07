import 'dart:convert';
import 'dart:io';

import 'package:ghmobile/src/models/boleta_pago.dart';
import 'package:ghmobile/src/models/request_boleta_pago.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<Stream<BoletaPago>> obtenerBoletaPagoPorEmpleado(
    RequestBoletaPago data) async {
  // BoletaPago boleta = new BoletaPago();
  // Uri uri = Helper.getUriLfr('api/producto');
  // String idcli = currentUser.value.uid; /*cambiar por id del cliente*/
  final String url =
      '${GlobalConfiguration().getString('api_base_url_ghapi')}boletapago/ObtenerPorEmpleado';

  final client = new http.Client();
  final response = await client.post(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(data.toJson()));
  try {
    if (response.statusCode == 200) {
      final boleta = BoletaPago.fromJson(json.decode(response.body));
      // final lreserva =  LReserva.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(boleta);
    } else {
      return new Stream.value(new BoletaPago());
    }
  } catch (e) {
    return new Stream.value(new BoletaPago());
  }
}
