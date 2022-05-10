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
}
