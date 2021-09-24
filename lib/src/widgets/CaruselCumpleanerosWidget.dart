import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghmobile/src/helpers/helper.dart';
import 'package:ghmobile/src/models/cumpleaneros.dart';
import 'package:ghmobile/src/widgets/ItemCaruselCumpleanerosWidget.dart';

// ignore: must_be_immutable
class CaruselCumpleanerosWidget extends StatelessWidget {
  List<Cumpleaneros>? cumpleaneros;

  CaruselCumpleanerosWidget({Key? key, this.cumpleaneros}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cumpleaneros!.isEmpty
        ? Container(
            height: 300,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                double _marginLeft = 0;
                (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                return Container(
                  margin:
                      EdgeInsetsDirectional.only(start: _marginLeft, end: 20),
                  width: 160,
                  height: 275,
                  child: Image.asset('assets/img/loading_trend.gif',
                      fit: BoxFit.contain),
                );
              },
              scrollDirection: Axis.horizontal,
            ))
        : Container(
            height: 300,
            margin: EdgeInsets.only(top: 10),
            child: ListView.builder(
              itemCount: cumpleaneros!.length,
              itemBuilder: (context, index) {
                double _marginLeft = 0;
                (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                return ItemCaruselCumpleanerosWidget(
                  heroTag: 'cumpleanero' + UniqueKey().toString(),
                  marginLeft: _marginLeft,
                  cumpleanero: cumpleaneros!.elementAt(index),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          );
  }
}
