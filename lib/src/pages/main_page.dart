import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghmobile/src/controllers/main_page_controller.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:ghmobile/src/widgets/DrawerWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
    _con.obtenerSaldoVacaciones(638); // (currentUser.value.userid)
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
                // Container(
                //   padding: EdgeInsets.only(right: 20),
                //   child: DropdownButton<String>(
                //     value: _con.dropdownValue,
                //     icon: Icon(Icons.arrow_downward),
                //     onChanged: (String? newValue) {
                //       // setState(() {
                //       //   _con.dropdownValue = newValue;
                //       //   _con.listenSeguimientoUsuarioFecha(newValue);
                //       // });
                //     },
                //     items: <String>[
                //       'Hoy',
                //       'Ultima Semana',
                //       'Ultimo Mes',
                //       'Todo'
                //     ].map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //   ),
                // )
                // IconButton(
                //   icon: Icon(
                //     Icons.refresh,
                //     color: Theme.of(context).primaryColor,
                //   ), // FaIcon(FontAwesomeIcons.syncAlt),
                //   onPressed: () {
                //     // _con.refreshHome();
                //   },
                // )
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Lafarnet')),
          drawer: DrawerWidget(),
          // drawer: Theme(
          //   data: Theme.of(context)
          //       .copyWith(canvasColor: Colors.transparent.withOpacity(0.5)),
          //   child: DrawerWidget(),
          // ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     // _con.abrirAgregarNuevo();
          //   },
          //   backgroundColor: Theme.of(context).primaryColor,
          //   child: FaIcon(FontAwesomeIcons.calendarPlus),
          // ),
          body: Container(
            child: Column(
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
                            'Saldo Actual de Vacaciones',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '0 dia(s)',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
