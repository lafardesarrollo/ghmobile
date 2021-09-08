import 'package:date_format/date_format.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:ghmobile/src/controllers/permiso_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

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
          body: Form(
            key: _con.permisoFormKey,
            child: ListView(
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
                TextFormField(
                  controller: _con.timeInputSalida,
                  decoration: InputDecoration(
                      icon: Icon(Icons.timelapse),
                      labelText: "Ingrese la Hora de Salida"),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay time = TimeOfDay.now();
                    FocusScope.of(context).requestFocus(new FocusNode());

                    TimeOfDay? pickedTimeSalida = await showTimePicker(
                        context: context, initialTime: time);
                    if (pickedTimeSalida != null && pickedTimeSalida != time) {
                      _con.timeInputSalida.text = pickedTimeSalida.toString();
                      setState(() {
                        time = pickedTimeSalida;
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'El campo esta vacio';
                    }
                    return null;
                  },
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
                      print(salidaDate);
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
                TextFormField(
                  controller: _con.timeInputRetorno,
                  decoration: InputDecoration(
                      icon: Icon(Icons.timelapse),
                      labelText: "Ingrese la Hora de Retorno"),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay time = TimeOfDay.now();
                    FocusScope.of(context).requestFocus(new FocusNode());

                    TimeOfDay? pickedTimeSalida = await showTimePicker(
                        context: context, initialTime: time);
                    if (pickedTimeSalida != null && pickedTimeSalida != time) {
                      _con.timeInputRetorno.text = pickedTimeSalida.toString();
                      setState(() {
                        time = pickedTimeSalida;
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'El campo esta vacio';
                    }
                    return null;
                  },
                )
              ],
            ),
          )
          /*
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Theme.of(context).accentColor)),
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text('Fecha de Salida',
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ),
              SizedBox(),
              DatePicker(
                DateTime.now(),
                width: 60,
                height: 90,
                initialSelectedDate: DateTime.now(),
                selectionColor: Theme.of(context).primaryColor,
                selectedTextColor: Colors.white,
                // dateTextStyle: TextStyle(fontSize: 20),
                // monthTextStyle: TextStyle(fontSize: 10),
                // dayTextStyle: TextStyle(fontSize: 10),
                locale: 'es-ES',
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    // _selectedValue = date;
                  });
                },
              ),
              SizedBox(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Theme.of(context).accentColor)),
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text('Hora de Salida',
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ),
              SizedBox(),
              TimePickerSpinner(
                is24HourMode: false,
                normalTextStyle: TextStyle(fontSize: 20, color: Colors.black),
                highlightedTextStyle:
                    TextStyle(fontSize: 20, color: Colors.blue),
                spacing: 50,
                itemHeight: 30,
                isForce2Digits: true,
                onTimeChange: (time) {
                  setState(() {
                    // _dateTime = time;
                  });
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Theme.of(context).accentColor)),
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text('Fecha de Retorno',
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ),
              SizedBox(),
              DatePicker(
                DateTime.now(),
                width: 60,
                height: 90,
                initialSelectedDate: DateTime.now(),
                selectionColor: Theme.of(context).primaryColor,
                selectedTextColor: Colors.white,
                // dateTextStyle: TextStyle(fontSize: 20),
                // monthTextStyle: TextStyle(fontSize: 10),
                // dayTextStyle: TextStyle(fontSize: 10),
                locale: 'es-ES',
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    // _selectedValue = date;
                  });
                },
              ),
              SizedBox(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Theme.of(context).accentColor)),
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text('Hora de Retorno',
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ),
              SizedBox(),
              TimePickerSpinner(
                is24HourMode: false,
                normalTextStyle: TextStyle(fontSize: 20, color: Colors.black),
                highlightedTextStyle:
                    TextStyle(fontSize: 20, color: Colors.blue),
                spacing: 50,
                itemHeight: 30,
                isForce2Digits: true,
                onTimeChange: (time) {
                  setState(() {
                    // _dateTime = time;
                  });
                },
              ),
              SizedBox(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Theme.of(context).accentColor)),
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text('Motivo del Permiso',
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ),
              SizedBox(),
            ],
          ),
        ),
        */
          ),
    );
  }
}
