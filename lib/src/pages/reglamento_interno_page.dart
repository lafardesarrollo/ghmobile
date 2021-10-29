import 'package:flutter/material.dart';

class ReglamentoInternoPage extends StatefulWidget {
  const ReglamentoInternoPage({Key? key}) : super(key: key);

  @override
  State<ReglamentoInternoPage> createState() => _ReglamentoInternoPageState();
}

class _ReglamentoInternoPageState extends State<ReglamentoInternoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).hintColor,
          title: Text('Reglamento Interno LAFAR'),
        ),
        body: Container(
          child: Text('Reglamento Interno'),
        ));
  }
}
