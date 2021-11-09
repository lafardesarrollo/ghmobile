class Capitulo {
  Capitulo({
    this.id,
    this.idTitulo,
    this.titulo,
    this.contenido,
  });

  int? id;
  int? idTitulo;
  String? titulo;
  String? contenido;

  factory Capitulo.fromJson(Map<String, dynamic> json) => Capitulo(
        id: json["id"],
        idTitulo: json["idTitulo"],
        titulo: json["titulo"],
        contenido: json["contenido"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idTitulo": idTitulo,
        "titulo": titulo,
        "contenido": contenido,
      };
}
