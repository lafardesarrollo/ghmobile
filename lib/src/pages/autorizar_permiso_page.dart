import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/controllers/permiso_controller.dart';
import 'package:ghmobile/src/models/boleta_permiso.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:ghmobile/src/widgets/CircularLoadingWidget.dart';
import 'package:ghmobile/src/widgets/DrawerWidget.dart';
import 'package:ghmobile/src/widgets/InformacionMensajeWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AutorizarPermisoPage extends StatefulWidget {
  const AutorizarPermisoPage({Key? key}) : super(key: key);

  @override
  AutorizarPermisoPageState createState() => AutorizarPermisoPageState();
}

class AutorizarPermisoPageState extends StateMVC<AutorizarPermisoPage> {
  late PermisoController _con;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutorizarPermisoPageState() : super(PermisoController()) {
    _con = controller as PermisoController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.loading = true;
    _con.listarBoletasPorAutorizador(
      context,
      int.parse(currentUser.value.idSap!),
    );
    // _con.requestBoleta.empId = 638;
    // _con.requestBoleta.empId = currentUser.value.!
    // _con.requestBoleta.periodo = "202108";
    // _con.obtenerBoletaPago();
  }

  void validateAndSave(BoletaPermiso boleta) {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      _con.rechazarBoletaPermisoAutorizador(context, boleta);
    } else {
      print('no valido');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (context) => IconButton(
              icon: FaIcon(
                FontAwesomeIcons.bars,
                color: Theme.of(context).hintColor,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Autorizar Permisos',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        floatingActionButton: _con.boletas.length == 0
            ? Container()
            : FloatingActionButton.extended(
                icon: Icon(Icons.check),
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Aprobar Todas'),
                      content: Text(
                          'Esta seguro que desea aprobar todas las boletas?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            _con.aprobarTodasBoletaPermisoAutorizador(context);
                          },
                          child: Text('Si, Aprobar'),
                        ),
                      ],
                    ),
                  );
                },
                label: Text('Aprobar Todas')),
        drawer: DrawerWidget(),
        body: _con.loading
            ? CircularLoadingWidget(
                texto: 'Cargando Permisos...',
                height: MediaQuery.of(context).size.height,
              )
            : RefreshIndicator(
                onRefresh: () async {
                  _con.listarBoletasPorAutorizador(
                      context, int.parse(currentUser.value.idSap!));
                },
                child: _con.boletas.length == 0
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: InformacionMensajeWidget(
                          icono: Icon(Icons.info),
                          mensaje:
                              'No tiene permisos pendientes para su revisión y aprobación',
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: _con.boletas.length,
                        itemBuilder: (context, index) {
                          final item = _con.boletas.elementAt(index);
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            actions: <Widget>[
                              IconSlideAction(
                                caption: 'Aprobar',
                                color: Colors.blue,
                                icon: Icons.check,
                                onTap: () => {
                                  _con.aprobarBoletaPermisoAutorizador(
                                      context, _con.boletas.elementAt(index))
                                },
                              ),
                            ],
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'Rechazar',
                                color: Colors.red,
                                icon: Icons.close,
                                onTap: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text('Motivo de Rechazo'),
                                    content: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        onChanged: (valor) => {
                                          _con.boletas
                                              .elementAt(index)
                                              .motivoRechazo = valor
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
                                        onPressed: () => validateAndSave(
                                            _con.boletas.elementAt(index)),
                                        child: Text('Rechazar'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            child: ListTile(
                              onTap: () {
                                _con.boleta = _con.boletas.elementAt(index);
                                _con.abrirDetallePermiso(context);
                              },
                              leading: CircleAvatar(
                                backgroundColor: _con.boletas
                                            .elementAt(index)
                                            .estadoPermiso
                                            .toString() ==
                                        '2'
                                    ? Colors.red
                                    : _con.boletas
                                                .elementAt(index)
                                                .estadoPermiso
                                                .toString() ==
                                            '1'
                                        ? Theme.of(context).accentColor
                                        : Theme.of(context).hintColor,
                                child: Text(_con.boletas
                                            .elementAt(index)
                                            .estadoPermiso
                                            .toString() ==
                                        '1'
                                    ? 'A'
                                    : _con.boletas
                                                .elementAt(index)
                                                .estadoPermiso
                                                .toString() ==
                                            '2'
                                        ? 'R'
                                        : 'P'),
                              ),
                              title:
                                  Text(_con.boletas.elementAt(index).motivos!),
                              subtitle: Text(
                                'Salida: ' +
                                    formatDate(
                                        DateTime.parse(_con.boletas
                                            .elementAt(index)
                                            .fechaSalida!),
                                        [dd, '-', mm, '-', yyyy]) +
                                    ' ' +
                                    _con.boletas.elementAt(index).horaSalida! +
                                    '\n' +
                                    _con.boletas
                                        .elementAt(index)
                                        .usuario!
                                        .firstName! +
                                    ' ' +
                                    _con.boletas
                                        .elementAt(index)
                                        .usuario!
                                        .lastName!,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).hintColor),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    _con.boleta = _con.boletas.elementAt(index);
                                    _con.abrirDetallePermiso(context);
                                  },
                                  icon: Icon(Icons.remove_red_eye_outlined)),
                            ),
                          );
                        }),
              ),
      ),
    );
  }
}
