import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:ghmobile/src/controllers/vacacion_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:select_form_field/select_form_field.dart';

class NuevaVacacionPage extends StatefulWidget {
  NuevaVacacionPage({Key? key}) {}

  @override
  NuevaVacacionPageState createState() => NuevaVacacionPageState();
}

class NuevaVacacionPageState extends StateMVC<NuevaVacacionPage> {
  late VacacionController _con;

  NuevaVacacionPageState() : super(VacacionController()) {
    _con = controller as VacacionController;
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
            'Solicitud de Vacación',
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
        body: Form(
          key: _con.permisoFormKey,
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Theme.of(context).accentColor)),
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text('Información de Salida',
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ),
              SizedBox(),
              Text(
                'Seleccione el número de días',
                style:
                    TextStyle(color: Theme.of(context).hintColor, fontSize: 14),
              ),
              SpinBox(
                readOnly: true,
                decimals: 1,
                step: 0.5,
                min: 0,
                max: 100,
                value: 0,
                onChanged: (value) {
                  print(value);
                  _con.boleta.diaEntero = value;
                },
              ),
              SizedBox(),
              TextField(
                controller: _con.dateInputSalida,
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Ingrese la Fecha de Salida"),
                readOnly: true,
                onTap: () async {
                  DateTime? salidaDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        new DateTime.now().subtract(new Duration(days: 0)),
                    lastDate: new DateTime.now().add(new Duration(days: 30)),
                  );

                  if (salidaDate != null) {
                    print(salidaDate);
                    String fechaSalida =
                        formatDate(salidaDate, [yyyy, '-', mm, '-', dd]);
                    setState(() {
                      _con.dateInputSalida.text = fechaSalida;
                    });
                  } else {
                    print("Fecha de Salida no fue seleccionado");
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _con.txtObservaciones,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                maxLength: 500,
                decoration: InputDecoration(
                    icon: Icon(Icons.sd_card_alert_outlined),
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese sus Observaciones'),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Theme.of(context).accentColor)),
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text('Información de Retorno',
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ),
              SizedBox(),
              TextField(
                controller: _con.dateInputRetorno,
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Ingrese la Fecha de Retorno"),
                readOnly: true,
                onTap: () async {
                  DateTime? salidaDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        new DateTime.now().subtract(new Duration(days: 0)),
                    lastDate: new DateTime.now().add(new Duration(days: 30)),
                  );

                  if (salidaDate != null) {
                    String fechaSalida =
                        formatDate(salidaDate, [yyyy, '-', mm, '-', dd]);
                    setState(() {
                      _con.dateInputRetorno.text = fechaSalida;
                    });
                  } else {
                    print("Fecha de Retorno no fue seleccionado");
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _con.guardarVacaciones(context);
          },
          label: Text('Guardar Vacación'),
        ),
      ),
    );
  }
}
