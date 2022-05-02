import 'package:image_picker/image_picker.dart';

class LoadImage {
  /// Carrega a imagem a partir do telefone e retorna uma
  /// Future<String> vazia caso nenhuma tenha sido selecionanda

  Future<String> pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    return file != null ? file.path : "";
    // setPath(file);
  }
}
