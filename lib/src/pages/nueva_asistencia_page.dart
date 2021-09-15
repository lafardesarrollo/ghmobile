import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/controllers/asistencia_controller.dart';
import 'package:ghmobile/src/controllers/vacacion_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NuevaAsistenciaPage extends StatefulWidget {
  NuevaAsistenciaPage({Key? key}) {}

  @override
  NuevaAsistenciaPageState createState() => NuevaAsistenciaPageState();
}

class NuevaAsistenciaPageState extends StateMVC<NuevaAsistenciaPage> {
  late AsistenciaController _con;

  NuevaAsistenciaPageState() : super(AsistenciaController()) {
    _con = controller as AsistenciaController;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Realizar Marcación',
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
        body: Center(
          child: Text('Nueva Asistencia'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // _con.guardarVacaciones(context);
          },
          label: Text('Guardar Asistencia'),
          icon: FaIcon(FontAwesomeIcons.fingerprint),
        ),
      ),
    );
  }
}
