import 'package:flutter/material.dart';
import 'package:ghmobile/src/helpers/helper.dart';
import 'package:ghmobile/src/models/usuario.dart';
import 'package:ghmobile/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/user_repository.dart' as repository;

class UserController extends ControllerMVC {
  Usuario usuario = new Usuario();

  String email = '';

  bool? hidePassword = true;
  bool loading = false;
  GlobalKey<FormState>? loginFormKey;
  GlobalKey<ScaffoldState>? scaffoldKey;

  late OverlayEntry loader;

  UserController() {
    // loader = Helper.overlayLoader(context);
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void iniciarSesion(BuildContext context) async {
    if (loginFormKey!.currentState!.validate()) {
      loader = Helper.overlayLoader(context);
      FocusScope.of(context).unfocus();
      Overlay.of(context)!.insert(loader);
      loginFormKey!.currentState!.save();
      final Stream<Usuario> stream = await login2(usuario);
      stream.listen((Usuario _usuario) {
        setState(() {
          if (_usuario.username == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Usuario o Contraseña incorrectos'),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Acceso aceptado!'),
                backgroundColor: Colors.blue,
              ),
            );
            Navigator.of(scaffoldKey!.currentContext!)
                .pushReplacementNamed('/Main');
          }
        });
      }, onError: (a) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ocurrio un error al Iniciar Sesión!'),
            backgroundColor: Colors.red,
          ),
        );
      }, onDone: () {
        loading = false;
        Helper.hideLoader(loader);
      });
    }
  }

  void login(BuildContext context) async {
    if (loginFormKey!.currentState!.validate()) {
      loader = Helper.overlayLoader(context);
      FocusScope.of(context).unfocus();
      Overlay.of(context)!.insert(loader);
      loginFormKey!.currentState!.save();

      repository.login(usuario).then((value) {
        if (value.username == null) {
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text('Usuario o Contraseña Incorrecto!'),
          ));
        } else {
          Navigator.of(scaffoldKey!.currentContext!)
              .pushReplacementNamed('/Main');
        }
        // loader.remove();
      }).catchError((e) {
        // loader.remove();
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('No existe esta cuenta, intente nuevamente'),
        ));
      }).whenComplete(() {
        // Helper.hideLoader(loader);
      });
    }
  }
}
// void cambiarContrasenia() async {
//   if (loginFormKey.currentState.validate()) {
//     loginFormKey.currentState.save();
//     if (nuevo_password == confirmar_password) {
//       Overlay.of(context).insert(loader);
//       repository
//           .changePassword(nuevo_password, confirmar_password)
//           .then((value) {
//         if (value != null && value == true) {
//           Navigator.of(scaffoldKey.currentContext)
//               .pushReplacementNamed('/Pages', arguments: 2);
//           // scaffoldKey?.currentState?.showSnackBar(SnackBar(
//           //   content: Text(
//           //       S.of(context).your_reset_link_has_been_sent_to_your_email),
//           //   backgroundColor: Theme.of(context).hintColor,
//           //   action: SnackBarAction(
//           //     label: S.of(context).ingresar,
//           //     onPressed: () {
//           //       Navigator.of(scaffoldKey.currentContext)
//           //           .pushReplacementNamed('/Pages', arguments: 2);
//           //     },
//           //   ),
//           //   duration: Duration(seconds: 50),
//           // ));
//         } else {
//           loader.remove();
//           scaffoldKey?.currentState?.showSnackBar(SnackBar(
//             content: Text(S.of(context).error_change_password),
//           ));
//         }
//       }).whenComplete(() {
//         Helper.hideLoader(loader);
//       });
//     } else {
//       scaffoldKey?.currentState?.showSnackBar(SnackBar(
//         content: Text('Las contraseñas no coinciden'),
//       ));
//     }
//   } else {
//     scaffoldKey?.currentState?.showSnackBar(SnackBar(
//       content: Text('Ingrese correctamente la información'),
//     ));
//   }

//   // repository.login(usuario).then((value) {
//   //   if (value != null && value.apiToken != null) {
//   //     if (value.estado == 0) {
//   //       Navigator.of(context).pushReplacementNamed('/Password');
//   //     } else {
//   //       Navigator.of(scaffoldKey.currentContext)
//   //           .pushReplacementNamed('/Pages', arguments: 2);
//   //     }
//   //   } else {
//   //     scaffoldKey?.currentState?.showSnackBar(SnackBar(
//   //       content: Text(S.of(context).wrong_email_or_password),
//   //     ));
//   //   }
//   // }).catchError((e) {
//   //   loader.remove();
//   //   scaffoldKey?.currentState?.showSnackBar(SnackBar(
//   //     content: Text(S.of(context).this_account_not_exist),
//   //   ));
//   // }).whenComplete(() {
//   //   Helper.hideLoader(loader);
//   // });
// }
// }

// void register() async {
//   FocusScope.of(context).unfocus();
//   if (loginFormKey.currentState.validate()) {
//     loginFormKey.currentState.save();
//     Overlay.of(context).insert(loader);
//     repository.register(usuario).then((value) {
//       if (value != null && value.apiToken != null) {
//         Navigator.of(scaffoldKey.currentContext)
//             .pushReplacementNamed('/Pages', arguments: 2);
//       } else {
//         scaffoldKey?.currentState?.showSnackBar(SnackBar(
//           content: Text(S.of(context).wrong_email_or_password),
//         ));
//       }
//     }).catchError((e) {
//       loader?.remove();
//       scaffoldKey?.currentState?.showSnackBar(SnackBar(
//         content: Text(S.of(context).this_email_account_exists),
//       ));
//     }).whenComplete(() {
//       Helper.hideLoader(loader);
//     });
//   }
// }

// void resetPassword() {
//   FocusScope.of(context).unfocus();
//   if (loginFormKey.currentState.validate()) {
//     loginFormKey.currentState.save();
//     Overlay.of(context).insert(loader);
//     print(email);
//     repository.resetPassword(usuario).then((value) {
//       if (value != null && value == true) {
//         scaffoldKey?.currentState?.showSnackBar(SnackBar(
//           content: Text(S.of(context).email_to_reset_password_verify),
//           action: SnackBarAction(
//             label: S.of(context).login,
//             onPressed: () {
//               Navigator.of(scaffoldKey.currentContext)
//                   .pushReplacementNamed('/Login');
//             },
//           ),
//           duration: Duration(seconds: 10),
//         ));
//       } else {
//         loader.remove();
//         scaffoldKey?.currentState?.showSnackBar(SnackBar(
//           content: Text(S.of(context).error_verify_email_settings),
//         ));
//       }
//     }).whenComplete(() {
//       Helper.hideLoader(loader);
//     });
//   }
// }
