import 'package:sistema_de_gestao_comercial/model/coordenada_bancaria_model.dart';

class EmpresaModel {
  int? id;
  String nome;
  String nif;
  String endereco;
  String cidade;
  var contactos = <ContactoModel>[];
  var coordenadas = <CoordenadaBancariaModel>[];
  String email;
  String? website;

  EmpresaModel(
      {this.id,
      required this.nome,
      required this.nif,
      required this.endereco,
      required this.cidade,
      required this.email,
      this.website,
      required this.contactos,
      required this.coordenadas});

  Map<String, Object?> get toMap => {
        "id": id,
        "nome": nome,
        "nif": nif,
        "endereco": endereco,
        "cidade": cidade,
        "email": email,
        "website": website
      };

  factory EmpresaModel.fromMap(
      Map<String, dynamic> empresa,
      List<ContactoModel> contactos,
      List<CoordenadaBancariaModel> coordenadas) {
    return EmpresaModel(
        id: empresa["id"],
        nome: empresa["nome"],
        nif: empresa["nif"],
        endereco: empresa["endereco"],
        cidade: empresa["cidade"],
        email: empresa["email"],
        website: empresa["website"],
        contactos: contactos,
        coordenadas: coordenadas);
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
      cidade.hashCode ^
      email.hashCode ^
      website.hashCode;

  @override
  String toString() {
    return "$email - $nif - $nome - $endereco - $cidade - $email - $website - $contactos - $coordenadas";
  }
}

class ContactoModel {
  int? id;
  int? empresaID;
  String telefone;
  // String? website;
  // String? email;

  ContactoModel({this.id, this.empresaID, required this.telefone});

  Map<String, Object?> get toMap {
    return {
      "id": id,
      "empresa_id": empresaID,
      "telefone": telefone,
    };
  }

  factory ContactoModel.fromMap(Map<String, dynamic> contacto) {
    return ContactoModel(
      id: contacto["id"],
      empresaID: contacto["empresa_id"],
      telefone: contacto["telefone"],
    );
  }
  @override
  bool operator ==(Object other) {
    return other is ContactoModel &&
        other.id == id &&
        other.empresaID == empresaID &&
        other.telefone == telefone;
    // other.website == website &&
    // other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ empresaID.hashCode ^ telefone.hashCode;

  @override
  String toString() {
    return "$id - $empresaID - $telefone";
  }
}
