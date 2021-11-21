import 'package:flutter/material.dart';
import 'package:ghmobile/src/controllers/user_controller.dart';
import 'package:ghmobile/src/models/usuario.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart' as userRepo;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage> {
  late UserController _con;

  _LoginPageState() : super(UserController()) {
    _con = controller as UserController;
  }

  @override
  void initState() {
    super.initState();
    verificarSiEstaAutentificado();
  }

  void verificarSiEstaAutentificado() async {
    Usuario usuario = new Usuario();
    usuario = await userRepo.getCurrentUser();
    if (usuario.username != null) {
      Navigator.of(context).pushReplacementNamed('/Main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _con.scaffoldKey,
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.only(top: 100),
              shrinkWrap: true,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _con.loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/img/lafar_cyan.png',
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          initialValue: '',
                          validator: (username) {
                            if (username!.length == 0) {
                              return 'Este campo no puede estar vacio';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (input) => _con.usuario.userid = input,
                          decoration: InputDecoration(
                            labelText: 'Nombre de Usuario',
                            labelStyle:
                                TextStyle(color: Theme.of(context).hintColor),
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Nombre de Usuario',
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            // prefixIcon:
                            //     Icon(Icons.email, color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1))),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          validator: (pass) {
                            if (pass!.length == 0) {
                              return 'Este campo no puede estar vacio';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                          initialValue: '',
                          onSaved: (input) => _con.usuario.password = input,
                          obscureText: _con.hidePassword!,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            labelText: 'Contraseña',
                            labelStyle:
                                TextStyle(color: Theme.of(context).hintColor),
                            contentPadding: EdgeInsets.all(20),
                            hintText: '••••••••••••',
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            // prefixIcon: Icon(
                            //   Icons.lock_outline,
                            //   color: Theme.of(context).accentColor,
                            // ),
                            suffixIcon: IconButton(
                              icon: Icon(_con.hidePassword!
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                setState(() {
                                  _con.hidePassword = !_con.hidePassword!;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1))),
                          ),
                        ),
                        SizedBox(height: 40),
                        ButtonTheme(
                          minWidth: double.infinity,
                          height: 60,
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 80),
                            onPressed: () {
                              // _con.login(context);
                              _con.iniciarSesion(context);
                            },
                            child: Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                            color: Theme.of(context).hintColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
