import '../dao/cliente_dao.dart';
import '../model/cliente_model.dart';

class ClienteController {
  final dao = ClienteDAO();

  Future<int> cadastrarCliente(ClienteModel cliente) async {
    final res = await dao.insert(cliente);
    // print(await dao.all);
    return res;
  }
}
