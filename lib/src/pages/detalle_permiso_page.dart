import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/controllers/permiso_controller.dart';
import 'package:ghmobile/src/helpers/app_config.dart';
import 'package:ghmobile/src/models/boleta_permiso.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:ghmobile/src/widgets/CircularLoadingWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:date_format/date_format.dart';

// ignore: must_be_immutable
class DetallePermisoPage extends StatefulWidget {
  BoletaPermiso? boletaPermiso;
  bool? esAutorizador;

  DetallePermisoPage({Key? key, this.boletaPermiso, this.esAutorizador});

  @override
  DetallePermisoPageState createState() => DetallePermisoPageState();
}

class DetallePermisoPageState extends StateMVC<DetallePermisoPage> {
  late PermisoController _con;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DetallePermisoPageState() : super(PermisoController()) {
    _con = controller as PermisoController;
  }

  @override
  void initState() {
    // _con.boleta = widget.boletaPermiso!;
    _con.obtenerBoletaPermiso(context, widget.boletaPermiso!.idBoleta!);
    _con.getLocalization();
    super.initState();
  }

  void validateAndSave(BoletaPermiso boleta) {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      _con.rechazarBoletaPermisoAutorizador(context, boleta, seCierra: 1);
    } else {
      print('no valido');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Detalle Permiso ',
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
          actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.save_outlined,
//                 color: Theme.of(context).primaryColor,
//               ),
//               onPressed: () {
// //                 _con.checkMock();
//               },
//             )
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: _con.boleta.idBoleta != null
            ? SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Card(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/icon/profile_blue.png',
                              width: 50,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Salida por: ' +
                                  _con.boleta.cuentaSalida.toString()),
                              Text(
                                'Creada el: ' +
                                    formatDate(
                                        DateTime.parse(
                                            _con.boleta.fechaRegistro!),
                                        [yyyy, '-', mm, '-', dd]) +
                                    ' ' +
                                    _con.boleta.horaRegistro!,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tipo de Permiso',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  _con.boleta.concepto!,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Fecha de Salida',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  formatDate(
                                          DateTime.parse(
                                              _con.boleta.fechaSalida!),
                                          [yyyy, '-', mm, '-', dd]) +
                                      ' ' +
                                      _con.boleta.horaSalida!,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Fecha de Retorno',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  formatDate(
                                          DateTime.parse(
                                              _con.boleta.fechaRetorno!),
                                          [yyyy, '-', mm, '-', dd]) +
                                      ' ' +
                                      _con.boleta.horaRetorno!,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                            Divider(),
                            Text('Motivo de Salida',
                                style: Theme.of(context).textTheme.subtitle2),
                            Text(_con.boleta.motivos!,
                                style: Theme.of(context).textTheme.subtitle1)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Autorizado por: ',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  _con.boleta.autorizador.toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Estado del Permiso',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: _con.boleta.estadoPermiso == 0
                                          ? Colors.yellow
                                          : _con.boleta.estadoPermiso == 1
                                              ? Colors.green
                                              : Colors.red,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    _con.boleta.estadoPermiso == 0
                                        ? 'Pendiente'
                                        : _con.boleta.estadoPermiso == 1
                                            ? 'Aprobado'
                                            : 'Rechazado',
                                    style: Theme.of(context).textTheme.overline,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Fecha de Autorizaci??n:',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                _con.boleta.fechaAccionSuperior ==
                                        '0001-01-01T00:00:00'
                                    ? Text(
                                        'NA',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      )
                                    : Text(
                                        formatDate(
                                                DateTime.parse(_con.boleta
                                                    .fechaAccionSuperior!),
                                                [yyyy, '-', mm, '-', dd]) +
                                            ' ' +
                                            _con.boleta.horaAccionSuperior!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                              ],
                            ),
                            Divider(),
                            Text('Fecha y Hora Efectiva de Salida',
                                style: Theme.of(context).textTheme.subtitle2),
                            _con.boleta.fechaEfectivaSalida ==
                                    '0001-01-01T00:00:00'
                                ? _con.boleta.userid.toString() ==
                                        currentUser.value.useridlafarnet!
                                    ? ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              App(context).appWidth(100), 40),
                                        ),
                                        onPressed: () =>
                                            _con.registrarSalidaEfectiva(
                                                context, widget.boletaPermiso!),
                                        icon: Icon(Icons.fingerprint),
                                        label:
                                            Text('Registrar Salida Efectiva'))
                                    : Text(
                                        'No registrado',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).accentColor),
                                      )
                                : Text(
                                    formatDate(
                                            DateTime.parse(_con
                                                .boleta.fechaEfectivaSalida!),
                                            [yyyy, '-', mm, '-', dd]) +
                                        ' ' +
                                        _con.boleta.horaEfectivaSalida!,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                            Text('Fecha y Hora Efectiva de Retorno',
                                style: Theme.of(context).textTheme.subtitle2),
                            _con.boleta.fechaEfectivaRetorno ==
                                    '0001-01-01T00:00:00'
                                ? _con.boleta.userid.toString() !=
                                        currentUser.value.useridlafarnet!
                                    ? Text(
                                        'No registrado',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).accentColor),
                                      )
                                    : ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Theme.of(context).accentColor,
                                          fixedSize: Size(
                                              App(context).appWidth(100), 40),
                                        ),
                                        onPressed: () =>
                                            _con.registrarRetornoEfectiva(
                                                context, widget.boletaPermiso!),
                                        icon: Icon(Icons.fingerprint),
                                        label: Text('Registrar Retorno'))
                                : Text(
                                    formatDate(
                                            DateTime.parse(_con
                                                .boleta.fechaEfectivaRetorno!),
                                            [yyyy, '-', mm, '-', dd]) +
                                        ' ' +
                                        _con.boleta.horaEfectivaRetorno!,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                            // Text(_con.latitud.toString()),
                            // Text(_con.longitud.toString())
                          ],
                        ),
                      ),
                    ),
                    _con.boleta.userid.toString() !=
                            currentUser.value.useridlafarnet!
                        ? ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              fixedSize: Size(App(context).appWidth(100), 60),
                              primary: Theme.of(context).hintColor,
                            ),
                            onPressed: () {
                              _con.aprobarBoletaPermisoAutorizador(
                                  context, widget.boletaPermiso!,
                                  seCierra: 1);
                            },
                            icon: FaIcon(FontAwesomeIcons.check),
                            label: Text('APROBAR SOLICITUD'),
                          )
                        : Container(),
                    SizedBox(
                      height: 5,
                    ),
                    _con.boleta.userid.toString() !=
                            currentUser.value.useridlafarnet!
                        ? ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              fixedSize: Size(App(context).appWidth(100), 60),
                              primary: Theme.of(context).errorColor,
                            ),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text('Motivo de Rechazo'),
                                content: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    onChanged: (valor) => {
                                      widget.boletaPermiso?.motivoRechazo =
                                          valor
                                    },
                                    validator: (value) => value!.isEmpty
                                        ? 'No puede estar vacio'
                                        : null,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                    maxLength: 200,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'Ingrese el Motivo de Rechazo'),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        validateAndSave(widget.boletaPermiso!),
                                    child: Text('Rechazar'),
                                  ),
                                ],
                              ),
                            ),
                            icon: FaIcon(FontAwesomeIcons.windowClose),
                            label: Text('RECHAZAR SOLICITUD'),
                          )
                        : Container(),
                  ],
                ),
              )
            : CircularLoadingWidget(
                height: 200,
                texto: 'Cargando Boleta ...',
              ),
      ),
    );
  }
}
