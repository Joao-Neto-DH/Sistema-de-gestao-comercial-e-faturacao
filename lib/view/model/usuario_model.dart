class UsuarioModel {
  int? id;
  String email;
  String senha;
  String nome;

  UsuarioModel(
      {this.id, required this.email, required this.nome, required this.senha});

  Map<String, Object?> get toMap {
    return {"id": id, "nome": nome, "email": email, "senha": senha};
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> produto) {
    return UsuarioModel(
      id: produto["id"],
      nome: produto["nome"],
      email: produto["email"],
      senha: produto["senha"],
    );
  }
  @override
  bool operator ==(Object other) {
    return other is UsuarioModel &&
        other.id == id &&
        other.nome == nome &&
        other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode ^ email.hashCode;
}
