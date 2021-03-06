import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ComunicacionRapidaWidget extends StatelessWidget {
  const ComunicacionRapidaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String _url =
            'https://app.smartsheet.com/b/form/afbc8f3ef88d49428a45e4bd29396cca';
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
            child: Image.asset('assets/img/comunicacion_rapida_banner.png'),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Comunicación Rápida',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
                Text(
                  'de mi Salúd 2021',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
                Text(
                  'Si tienes sintomas de COVID 19 ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor),
                ),
                Text(
                  'Presiona para registrar tu estado',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor),
                ),
                Row(
                  children: [
                    Text(
                      'de salud',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                    Icon(
                      Icons.touch_app,
                      color: Colors.white,
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
