import 'package:flutter/material.dart';

class InformacionMensajeWidget extends StatefulWidget {
  Icon? icono;
  String? mensaje;
  InformacionMensajeWidget({Key? key, this.icono, this.mensaje})
      : super(key: key);

  @override
  State<InformacionMensajeWidget> createState() =>
      _InformacionMensajeWidgetState();
}

class _InformacionMensajeWidgetState extends State<InformacionMensajeWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.info), Text(widget.mensaje!)],
      ),
    );
  }
}
