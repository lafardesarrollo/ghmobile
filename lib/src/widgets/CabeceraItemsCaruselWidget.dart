import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class CabeceraItemsCaruselWidget extends StatefulWidget {
  String? titulo;
  FaIcon? icono;
  CabeceraItemsCaruselWidget({Key? key, this.titulo, this.icono})
      : super(key: key);

  @override
  _CabeceraItemsCaruselWidgetState createState() =>
      _CabeceraItemsCaruselWidgetState();
}

class _CabeceraItemsCaruselWidgetState
    extends State<CabeceraItemsCaruselWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        /*leading: Image.asset(
          'assets/icon/productos_semana.png',
          width: 35.0,
        ),*/
        leading: widget.icono,
        title: Text(
          widget.titulo!,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
