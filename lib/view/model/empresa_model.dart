class EmpresaModel {
  int? id;
  String nome;
  String nif;
  String endereco;
  String cidade;
  var contactos = <Contacto>[];

  EmpresaModel(
      {this.id,
      required this.nome,
      required this.nif,
      required this.endereco,
      required this.cidade,
      required this.contactos});

  Map<String, Object?> get toMap => {
        "id": id,
        "nome": nome,
        "nif": nif,
        "endereco": endereco,
        "cidade": cidade
      };

  factory EmpresaModel.fromMap(
      Map<String, dynamic> empresa, List<Contacto> contactos) {
    return EmpresaModel(
        id: empresa["id"],
        nome: empresa["nome"],
        nif: empresa["nif"],
        endereco: empresa["endereco"],
        cidade: empresa["cidade"],
        contactos: contactos);
  }
  @override
  bool operator ==(Object other) {
    return other is EmpresaModel &&
        other.id == id &&
        other.nome == nome &&
        other.nif == nif &&
        other.endereco == endereco &&
        other.cidade == cidade;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      nome.hashCode ^
      nif.hashCode ^
      nome.hashCode ^
      endereco.hashCode ^
      cidade.hashCode;
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
