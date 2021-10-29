import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ghmobile/src/pages/vista_previa_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MiSaludWidget extends StatelessWidget {
  const MiSaludWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return VistaPreviaPage(
            heroTag: 'k01',
            image: 'assets/img/triptico_kill_bacter.jpg',
          );
        }));
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
            child: Image.asset('assets/img/killbacter.png'),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Cuida tu Salud',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  'El Coronavirus puede estar en',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  'cualquier parte, que no esté',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  'en tus manos',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Row(
                  children: [
                    Text(
                      '',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
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
