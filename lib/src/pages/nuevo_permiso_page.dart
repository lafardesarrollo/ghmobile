import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:ghmobile/src/controllers/permiso_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NuevoPermisoPage extends StatefulWidget {
  NuevoPermisoPage({Key? key}) {}

  @override
  NuevoPermisoPageState createState() => NuevoPermisoPageState();
}

class NuevoPermisoPageState extends StateMVC<NuevoPermisoPage> {
  late PermisoController _con;

  NuevoPermisoPageState() : super(PermisoController()) {
    _con = controller as PermisoController;
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
            'Solicitud de Permiso',
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
        body: Container(
          child: Column(
            children: <Widget>[
              Text('Fecha de Salida'),
              SizedBox(),
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Theme.of(context).hintColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    // _selectedValue = date;
                  });
                },
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     _goToUbicacion();
        //   },
        //   label: Text('To the lake!'),
        //   icon: Icon(Icons.directions_boat),
        // ),
      ),
    );
  }
}
