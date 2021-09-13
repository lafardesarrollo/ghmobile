import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:ghmobile/src/controllers/permiso_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:select_form_field/select_form_field.dart';

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
              SelectFormField(
                type: SelectFormFieldType.dropdown, // or can be dialog
                initialValue: 'circle',
                icon: Icon(Icons.style_sharp),
                labelText: 'Seleccione un motivo de Permiso',
                items: _con.items_motivos,
                onChanged: (val) => _con.boleta.cuentaSalida = val,
              ),
              SizedBox(),
              // Container(
              //   padding: EdgeInsets.only(right: 20),
              //   child: DropdownButton<String>(
              //     isExpanded: true,
              //     value: _con.valor_motivo,
              //     icon: Icon(Icons.arrow_downward),
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         _con.valor_motivo = newValue!;
              //         _con.boleta.cuentaSalida = newValue;
              //       });
              //     },
              //     items: <String>[
              //       'Seleccione un Motivo de Permiso',
              //       'Sin goce de haberes',
              //       'Natalidad',
              //       'Muerte de familiar',
              //       'Baja médica',
              //       'Cita médica',
              //       'Comisión',
              //       'Compensación',
              //       'Matrimonio',
              //       'Otros'
              //     ].map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //   ),
              // ),
              // SizedBox(),
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

                  TimeOfDay? pickedTimeSalida =
                      await showTimePicker(context: context, initialTime: time);
                  if (pickedTimeSalida != null && pickedTimeSalida != time) {
                    _con.timeInputSalida.text =
                        _con.formatTimeOfDay(pickedTimeSalida);
                    setState(() {
                      time = pickedTimeSalida;
                      _con.boleta.horaSalida =
                          _con.formatTimeOfDay(pickedTimeSalida);
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
              TextFormField(
                controller: _con.timeInputRetorno,
                decoration: InputDecoration(
                    icon: Icon(Icons.timelapse),
                    labelText: "Ingrese la Hora de Retorno"),
                readOnly: true,
                onTap: () async {
                  TimeOfDay time = TimeOfDay.now();
                  _con.boleta.horaRetorno = time.format(context);
                  FocusScope.of(context).requestFocus(new FocusNode());

                  TimeOfDay? pickedTimeSalida =
                      await showTimePicker(context: context, initialTime: time);
                  if (pickedTimeSalida != null && pickedTimeSalida != time) {
                    _con.timeInputRetorno.text =
                        _con.formatTimeOfDay(pickedTimeSalida);
                    setState(() {
                      time = pickedTimeSalida;
                      _con.boleta.horaRetorno =
                          _con.formatTimeOfDay(pickedTimeSalida);
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _con.guardarBoletaPermiso(context);
          },
          label: Text('Guardar Permiso'),
        ),
      ),
    );
  }
}
