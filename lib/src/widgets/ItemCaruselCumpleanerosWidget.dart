import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:ghmobile/src/helpers/helper.dart';
import 'package:ghmobile/src/models/cumpleaneros.dart';

class ItemCaruselCumpleanerosWidget extends StatelessWidget {
  String? heroTag;
  double? marginLeft;
  Cumpleaneros? cumpleanero;

  ItemCaruselCumpleanerosWidget(
      {Key? key, this.heroTag, this.marginLeft, this.cumpleanero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(left: this.marginLeft!, right: 20),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Hero(
              tag: heroTag! + cumpleanero!.idSap.toString(),
              child: Container(
                width: 160,
                height: 200,
                child: ClipRect(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: Helper.getUrlImagenes(cumpleanero!.foto!),
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/img/profile_blue.png'),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 150),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              width: 140,
              height: 120,
              decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cumpleanero!.primerNombre! +
                        " " +
                        cumpleanero!.segundoNombre!,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 10), // Theme.of(context).textTheme.body2,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    cumpleanero!.apellidoPaterno! +
                        " " +
                        cumpleanero!.apellidoMaterno!,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 10), // Theme.of(context).textTheme.body2,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    formatDate(cumpleanero!.fechaNacimiento!, [M, '-', dd]),
                    style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(cumpleanero!.departamentoLfr!,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                  Text(
                    cumpleanero!.cargo ?? 'CARGO',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
