import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/controllers/main_page_controller.dart';
import 'package:ghmobile/src/pages/vista_previa_page.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:ghmobile/src/widgets/CabeceraItemsCaruselWidget.dart';
import 'package:ghmobile/src/widgets/CaruselCumpleanerosWidget.dart';
import 'package:ghmobile/src/widgets/ComunicacionRapidaWidget.dart';
import 'package:ghmobile/src/widgets/DrawerWidget.dart';
import 'package:ghmobile/src/widgets/SliderPublicidadWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends StateMVC<MainPage>
    with SingleTickerProviderStateMixin {
  Animation? animationOpacity;
  AnimationController? animationController;
  late MainPageController _con;
  double width_size = 0;
  double height_size = 0;

  _MainPageState() : super(MainPageController()) {
    _con = controller as MainPageController;
  }

  @override
  void initState() {
    _con.getLocalization();
    _con.obtenerPublicacionesIntranet(context);
    _con.obtenerCumpleanerosMes(context);
    _con.obtenerSaldoVacaciones(int.parse(currentUser.value.idSap!));
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController!, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width_size = MediaQuery.of(context).size.width;
    height_size = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _con.scaffoldKey,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (context) => IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.bars,
                  color: Theme.of(context).hintColor,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            actions: [
              Bounce(
                infinite: true,
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Image.asset(
                      'assets/img/kill_bacter.png',
                    ),
                  ), // FaIcon(FontAwesomeIcons.syncAlt),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return VistaPreviaPage(
                        heroTag: 'k01',
                        image: 'assets/img/triptico_kill_bacter.jpg',
                      );
                    }));
                    // _con.refreshHome();
                  },
                ),
              )
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Lafarnet',
              style: Theme.of(context).textTheme.bodyText1,
            )),
        drawer: DrawerWidget(),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton.large(
          backgroundColor: Colors.blue.withOpacity(0.4),
          onPressed: () {
            _con.abrirNuevoMarcaje(context);
          },
          child: Icon(
            Icons.fingerprint,
            size: 90,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _con.obtenerSaldoVacaciones(int.parse(currentUser.value.idSap!));
          },
          child: Container(
            child: ListView(
              children: [
                Card(
                  color: Theme.of(context).hintColor,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                          child: Text(
                            'Mi Saldo Actual de Vacaciones',
                            style: Theme.of(context).textTheme.overline,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${_con.saldoDias} dia(s)',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                CabeceraItemsCaruselWidget(
                  icono: FaIcon(FontAwesomeIcons.newspaper,
                      color: Theme.of(context).accentColor),
                  titulo: 'Publicaciones de la Intranet',
                ),
                SliderPublicidadWidget(publicaciones: _con.publicaciones),
                ComunicacionRapidaWidget(),
                // Card(
                //   color: Theme.of(context).accentColor,
                //   child: Center(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         Container(
                //           padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                //           child: Text(
                //             'CUMPLEAÑEROS DEL MES',
                //             style: Theme.of(context).textTheme.overline,
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Text(
                //             _con.cumpleaneros.length.toString() + ' empleados',
                //             style: TextStyle(
                //                 fontSize: 35,
                //                 fontWeight: FontWeight.bold,
                //                 color: Theme.of(context).secondaryHeaderColor),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(bottom: 10),
                //           child: ElevatedButton.icon(
                //             style: ElevatedButton.styleFrom(
                //                 primary: Theme.of(context).hintColor),
                //             onPressed: () {
                //               _con.abrirCumpleaneros(context);
                //             },
                //             icon: Icon(Icons.supervised_user_circle_sharp),
                //             label: Text('Ver cumpleañeros'),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                CabeceraItemsCaruselWidget(
                  icono: FaIcon(FontAwesomeIcons.birthdayCake,
                      color: Theme.of(context).accentColor),
                  titulo: 'Cumpleañeros del Mes',
                ),
                CaruselCumpleanerosWidget(
                  cumpleaneros: _con.cumpleaneros,
                ),
                Card(
                  color: Colors.red,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                          child: Text(
                            'TIEMPO ACUMULADO DE RETRASOS',
                            style: Theme.of(context).textTheme.overline,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '13 MINUTOS',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
