import 'package:flutter/material.dart';
import 'package:ghmobile/src/pages/asistencia_page.dart';
import 'package:ghmobile/src/pages/autorizar_permiso_page.dart';
import 'package:ghmobile/src/pages/boleta_pago_page.dart';
import 'package:ghmobile/src/pages/login_page.dart';
import 'package:ghmobile/src/pages/main_page.dart';
import 'package:ghmobile/src/pages/manual_funciones_page.dart';
import 'package:ghmobile/src/pages/mi_salud_page.dart';
import 'package:ghmobile/src/pages/permiso_page.dart';
import 'package:ghmobile/src/pages/reglamento_interno_page.dart';
import 'package:ghmobile/src/pages/reglamento_page.dart';
import 'package:ghmobile/src/pages/splash_page.dart';
import 'package:ghmobile/src/pages/vacacion_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/Main':
        return MaterialPageRoute(builder: (_) => MainPage());
      case '/Boletas':
        return MaterialPageRoute(builder: (_) => BoletaPagoPage());
      case '/MiSalud':
        return MaterialPageRoute(builder: (_) => MiSaludPage());
      case '/Permiso':
        return MaterialPageRoute(builder: (_) => PermisoPage());
      case '/Vacacion':
        return MaterialPageRoute(builder: (_) => VacacionPage());
      case '/Asistencia':
        return MaterialPageRoute(builder: (_) => AsistenciaPage());
      case '/ManualFunciones':
        return MaterialPageRoute(builder: (_) => ManualFuncionesPage());
      case '/Reglamento':
        return MaterialPageRoute(builder: (_) => ReglamentoPage());
      case '/ReglamentoInterno':
        return MaterialPageRoute(builder: (_) => ReglamentoInternoPage());
      case '/AutorizarPermiso':
        return MaterialPageRoute(builder: (_) => AutorizarPermisoPage());
      // case '/AtencionSinRes':
      //   return MaterialPageRoute(builder: (_) => AtencionsinresPage());
      // case '/MisAtenciones':
      //   return MaterialPageRoute(builder: (_) => MisAtencionesPage());
      // case '/ModeloVehiculo':
      //   return MaterialPageRoute(builder: (_) => ModeloVehiculoPage());
      // case '/MiDetalleAtencion':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           MiDetalleAtencionPage(routeArgument: args as RouteArgument));
      // case '/AddVehiculo':
      //   return MaterialPageRoute(builder: (_) => AddVehiculoWidget());

      // case '/AddCliente':
      //   return MaterialPageRoute(builder: (_) => AddClientePage());

      // case '/Vehiculos':
      //   return MaterialPageRoute(builder: (_) => VehiculosPage());
      // case '/VerVehiculo':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           RecepcionPage(routeArgument: args as RouteArgument));

      // case '/Home':
      //   return MaterialPageRoute(builder: (_) => MainPage());
      // case '/Recepcion':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           RecepcionPage(routeArgument: args as RouteArgument));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: SizedBox(height: 0)));
    }
  }
}
