// ignore_for_file: unnecessary_statements

import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:ghmobile/src/helpers/helper.dart';
import 'package:ghmobile/src/models/boleta_permiso.dart';
import 'package:ghmobile/src/models/motivo_mobile.dart';
import 'package:ghmobile/src/models/motivo_permiso.dart';
import 'package:ghmobile/src/pages/detalle_permiso_page.dart';
import 'package:ghmobile/src/pages/nuevo_permiso_page.dart';
import 'package:ghmobile/src/repository/permiso_repository.dart';
import 'package:ghmobile/src/repository/settings_repository.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PermisoController extends ControllerMVC {
  bool loading = false;

  double? latitud;
  double? longitud;

  TextEditingController dateInputSalida = TextEditingController();
  TextEditingController dateInputRetorno = TextEditingController();
  TextEditingController timeInputSalida = TextEditingController();
  TextEditingController timeInputRetorno = TextEditingController();
  TextEditingController txtObservaciones = new TextEditingController();
  TextEditingController txtDetalleCompensacion = new TextEditingController();

  int index = 0;

  List<BoletaPermiso> boletas = [];
  BoletaPermiso boleta = new BoletaPermiso();

  late OverlayEntry loader;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> permisoFormKey = new GlobalKey<FormState>();

  String valor_motivo = "Seleccione un Motivo de Permiso";
  MotivoPermiso motivo = new MotivoPermiso();
  List<MotivoPermiso> motivos = [];
  List<Map<String, dynamic>> items_motivos = [
    {'value': 'descuento', 'label': 'Sin goce de haberes'},
    {'value': 'natalidad', 'label': 'Natalidad'},
    {'value': 'muerte_de_familiar', 'label': 'Muerte de Familiar'},
    {'value': 'baja_medica', 'label': 'Baja Médica'},
    {'value': 'cita_medica', 'label': 'Cita Médica'},
    {'value': 'comision', 'label': 'Comisión'},
    {'value': 'compensacion', 'label': 'Compensación'},
    {'value': 'flexy_time', 'label': 'Flexy Time'},
    {'value': 'matrimonio', 'label': 'Matrimonio'},
    {'value': 'otros', 'label': 'Otros'}
  ];
  late var nuevo_motivos;
  PermisoController() {
    // loader = Helper.overlayLoader(context);
  }

  // void obtenerBoletaPago({String? message}) async {
  //   this.boleta = new BoletaPago();
  //   final Stream<BoletaPago> stream =
  //       await obtenerBoletaPagoPorEmpleado(this.requestBoleta);
  //   stream.listen((BoletaPago _boleta) {
  //     setState(() {
  //       boleta = _boleta;
  //       print(boleta.toJson());
  //     });
  //   }, onError: (a) {
  //     print(a);
  //     scaffoldKey.currentState?.showSnackBar(SnackBar(
  //       content: Text('Ocurrio un error al obtener la información'),
  //     ));
  //   }, onDone: () {
  //     if (message != null) {
  //       scaffoldKey.currentState!.showSnackBar(SnackBar(
  //         content: Text(message),
  //         backgroundColor: Colors.green,
  //       ));
  //     }
  //   });
  // }

  void listarMotivos(BuildContext context) async {
    final Stream<List<MotivoPermiso>> stream = await obtenerMotivosPermiso();
    stream.listen((List<MotivoPermiso> _lmotivos) {
      setState(() {
        motivos = _lmotivos;
      });
    }, onError: (a) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrio un error al obtener los motivos!'),
          backgroundColor: Colors.red,
        ),
      );
    }, onDone: () {
      loading = false;
    });
  }

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

  // Obtener boletas por autorizador
  void listarBoletasPorAutorizador(BuildContext context, int idEmpleado) async {
    final Stream<List<BoletaPermiso>> stream =
        await obtenerPermisosPorAutorizador(idEmpleado);
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

  // Obtener boleeta de permiso por codigo
  void obtenerBoletaPermiso(BuildContext context, int idBoleta) async {
    final Stream<BoletaPermiso> stream =
        await obtieneBoletaPermisoPorCodigo(idBoleta);
    stream.listen((BoletaPermiso _lpermisos) {
      setState(() {
        boleta = _lpermisos;
        // print(boleta);
      });
    }, onError: (a) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrio un error al obtener el detalle del permiso!'),
          backgroundColor: Colors.red,
        ),
      );
    }, onDone: () {
      loading = false;
    });
  }

  Future<void> abrirNuevoSolicitudPermiso(BuildContext context) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NuevoPermisoPage(
            // seguimiento: _seguimiento,
            ),
      ),
    );
    if (resultado) {
      print('Return TRUEEEEEEEEEEEEEEE');
      listarBoletas(context, int.parse(currentUser.value.idSap!));
    } else {
      listarBoletas(context, int.parse(currentUser.value.idSap!));
    }
  }

  Future<void> abrirDetallePermiso(BuildContext context) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetallePermisoPage(
          boletaPermiso: boleta,
          esAutorizador: true,
        ),
      ),
    );
    if (resultado) {
      this.listarBoletasPorAutorizador(
          context, int.parse(currentUser.value.idSap!));
    } else {}
  }

  void guardarBoletaPermiso(BuildContext context) async {
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

    if (boleta.cuentaSalida == null) {
      mostrarMensajeValidacion(context, 'Seleccione el motivo del permiso');
    } else if (boleta.fechaSalida?.length == 0) {
      mostrarMensajeValidacion(context, 'La fecha de salida es requerida');
    } else if (boleta.horaSalida?.length == 0) {
      mostrarMensajeValidacion(context, 'La hora de salida es requerida');
    } else if (boleta.motivos?.length == 0) {
      mostrarMensajeValidacion(
          context, 'Ingrese las observaciones de la solicitud de permiso');
    } else if (boleta.fechaRetorno?.length == 0) {
      mostrarMensajeValidacion(context, 'La fecha de retorno es requerida');
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

        loader = Helper.overlayLoader(context);
        FocusScope.of(context).unfocus();
        Overlay.of(context)!.insert(loader);
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

/*
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
      
    }
    */
  }

  void mostrarMensajeValidacion(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensaje),
      action: SnackBarAction(
        label: 'X',
        onPressed: () {},
        textColor: Theme.of(context).cardColor,
      ),
      backgroundColor: Colors.red,
    ));
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);

    return formatDate(dt, [HH, ':', nn, ':', ss]);
  }

  void registrarSalidaEfectiva(BuildContext context, BoletaPermiso bol) async {
    boleta = bol;

    loader = Helper.overlayLoader(context);
    FocusScope.of(context).unfocus();
    Overlay.of(context)!.insert(loader);

    this.getLocalization();

    final Stream<bool> stream =
        await saveRegistroSalidaBoletaPermiso(this.boleta);
    stream.listen((bool result) {
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Se guardo la salida efectiva correctamente!'),
          backgroundColor: Colors.blue,
        ));
        this.obtenerBoletaPermiso(context, boleta.idBoleta!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No se guardo el registro, intente nuevamente.'),
          backgroundColor: Colors.red,
        ));
      }
    }, onError: (a) {
      Helper.hideLoader(loader);
      loader.remove();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Ocurrio un error al guardar el registro de la hora efectiva de la salida'),
        backgroundColor: Colors.red,
      ));
    }, onDone: () {
      Helper.hideLoader(loader);
      loading = false;
    });
  }

  // Fecha efectiva de retorno
  void registrarRetornoEfectiva(BuildContext context, BoletaPermiso bol) async {
    boleta = bol;

    loader = Helper.overlayLoader(context);
    FocusScope.of(context).unfocus();
    Overlay.of(context)!.insert(loader);

    this.getLocalization();

    final Stream<bool> stream =
        await saveRegistroRetornoBoletaPermiso(this.boleta);
    stream.listen((bool result) {
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Se guardo la fecha de retorno efectiva correctamente!'),
          backgroundColor: Colors.blue,
        ));
        this.obtenerBoletaPermiso(context, boleta.idBoleta!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No se guardo el registro, intente nuevamente.'),
          backgroundColor: Colors.red,
        ));
      }
    }, onError: (a) {
      Helper.hideLoader(loader);
      loader.remove();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Ocurrio un error al guardar el registro de la hora efectiva de la Retorno'),
        backgroundColor: Colors.red,
      ));
    }, onDone: () {
      Helper.hideLoader(loader);
      loading = false;
    });
  }

  // aprobar boleta permiso
  void aprobarBoletaPermisoAutorizador(BuildContext context, BoletaPermiso bol,
      {int seCierra = 0}) async {
    boleta = bol;

    loader = Helper.overlayLoader(context);
    FocusScope.of(context).unfocus();
    Overlay.of(context)!.insert(loader);

    final Stream<bool> stream = await aprobarBoletaPermiso(this.boleta);
    stream.listen((bool result) {
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Se aprobo la boleta satisfactoriamente!'),
          backgroundColor: Colors.blue,
        ));
        this.listarBoletasPorAutorizador(
          context,
          int.parse(currentUser.value.idSap!),
        );
        if (seCierra == 1) {
          Navigator.pop(context, true);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No se guardo el registro, intente nuevamente.'),
          backgroundColor: Colors.red,
        ));
      }
    }, onError: (a) {
      Helper.hideLoader(loader);
      loader.remove();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Ocurrio un error al guardar el registro de la hora efectiva de la Retorno'),
        backgroundColor: Colors.red,
      ));
    }, onDone: () {
      Helper.hideLoader(loader);
      loading = false;
    });
  }

  // aprobar boleta permiso
  void aprobarTodasBoletaPermisoAutorizador(BuildContext context) async {
    loader = Helper.overlayLoader(context);
    FocusScope.of(context).unfocus();
    Overlay.of(context)!.insert(loader);

    final Stream<bool> stream =
        await aprobarTodasBoletaPermiso(int.parse(currentUser.value.idSap!));
    stream.listen((bool result) {
      if (result) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Se aprobaron las boletas satisfactoriamente!'),
          backgroundColor: Colors.blue,
        ));
        this.listarBoletasPorAutorizador(
          context,
          int.parse(currentUser.value.idSap!),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No se guardo el registro, intente nuevamente.'),
          backgroundColor: Colors.red,
        ));
      }
    }, onError: (a) {
      Helper.hideLoader(loader);
      loader.remove();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Ocurrio un error al guardar el registro de la hora efectiva de la Retorno'),
        backgroundColor: Colors.red,
      ));
    }, onDone: () {
      Helper.hideLoader(loader);
      loading = false;
    });
  }

  void rechazarBoletaPermisoAutorizador(BuildContext context, BoletaPermiso bol,
      {int seCierra = 0}) async {
    boleta = bol;

    loader = Helper.overlayLoader(context);
    FocusScope.of(context).unfocus();
    Overlay.of(context)!.insert(loader);

    // this.boleta.motivoRechazo = motivo;
    final Stream<bool> stream = await rechazarBoletaPermiso(this.boleta);
    stream.listen((bool result) {
      if (result) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Se rechazo la boleta satisfactoriamente!'),
          backgroundColor: Colors.blue,
        ));
        this.listarBoletasPorAutorizador(
          context,
          int.parse(currentUser.value.idSap!),
        );

        if (seCierra == 1) {
          Navigator.pop(context, true);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No se guardo el registro, intente nuevamente.'),
          backgroundColor: Colors.red,
        ));
      }
    }, onError: (a) {
      Helper.hideLoader(loader);
      loader.remove();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Ocurrio un error al guardar el registro de la hora efectiva de la Retorno'),
        backgroundColor: Colors.red,
      ));
    }, onDone: () {
      Helper.hideLoader(loader);
      loading = false;
    });
  }

  void getLocalization() async {
    final Stream<LocationData> stream = await obtenerLocalizacionActual();
    stream.listen((LocationData _locationData) {
      setState(() {
        this.latitud = _locationData.latitude;
        this.longitud = _locationData.longitude;

        boleta.latLngRetorno =
            this.latitud.toString() + ',' + this.longitud.toString();
        boleta.latLngSalida =
            this.latitud.toString() + ',' + this.longitud.toString();
      });
    }, onError: (a) {
      print("====ON ERROR");
    }, onDone: () {
      print("====ON DONE");
    });
  }
}
