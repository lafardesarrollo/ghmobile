// ignore_for_file: unnecessary_statements

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghmobile/src/models/libro.dart';
import 'package:ghmobile/src/models/titulo.dart';
import 'package:ghmobile/src/pages/titulo_page.dart';
import 'package:ghmobile/src/repository/reglamento_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ReglamentoController extends ControllerMVC {
  bool loading = false;
  Libro libro = new Libro();

  late OverlayEntry loader;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  ReglamentoController() {
    // loader = Helper.overlayLoader(context);
  }

  void obtenerLibro(BuildContext context, int idLibro) async {
    loading = true;
    final Stream<Libro> stream = await obtieneLibroPorId(idLibro);
    stream.listen((Libro _libro) {
      setState(() {
        libro = _libro;
        print(
          jsonEncode(libro),
        );
      });
    }, onError: (a) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrio un error al obtener el reglamento interno!'),
          backgroundColor: Colors.red,
        ),
      );
    }, onDone: () {
      loading = false;
    });
  }

  Future<void> abrirTitulo(BuildContext context, Titulo _titulo) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TituloPage(
          titulo: _titulo,
        ),
      ),
    );
    if (resultado) {
    } else {}
  }
/*
  void listarBoletas(BuildContext context, int idEmpleado) async {
    final Stream<List<BoletaPermiso>> stream =
        await obtenerPermisosPorEmpleado(idEmpleado);
    stream.listen(
      (List<BoletaPermiso> _lpermisos) {
        setState(() {
          boletas = _lpermisos;
          // print(boletas);
        });
      },
      onError: (a) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ocurrio un error al obtener la información!'),
            backgroundColor: Colors.red,
          ),
        );
      },
      onDone: () {
        loading = false;
      },
    );
  }

  
  

  void guardarBoletaPermiso(BuildContext context) async {
    loader = Helper.overlayLoader(context);
    FocusScope.of(context).unfocus();
    Overlay.of(context)!.insert(loader);

    boleta.idBoleta = 0;
    boleta.concepto = '';

    boleta.fechaSalida = dateInputSalida.text;
    boleta.fechaRetorno = dateInputRetorno.text;
    boleta.horaSalida = timeInputSalida.text;
    boleta.horaRetorno = timeInputRetorno.text;

    boleta.motivos = txtObservaciones.text;

    boleta.userid = int.parse(currentUser.value.idSap!);
    boleta.fechaRegistro = '0001-01-01';
    boleta.horaRegistro = '';
    boleta.diaEntero = 0.0;
    boleta.fechaEfectivaRetorno = '0001-01-01';
    boleta.horaEfectivaRetorno = '';
    boleta.mitadJornada = 0.0;
    boleta.idSuperior = 0;
    boleta.autorizador = '';
    boleta.estadoPermiso = 0;
    boleta.fechaAccionSuperior = '0001-01-01';
    boleta.horaAccionSuperior = '';
    boleta.motivoRechazo = '';
    boleta.detalleCompensacion = txtDetalleCompensacion.text;
    boleta.fechaEfectivaSalida = '0001-01-01';
    boleta.horaEfectivaSalida = '';
    boleta.latLngSalida = "0";
    boleta.latLngRetorno = "0";

    if (boleta.fechaSalida == '' ||
        boleta.fechaSalida == null && boleta.horaSalida == '' ||
        boleta.horaSalida == null && boleta.motivos == '' ||
        boleta.motivos == null && boleta.cuentaSalida == '' ||
        boleta.cuentaSalida == null && boleta.fechaRetorno == '' ||
        boleta.fechaRetorno == null) {
      Helper.hideLoader(loader);
      loader.remove();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Verifica que llenaste toda la información correctamente!'),
        backgroundColor: Colors.red,
      ));
    } else {
      if (boleta.motivos!.toLowerCase().contains('vacaci')) {
        Helper.hideLoader(loader);
        loader.remove();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'No puedes guardar un permiso de vacación en este formulario de permisos, ingresa a GLV -> Vacaciones para solicitar vacaciones'),
          backgroundColor: Colors.red,
        ));
      } else {
        // print(this.boleta.toJson());

        final Stream<bool> stream = await saveBoletaPermiso(this.boleta);
        stream.listen((bool result) {
          if (result) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Se guardo la Liencia correctamente!'),
              backgroundColor: Colors.blue,
            ));
            Navigator.pop(context, true);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('No se guardo la licencia, intente nuevamente.'),
              backgroundColor: Colors.red,
            ));
          }
        }, onError: (a) {
          Helper.hideLoader(loader);
          loader.remove();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Ocurrio un error al guardar la Licencia de Permiso'),
            backgroundColor: Colors.red,
          ));
          // scaffoldKey.currentState?.showSnackBar(SnackBar(
          //   content: Text('Ocurrio un error al obtener la información'),
          // ));
        }, onDone: () {
          Helper.hideLoader(loader);
          loading = false;
        });
      }
    }
  }
*/

}
