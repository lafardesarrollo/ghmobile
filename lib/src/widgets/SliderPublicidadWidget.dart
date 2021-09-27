import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ghmobile/src/models/publicacion.dart';
import 'package:ghmobile/src/widgets/CardsCarouselLoaderWidget.dart';
import 'package:photo_view/photo_view.dart';
import '../../src/helpers/app_config.dart' as config;

// ignore: must_be_immutable
class SliderPublicidadWidget extends StatefulWidget {
  List<Publicacion>? publicaciones;
  SliderPublicidadWidget({Key? key, this.publicaciones}) : super(key: key);

  @override
  State<SliderPublicidadWidget> createState() => _SliderPublicidadWidgetState();
}

class _SliderPublicidadWidgetState extends State<SliderPublicidadWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
//      fit: StackFit.expand,
      children: <Widget>[
        widget.publicaciones!.isEmpty
            ? CardsCarouselLoaderWidget()
            : CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  scrollDirection: Axis.horizontal,
                  pageSnapping: false,
                  height: 300, // 240
                  viewportFraction: 1.0,
                  /*onPageChanged: (index) {
                  setState(() {
                    _current = index.toInt();
                  });
                },*/
                ),
                items: widget.publicaciones!.map((publicacion) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return DetailScreen(
                                  heroTag: '${publicacion.id}',
                                  image:
                                      'http://intranet.lafar.net/newApiLafarnet/assets/publicaciones_images/${publicacion.nombreAdjunto}',
                                );
                              }));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5),
                                  height: 300,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'http://intranet.lafar.net/newApiLafarnet/assets/publicaciones_images/${publicacion.nombreAdjunto}',
                                      ), // NetworkImage(slide.image.url,),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.2),
                                          offset: Offset(0, 4),
                                          blurRadius: 9)
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    width:
                                        MediaQuery.of(context).size.width - 10,
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(
                                            0.7), // Colors.blueGrey.withOpacity(0.9),
                                    // color: Colors.black,
                                    child: Column(
                                      children: [
                                        Text(
                                          publicacion.titulo!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          publicacion.fechaPublicacion!,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w200),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.bottomEnd,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              width: config.App(context).appWidth(45),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    '', //publicidad.detallePublicidad,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.fade,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ));
                    },
                  );
                }).toList(),
              ),
        Positioned(
          top: 25,
          right: 41,
          left: 41,
//          width: config.App(context).appWidth(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.publicaciones!.map((slide) {
              return Container(
                width: 20.0,
                height: 3.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: _current == widget.publicaciones!.indexOf(slide)
                        ? Theme.of(context).hintColor
                        : Theme.of(context).hintColor.withOpacity(0.3)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String? image;
  final String? heroTag;

  const DetailScreen({Key? key, this.image, this.heroTag}) : super(key: key);

  @override
  _DetailScreenWidgetState createState() => _DetailScreenWidgetState();
}

class _DetailScreenWidgetState extends State<DetailScreen> {
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
                  imageProvider: CachedNetworkImageProvider(widget.image!),
                )),
          ),
        ));
  }
}
