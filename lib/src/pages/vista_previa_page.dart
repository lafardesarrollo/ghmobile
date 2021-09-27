import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class VistaPreviaPage extends StatefulWidget {
  final String? image;
  final String? heroTag;

  const VistaPreviaPage({Key? key, this.image, this.heroTag}) : super(key: key);

  @override
  _VistaPreviaPageWidgetState createState() => _VistaPreviaPageWidgetState();
}

class _VistaPreviaPageWidgetState extends State<VistaPreviaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.pop(context, false),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: GestureDetector(
            child: Hero(
                tag: widget.heroTag!,
                child: PhotoView(
                  imageProvider: AssetImage(widget.image!),
                )),
          ),
        ));
  }
}
