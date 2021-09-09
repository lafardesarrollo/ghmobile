import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/controllers/permiso_controller.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:ghmobile/src/widgets/CircularLoadingWidget.dart';
import 'package:ghmobile/src/widgets/DrawerWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PermisoPage extends StatefulWidget {
  const PermisoPage({Key? key}) : super(key: key);

  @override
  PermisoPageState createState() => PermisoPageState();
}

class PermisoPageState extends StateMVC<PermisoPage> {
  late PermisoController _con;

  PermisoPageState() : super(PermisoController()) {
    _con = controller as PermisoController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.loading = true;
    _con.listarBoletas(context, int.parse(currentUser.value.idSap!));
    // _con.requestBoleta.empId = 638;
    // _con.requestBoleta.empId = currentUser.value.!
    // _con.requestBoleta.periodo = "202108";
    // _con.obtenerBoletaPago();
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
          actions: [
            // Container(
            //   padding: EdgeInsets.only(right: 20),
            //   child: DropdownButton<String>(
            //     value: _con.dropdownValue,
            //     icon: Icon(Icons.arrow_downward),
            //     onChanged: (String? newValue) {
            //       setState(() {
            //         _con.dropdownValue = newValue!;
            //         if (newValue == 'Agosto') {
            //           _con.requestBoleta.periodo = "202108";
            //         } else if (newValue == 'Julio') {
            //           _con.requestBoleta.periodo = "202107";
            //         } else {
            //           _con.requestBoleta.periodo = "202106";
            //         }
            //         _con.obtenerBoletaPago();
            //       });
            //     },
            //     items: <String>['Agosto', 'Julio', 'Junio']
            //         .map<DropdownMenuItem<String>>((String value) {
            //       return DropdownMenuItem<String>(
            //         value: value,
            //         child: Text(value),
            //       );
            //     }).toList(),
            //   ),
            // ),
            // IconButton(
            //   icon: FaIcon(
            //     FontAwesomeIcons.filePdf,
            //     color: Theme.of(context).primaryColor,
            //   ), // FaIcon(FontAwesomeIcons.syncAlt),
            //   onPressed: () {
            //     // _con.refreshHome();
            //   },
            // )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Mis Permisos',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _con.abrirNuevoSolicitudPermiso(context);
            },
            label: Text('Solicitar Permiso')),
        drawer: DrawerWidget(),
        body: _con.loading
            ? CircularLoadingWidget(
                texto: 'Cargando Permisos...',
                height: MediaQuery.of(context).size.height,
              )
            : ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: _con.boletas.length,
                itemBuilder: (context, index) {
                  return ListTile(
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
                    title: Text(_con.boletas.elementAt(index).motivos!),
                    subtitle: Text(
                        'Salida: ' +
                            formatDate(
                                _con.boletas.elementAt(index).fechaSalida!,
                                [dd, '-', mm, '-', yyyy]) +
                            ' ' +
                            _con.boletas.elementAt(index).horaSalida!,
                        style: TextStyle(
                            fontSize: 16, color: Theme.of(context).hintColor)),
                    trailing: IconButton(
                        onPressed: () {
                          // _con.boleta = _con.boletas.elementAt(index);
                          // _con.abrirDetallePermiso(context);
                        },
                        icon: Icon(Icons.remove_red_eye_outlined)),
                  );
                }),
      ),
    );
  }
}
