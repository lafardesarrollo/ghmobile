import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FormularioAccidentesWidget extends StatelessWidget {
  const FormularioAccidentesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String _url =
            'https://app.smartsheet.com/b/form/3534aecdc9bd40feb0562fca87c416f7';
        await canLaunch(_url)
            ? await launch(_url)
            : throw 'Could not launch $_url';
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            // decoration: BoxDecoration(
            //   color: Colors.black,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Image.asset('assets/img/accidente.png'),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Accidente Laboral ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor),
                ),
                Text(
                  'En esta sección podrás registrar tu',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor),
                ),
                Text(
                  'accidente laboral para que podamos',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor),
                ),
                Text(
                  'brindarte ayuda necesaria',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor),
                ),
                Row(
                  children: [
                    Text(
                      'Presiona para Ingresar',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                    Icon(
                      Icons.touch_app,
                      color: Theme.of(context).hintColor,
                      size: 30,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
