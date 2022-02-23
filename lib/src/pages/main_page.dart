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
import 'package:ghmobile/src/widgets/FormularioAccidentesWidget.dart';
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

    _con.getPeriodoActual();
    // _con.getAtrasosMesActual(currentUser.value.idSap!);
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
                      'assets/img/lafar_cyan.png',
                    ),
                  ), // FaIcon(FontAwesomeIcons.syncAlt),
                  onPressed: () {
                    _con.abrirIntranet();
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
          backgroundColor: Colors.blue.withOpacity(0.2),
          onPressed: () {
            _con.abrirNuevoMarcaje(context);
          },
          child: Icon(
            Icons.fingerprint,
            size: 90,
            color: Theme.of(context).primaryColor,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _con.obtenerSaldoVacaciones(int.parse(currentUser.value.idSap!));
          },
          child: Container(
            child: ListView(
              children: [
                CabeceraItemsCaruselWidget(
                  icono: FaIcon(FontAwesomeIcons.newspaper,
                      color: Theme.of(context).accentColor),
                  titulo: 'Publicaciones de la Intranet',
                ),
                SliderPublicidadWidget(publicaciones: _con.publicaciones),
                SizedBox(
                  height: 5,
                ),
                _con.cumpleaneros.length > 0
                    ? CabeceraItemsCaruselWidget(
                        icono: FaIcon(FontAwesomeIcons.birthdayCake,
                            color: Theme.of(context).accentColor),
                        titulo: 'Cumpleañeros del Mes',
                      )
                    : Container(),
                _con.cumpleaneros.length > 0
                    ? CaruselCumpleanerosWidget(
                        cumpleaneros: _con.cumpleaneros,
                      )
                    : Container(),
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
                Card(
                  color: Theme.of(context).accentColor,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                          child: Text(
                            'Tiempo acumulado de Atrasos',
                            style: Theme.of(context).textTheme.overline,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _con.atrasos.retrasoTotal == null
                              ? CircularProgressIndicator()
                              : Text(
                                  _con.atrasos.retrasoTotal.toString() +
                                      ' minutos',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor),
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
