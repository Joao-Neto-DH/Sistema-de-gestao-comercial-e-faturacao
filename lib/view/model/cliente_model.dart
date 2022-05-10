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
}
