import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ghmobile/src/models/cumpleaneros.dart';

import 'ItemCaruselCumpleanerosWidget.dart';

// ignore: must_be_immutable
class CaruselCumpleanerosWidget extends StatefulWidget {
  List<Cumpleaneros>? cumpleaneros;

  CaruselCumpleanerosWidget({Key? key, this.cumpleaneros}) : super(key: key);

  @override
  State<CaruselCumpleanerosWidget> createState() =>
      _CaruselCumpleanerosWidgetState();
}

class _CaruselCumpleanerosWidgetState extends State<CaruselCumpleanerosWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.cumpleaneros!.isEmpty
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
        : CarouselSlider.builder(
            itemCount: widget.cumpleaneros!.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              double _marginLeft = 0;
              (itemIndex == 0) ? _marginLeft = 20 : _marginLeft = 0;
              return ItemCaruselCumpleanerosWidget(
                heroTag: 'cumpleanero' + UniqueKey().toString(),
                marginLeft: _marginLeft,
                cumpleanero: widget.cumpleaneros!.elementAt(itemIndex),
              );
            },
            options: CarouselOptions(
              disableCenter: true,
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
          );
    // : Container(
    //     height: 300,
    //     margin: EdgeInsets.only(top: 10),
    //     child: ScrollablePositionedList.builder(
    //       itemCount: widget.cumpleaneros!.length,
    //       itemBuilder: (context, index) {
    //         double _marginLeft = 0;
    //         (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
    //         return ItemCaruselCumpleanerosWidget(
    //           heroTag: 'cumpleanero' + UniqueKey().toString(),
    //           marginLeft: _marginLeft,
    //           cumpleanero: widget.cumpleaneros!.elementAt(index),
    //         );
    //       },
    //       scrollDirection: Axis.horizontal,
    //     ),
    //   );
  }
}
