import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/widgets/ComunicacionRapidaWidget.dart';
import 'package:ghmobile/src/widgets/FormularioAccidentesWidget.dart';
import 'package:ghmobile/src/widgets/MiSaludWidget.dart';

class MiSaludPage extends StatelessWidget {
  const MiSaludPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).hintColor,
        title: Text('Mi Salud'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          MiSaludWidget(),
          ComunicacionRapidaWidget(),
          FormularioAccidentesWidget(),
        ],
      ),
    );
  }
}
