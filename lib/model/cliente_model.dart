class ClienteModel {
  int? id;
  String nome;
  String endereco;
  String nif;
  String email;
  double credito;

  ClienteModel(
      {this.id,
      required this.nome,
      required this.nif,
      required this.endereco,
      required this.email,
      required this.credito});

  Map<String, Object?> get toMap {
    return {
      "id": id,
      "nome": nome,
      "endereco": endereco,
      "nif": nif,
      "email": email,
      "credito": credito,
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> cliente) {
    return ClienteModel(
        id: cliente["id"],
        nome: cliente["nome"],
        nif: cliente["nif"],
        endereco: cliente["endereco"],
        email: cliente["email"],
        credito: cliente["credito"] * 1.0);
  }
  @override
  bool operator ==(Object other) {
    return other is ClienteModel &&
        other.id == id &&
        other.nif == nif &&
        other.email == email;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      nome.hashCode ^
      email.hashCode ^
      endereco.hashCode ^
      nif.hashCode;
}
