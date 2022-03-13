import 'package:flutter/material.dart';
import 'package:ghmobile/src/controllers/reglamento_controller.dart';
import 'package:ghmobile/src/models/libro_detalle.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LibroDetallePage extends StatefulWidget {
  LibroDetalle titulo;
  LibroDetallePage({Key? key, required this.titulo}) : super(key: key);

  @override
  LibroDetallePageState createState() => LibroDetallePageState();
}

class LibroDetallePageState extends StateMVC<LibroDetallePage> {
  late ReglamentoController _con;

  LibroDetallePageState() : super(ReglamentoController()) {
    _con = controller as ReglamentoController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listaDetalleLibroPorTitulo(context, widget.titulo.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo.texto.toString()),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _con.detalleLibro.length,
          itemBuilder: (context, i) {
            LibroDetalle d = new LibroDetalle();
            d = _con.detalleLibro.elementAt(i);
            return textoLibro(d);
          },
        ),
      ),
    );
  }

  Widget textoLibro(LibroDetalle texto) {
    TextStyle style = TextStyle();
    Text textoParrafo = new Text('');

    if (texto.tipoTexto == 'articulo') {
      Text txt = new Text(
        texto.texto!,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
      textoParrafo = txt;
    } else if (texto.tipoTexto == 'inciso') {
      Text txt = new Text(
        texto.inciso! + ') ' + texto.texto!,
        style: TextStyle(fontWeight: FontWeight.w300),
      );
      textoParrafo = txt;
    } else if (texto.tipoTexto == 'parrafo') {
      Text txt = new Text(
        texto.texto!,
        style: TextStyle(fontWeight: FontWeight.w300),
      );
      textoParrafo = txt;
    } else if (texto.tipoTexto == 'capitulo') {
      Text txt = new Text(
        texto.texto!.toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold),
      );
      textoParrafo = txt;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: textoParrafo,
    );
  }
}
