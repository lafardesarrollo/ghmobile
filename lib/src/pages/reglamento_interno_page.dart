import 'package:flutter/material.dart';
import 'package:ghmobile/src/controllers/reglamento_controller.dart';
import 'package:ghmobile/src/models/libro_detalle.dart';
import 'package:ghmobile/src/widgets/CircularLoadingWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ReglamentoInternoPage extends StatefulWidget {
  const ReglamentoInternoPage({Key? key}) : super(key: key);

  @override
  ReglamentoInternoPageState createState() => ReglamentoInternoPageState();
}

class ReglamentoInternoPageState extends StateMVC<ReglamentoInternoPage> {
  late ReglamentoController _con;

  ReglamentoInternoPageState() : super(ReglamentoController()) {
    _con = controller as ReglamentoController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _con.obtenerLibro(context, 1);
    _con.listaTitulosLibro(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).hintColor,
        title: Text('Reglamento Interno LAFAR'),
      ),
      body: _con.loading
          ? CircularLoadingWidget(
              texto: 'Cargando Reglamento',
              height: MediaQuery.of(context).size.height,
            )
          : ListView.separated(
              itemCount: _con.titulosLibro.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    LibroDetalle idTitulo = _con.titulosLibro.elementAt(index);
                    _con.abrirLibroDetalle(context, idTitulo);
                  },
                  title: textoLibro(_con.titulosLibro.elementAt(index)),
                );
                // return
              },
              separatorBuilder: (context, index) => Divider(),
            ),
    );
  }

  Widget textoLibro(LibroDetalle texto) {
    TextStyle style = TextStyle();
    return Text(
      texto.texto!,
      style: style,
    );
  }
}
