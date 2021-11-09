import 'package:flutter/material.dart';
import 'package:ghmobile/src/controllers/reglamento_controller.dart';
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
    _con.obtenerLibro(context, 1);
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
              itemCount: _con.libro.titulos!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    _con.abrirTitulo(
                        context, _con.libro.titulos!.elementAt(index));
                  },
                  title: Text(_con.libro.titulos!.elementAt(index).titulo!),
                );
                // return
              },
              separatorBuilder: (context, index) => Divider(),
            ),
    );
  }
}
