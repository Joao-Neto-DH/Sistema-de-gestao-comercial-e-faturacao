class LogoModel {
  int? id;
  int? empresaID;
  String logo;
  bool? isFundo;

  LogoModel({this.id, this.empresaID, this.isFundo, required this.logo});

  Map<String, Object?> get toMap {
    return {
      "id": id,
      "empresa_id": empresaID,
      "logo": logo,
      "logo_marca": isFundo,
    };
  }

  factory LogoModel.fromMap(Map<String, dynamic> logo) {
    return LogoModel(
      id: logo["id"],
      empresaID: logo["empresa_id"],
      logo: logo["logo"],
      isFundo: logo["logo_marca"],
    );
  }
  @override
  bool operator ==(Object other) {
    return other is LogoModel &&
        other.id == id &&
        other.empresaID == empresaID &&
        other.logo == logo &&
        other.isFundo == isFundo;
  }

  @override
  int get hashCode =>
      id.hashCode ^ empresaID.hashCode ^ logo.hashCode ^ isFundo.hashCode;
}
