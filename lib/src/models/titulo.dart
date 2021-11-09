import 'capitulo.dart';

class Titulo {
  Titulo({
    this.id,
    this.idLibro,
    this.titulo,
    this.contenido,
    this.tieneCapitulo,
    this.capitulos,
  });

  int? id;
  int? idLibro;
  String? titulo;
  String? contenido;
  int? tieneCapitulo;
  List<Capitulo>? capitulos;

  factory Titulo.fromJson(Map<String, dynamic> json) => Titulo(
        id: json["id"],
        idLibro: json["idLibro"],
        titulo: json["titulo"],
        contenido: json["contenido"],
        tieneCapitulo: json["tieneCapitulo"],
        capitulos: json["capitulos"] == null
            ? null
            : List<Capitulo>.from(
                json["capitulos"].map((x) => Capitulo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idLibro": idLibro,
        "titulo": titulo,
        "contenido": contenido,
        "tieneCapitulo": tieneCapitulo,
        "capitulos": capitulos == null
            ? null
            : List<dynamic>.from(capitulos!.map((x) => x.toJson())),
      };
}
