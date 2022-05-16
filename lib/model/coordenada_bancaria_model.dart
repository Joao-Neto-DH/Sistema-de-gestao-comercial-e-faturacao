class CoordenadaBancariaModel {
  int? id;
  int? empresaID;
  String coordenada;
  String conta;

  CoordenadaBancariaModel(
      {this.id, this.empresaID, required this.coordenada, required this.conta});

  Map<String, Object?> get toMap {
    return {
      "id": id,
      "empresa_id": empresaID,
      "coordenada": coordenada,
      "conta": conta
    };
  }

  factory CoordenadaBancariaModel.fromMap(Map<String, dynamic> coodenada) {
    return CoordenadaBancariaModel(
      id: coodenada["id"],
      empresaID: coodenada["empresa_id"],
      coordenada: coodenada["coordenada"],
      conta: coodenada["conta"],
    );
  }
  @override
  bool operator ==(Object other) {
    return other is CoordenadaBancariaModel &&
        other.id == id &&
        other.empresaID == empresaID &&
        other.conta == conta &&
        other.coordenada == coordenada;
  }

  @override
  int get hashCode =>
      id.hashCode ^ empresaID.hashCode ^ coordenada.hashCode ^ conta.hashCode;
}
