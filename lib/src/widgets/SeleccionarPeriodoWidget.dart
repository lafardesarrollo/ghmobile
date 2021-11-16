import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/models/periodo_boleta.dart';
import 'package:ghmobile/src/repository/asistencia_repository.dart';

class SeleccionarPeriodoWidget extends StatefulWidget {
  List<PeriodoBoleta>? periodos;
  List<String>? gestiones;
  SeleccionarPeriodoWidget({Key? key, this.periodos, this.gestiones})
      : super(key: key);

  @override
  State<SeleccionarPeriodoWidget> createState() =>
      _SeleccionarPeriodoWidgetState();
}

class _SeleccionarPeriodoWidgetState extends State<SeleccionarPeriodoWidget> {
  String gestionSeleccionada = (DateTime.now().year).toString(); // "2021";
  List<PeriodoBoleta> periodosFiltrados = [];

  @override
  void initState() {
    // TODO: implement initState
    this.filtrarPeriodos(widget.periodos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: DropdownButton<String>(
              value: gestionSeleccionada,
              icon: Icon(Icons.arrow_downward),
              onChanged: (String? newValue) {
                setState(() {
                  gestionSeleccionada = newValue!;
                  filtrarPeriodos(widget.periodos);
                });
              },
              items: widget.gestiones!
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Seleccionar Periodo',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      body: ListView.builder(
        itemCount: periodosFiltrados.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () => Navigator.pop(
                context,
                periodosFiltrados.elementAt(index).periodo,
              ),
              leading: CircleAvatar(
                child: Text(periodosFiltrados.elementAt(index).mes!),
              ),
              title: Text(periodosFiltrados.elementAt(index).nombreMes! +
                  ' - ' +
                  periodosFiltrados.elementAt(index).gestion!),
              trailing: Icon(Icons.check_box_outline_blank_rounded),
              // subtitle: Text(widget.periodos!.elementAt(index).periodo!),
            ),
          );
        },
      ),
      /*
      body: GridView.builder(
        itemCount: periodos!.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pop(context, periodos!.elementAt(index));
            },
            child: Container(
              // padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              child: Center(
                child: Text(
                  periodos!.elementAt(index).periodo!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).accentColor),
                // color: Colors.amber,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
      ),
      */
    );
  }

  void filtrarPeriodos(List<PeriodoBoleta>? periodos) {
    String gestionActual = (DateTime.now().year).toString();
    int mesActual = (DateTime.now().month);
    periodosFiltrados = [];
    periodos!.forEach((element) {
      if (element.gestion == gestionSeleccionada) {
        if (element.gestion == gestionActual &&
            int.parse(element.mes!) == mesActual) {
        } else {
          periodosFiltrados.add(element);
        }
      }
    });
  }
}
