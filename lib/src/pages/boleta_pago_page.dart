import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/controllers/boleta_pago_controller.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:ghmobile/src/widgets/DrawerWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class BoletaPagoPage extends StatefulWidget {
  const BoletaPagoPage({Key? key}) : super(key: key);

  @override
  BoletaPagoPageState createState() => BoletaPagoPageState();
}

class BoletaPagoPageState extends StateMVC<BoletaPagoPage> {
  late BoletaPagoController _con;

  BoletaPagoPageState() : super(BoletaPagoController()) {
    _con = controller as BoletaPagoController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.requestBoleta.empId = int.parse(currentUser.value.idSap!);
    // _con.requestBoleta.empId = currentUser.value.!
    _con.requestBoleta.periodo = "202108";
    _con.obtenerBoletaPago();
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
            Container(
              padding: EdgeInsets.only(right: 20),
              child: DropdownButton<String>(
                value: _con.dropdownValue,
                icon: Icon(Icons.arrow_downward),
                onChanged: (String? newValue) {
                  setState(() {
                    _con.dropdownValue = newValue!;
                    if (newValue == 'Agosto') {
                      _con.requestBoleta.periodo = "202108";
                    } else if (newValue == 'Julio') {
                      _con.requestBoleta.periodo = "202107";
                    } else {
                      _con.requestBoleta.periodo = "202106";
                    }
                    _con.obtenerBoletaPago();
                  });
                },
                items: <String>['Agosto', 'Julio', 'Junio']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.filePdf,
                color: Theme.of(context).primaryColor,
              ), // FaIcon(FontAwesomeIcons.syncAlt),
              onPressed: () {
                // _con.refreshHome();
              },
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Boleta de Pago',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        drawer: DrawerWidget(),
        body: ListView(
          children: [
            Card(
              color: Theme.of(context).hintColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Nombre: ' + _con.boleta.nombre.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      'Sucursal: ' + _con.boleta.sucursal.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      'Cargo: ' + _con.boleta.cargo.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sueldo Bàsico:',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.salarioBCalculado.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bono Antiguedad:',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.bantiguedad.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bono Frontera:',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.bfrontera.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bono Dominical:',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.bdominical.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bono de Producción:',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.bonoprod.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Horas Extras:',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.hextras.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Horas Extras Dominicales:',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.hextrasdom.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recargo Nocturno:',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.rnocturno.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Comisiones:',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.comisiones.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Otros Ingresos:',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.otrosing.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'AFP PREVISION 12.71%:',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.afp.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RC-I.V.A.',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.rciva.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Anticipo',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.bfrontera.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Prestamos',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.prestamos.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Aportes Sindicales',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.aporteSSindicales.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sanciones y Multas',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.sancioneSMultas.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Compras Personales',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.compraSPer.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rendición de Cuentas',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.rendiciones.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Refrigerio',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.refrigerio.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Retenciones Judiciales',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.retenciones.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Descuentos Varios',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.descvarios.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Otros Descuentos',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    _con.boleta.descvarios.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
