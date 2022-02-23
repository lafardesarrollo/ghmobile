import 'dart:convert';
import 'dart:io';

import 'package:ghmobile/src/models/periodo_gestion.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<Stream<PeriodoGestion>> obtenerPeriodoActual() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_ghapi')}PeriodoGestion/PeriodoActual';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));

  try {
    if (response.statusCode == 200) {
      final periodo = PeriodoGestion.fromJson(json.decode(response.body));
      return new Stream.value(periodo);
    } else {
      return new Stream.value(new PeriodoGestion());
    }
  } catch (e) {
    return new Stream.value(new PeriodoGestion());
  }
}
