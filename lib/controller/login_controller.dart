import '../dao/usuario_dao.dart';
import '../model/usuario_model.dart';

class LoginController {
  final dao = UsuarioDAO();

  Future<Map<String, Object?>> login(UsuarioModel usuario) async {
    var map = await dao.getUsuario(usuario);
    return map[0];
  }

  Future<int> signup(UsuarioModel usuario) async {
    // var dao = UsuarioDAO();
    return await dao.insert(usuario);
  }
}
