import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/controllers/permiso_controller.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
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
    _con.listarBoletas(int.parse(currentUser.value.idSap!));
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
        body: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text('P'),
              ),
              title: Text(
                  'Asistire al Evento GDG DEVFEST La Paz que son en fecha 8 y 9 de Noviembre en la Universidad Catolica'),
              subtitle: Text('Fecha de Salida: 21-NOV-19',
                  style: TextStyle(color: Theme.of(context).hintColor)),
              trailing: IconButton(
                  onPressed: () {}, icon: Icon(Icons.remove_red_eye_outlined)),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Text('A'),
                backgroundColor: Theme.of(context).accentColor,
              ),
              title: Text('Reunión con Gestión de Calidad en Oficina Nacional'),
              subtitle: Text('Fecha de Salida: 21-NOV-19',
                  style: TextStyle(color: Theme.of(context).hintColor)),
              trailing: Icon(Icons.remove_red_eye_outlined),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Text('A'),
                backgroundColor: Theme.of(context).accentColor,
              ),
              title: Text('cita medica programada en CNS'),
              subtitle: Text(
                'Fecha de Salida: 21-NOV-19',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
              trailing: Icon(Icons.remove_red_eye_outlined),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Text('R'),
                backgroundColor: Colors.red,
              ),
              title: Text(
                'Asistire al Evento GDG DEVFEST La Paz que son en fecha 8 y 9 de Noviembre en la Universidad Catolica',
              ),
              subtitle: Text('Fecha de Salida: 21-NOV-19',
                  style: TextStyle(color: Theme.of(context).hintColor)),
              trailing: Icon(Icons.remove_red_eye_outlined),
            )
          ],
        ),
      ),
    );
  }
}
