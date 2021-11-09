import 'package:flutter/material.dart';
import 'package:ghmobile/src/models/titulo.dart';

class TituloPage extends StatefulWidget {
  Titulo? titulo;
  TituloPage({Key? key, this.titulo}) : super(key: key);

  @override
  State<TituloPage> createState() => TituloPageState();
}

class TituloPageState extends State<TituloPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(''),
        // elevation: 0,
        // backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            child: Image(
              image: AssetImage('assets/img/lafar_cyan.png'),
              width: 150,
              height: 150,
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Text(
                widget.titulo!.titulo!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          widget.titulo!.contenido!.length > 0
              ? Expanded(
                  child: ListView(
                    children: [
                      Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Text(widget.titulo!.contenido!),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          widget.titulo!.tieneCapitulo == 1
              ? Expanded(
                  child: ListView.builder(
                    itemCount: widget.titulo!.capitulos!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          widget.titulo!.capitulos!.elementAt(index).titulo!,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            text: (widget.titulo!.capitulos!
                                .elementAt(index)
                                .contenido!),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          // for (var i = 0; i < widget.titulo!.capitulos!.length; i++)
          //   ListTile(
          //     title: Text(
          //       widget.titulo!.capitulos!.elementAt(i).titulo!,
          //       style: TextStyle(
          //         color: Theme.of(context).accentColor,
          //       ),
          //     ),
          //     subtitle: Text(widget.titulo!.capitulos!.elementAt(i).contenido!),
          //   )
        ],
      ),
    );
  }
}
