class EmpresaModel {
  int? id;
  String nome;
  String nif;
  String endereco;
  String cidade;
  var contacto = <Contacto>[];

  EmpresaModel(
      {this.id,
      required this.nome,
      required this.nif,
      required this.endereco,
      required this.cidade,
      required this.contacto});
}

class Contacto {
  int? id;
  String telefone;
  String? website;
  String? email;

  Contacto({this.id, this.website, this.email, required this.telefone});

  Map<String, Object?> get toMap {
    return {"id": id, "telefone": telefone, "website": website, "email": email};
  }

  factory Contacto.fromMap(Map<String, dynamic> contacto) {
    return Contacto(
      id: contacto["id"],
      telefone: contacto["telefone"],
      website: contacto["website"],
      email: contacto["email"],
    );
  }
  @override
  bool operator ==(Object other) {
    return other is Contacto &&
        other.id == id &&
        other.telefone == telefone &&
        other.website == website &&
        other.email == email;
  }

  @override
  int get hashCode =>
      id.hashCode ^ telefone.hashCode ^ website.hashCode ^ email.hashCode;
}
