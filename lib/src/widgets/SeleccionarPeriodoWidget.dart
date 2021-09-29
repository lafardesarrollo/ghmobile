import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SeleccionarPeriodoWidget extends StatelessWidget {
  List<String>? periodos;
  SeleccionarPeriodoWidget({Key? key, this.periodos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Seleccione un Periodo',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_new),
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                  periodos!.elementAt(index),
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
    );
  }
}
