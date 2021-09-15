import 'package:flutter/material.dart';
import 'package:ghmobile/src/controllers/main_page_controller.dart';
import 'package:ghmobile/src/widgets/CircularLoadingWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:date_format/date_format.dart';

// ignore: must_be_immutable
class CumpleanerosPage extends StatefulWidget {
  CumpleanerosPage({Key? key});

  @override
  CumpleanerosPageState createState() => CumpleanerosPageState();
}

class CumpleanerosPageState extends StateMVC<CumpleanerosPage> {
  late MainPageController _con;

  CumpleanerosPageState() : super(MainPageController()) {
    _con = controller as MainPageController;
  }

  @override
  void initState() {
    _con.obtenerCumpleanerosMes(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cumpleañeros del Mes',
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
          actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.save_outlined,
//                 color: Theme.of(context).primaryColor,
//               ),
//               onPressed: () {
// //                 _con.checkMock();
//               },
//             )
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: _con.cumpleaneros.length > 0
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 3.5,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: _con.cumpleaneros.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Card(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: Image.network(
                                    'http://intranet.lafar.net/newApiLafarnet/assets/imagenes_users/' +
                                        _con.cumpleaneros
                                            .elementAt(index)
                                            .foto!,
                                    height: 50,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  _con.cumpleaneros
                                      .elementAt(index)
                                      .nombreCompleto!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                              Text(
                                formatDate(
                                    _con.cumpleaneros
                                        .elementAt(index)
                                        .fechaNacimiento!,
                                    [M, '-', dd]),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).accentColor),
                              ),
                              Text(
                                _con.cumpleaneros
                                    .elementAt(index)
                                    .departamentoLfr!,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(
                                _con.cumpleaneros.elementAt(index).cargo!,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            : CircularLoadingWidget(
                texto: 'Cargando...',
                height: 200,
              ),
      ),
    );
  }
}
