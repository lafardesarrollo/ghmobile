import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/user_repository.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              currentUser.value.username != null
                  ? Navigator.of(context).pushNamed('/Main')
                  : Navigator.of(context).pushNamed('/Login');
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(1),
              ),
              accountName: Text(
                currentUser.value.username!,
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              accountEmail: Text(
                currentUser.value.emailAddress!,
                style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                backgroundImage: NetworkImage(
                    'http://intranet.lafar.net/newApiLafarnet/assets/imagenes_users/' +
                        currentUser.value.foto!
                    // "https://www.kindpng.com/picc/m/33-338711_circle-user-icon-blue-hd-png-download.png"
                    ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Main');
            },
            leading: Icon(
              Icons.home_filled,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Inicio',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Boletas');
            },
            leading: Icon(
              Icons.description_outlined,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Mis Boletas de Pago',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Asistencia');
            },
            leading: Icon(
              Icons.fingerprint,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Mi Asistencia',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
          ),
          ExpansionTile(
            title: Text(
              'GLV',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            leading: Icon(
              Icons.access_time_sharp,
              color: Theme.of(context).accentColor,
            ),
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('/Permiso');
                },
                leading: Icon(
                  Icons.paste_rounded,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Permisos',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('/Vacacion');
                },
                leading: Icon(
                  Icons.text_rotate_vertical_sharp,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Vacaciones',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('/AutorizarPermiso');
                },
                leading: Icon(
                  Icons.check,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Autorizar Solicitudes',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              ),
            ],
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/MiSalud');
            },
            leading: Icon(
              Icons.description_outlined,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Mi Salud',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Organigrama');
          //   },
          //   leading: Icon(
          //     Icons.account_tree_sharp,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     'Organigrama',
          //     style: TextStyle(color: Theme.of(context).hintColor),
          //   ),
          // ),
          Divider(
            color: Theme.of(context).primaryColor,
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/ManualFunciones');
          //   },
          //   leading: Icon(
          //     Icons.menu_book,
          //     color: Theme.of(context).accentColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     'Mi Manual de Funciones',
          //     style: TextStyle(color: Theme.of(context).hintColor),
          //   ),
          // ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/ReglamentoInterno');
            },
            leading: Icon(
              Icons.receipt_long,
              color: Theme.of(context).accentColor.withOpacity(1),
            ),
            title: Text(
              'Reglamento Interno',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
          ),

          // ListTile(
          //   onTap: () {
          //     if (Theme.of(context).brightness == Brightness.dark) {
          //       setBrightness(Brightness.light);
          //       DynamicTheme.of(context).setBrightness(Brightness.light);
          //     } else {
          //       setBrightness(Brightness.dark);
          //       DynamicTheme.of(context).setBrightness(Brightness.dark);
          //     }
          //   },
          //   leading: new Image.asset(
          //     'assets/icon/quit.png',
          //     width: 35.0,
          //   ),
          //   title: Text(
          //     Theme.of(context).brightness == Brightness.dark
          //         ? S.of(context).light_mode
          //         : S.of(context).dark_mode,
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          ListTile(
            onTap: () {
              if (currentUser.value.username != null) {
                logout().then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/Login', (Route<dynamic> route) => false);
                });
              } else {
                Navigator.of(context).pushNamed('/Login');
              }
            },
            leading: Icon(
              Icons.logout_rounded,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              currentUser.value.username != null
                  ? 'Cerrar Sesión'
                  : 'Iniciar Sesión',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
          ),
          currentUser.value.username == null
              // ? ListTile(
              //     onTap: () {
              //       Navigator.of(context).pushNamed('/SignUp');
              //     },
              //     leading: Icon(
              //       Icons.person_add,
              //       color: Theme.of(context).focusColor.withOpacity(1),
              //     ),
              //     title: Text(
              //       S.of(context).register,
              //       style: Theme.of(context).textTheme.subhead,
              //     ),
              //   )
              ? SizedBox(height: 0)
              : SizedBox(height: 0),
          ListTile(
            dense: true,
            title: Text(
              'Versión: ' + " 1.0.0", // + setting.value.appVersion,
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          )
        ],
      ),
    );
  }

  launchURL(String url) async {
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'No se pudo abrir la url $url';
    // }
  }
}
