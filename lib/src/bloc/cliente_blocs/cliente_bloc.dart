

import 'package:artesanos_a_la_mano/src/models/cliente_model.dart';
import 'package:artesanos_a_la_mano/src/providers/cliente_provider.dart';
import 'package:rxdart/rxdart.dart';

class ClienteBloc{
  final _clienteProvider = new ClienteProvider();

  final _cargandoController = new BehaviorSubject<bool>();

  final _clienteController = new BehaviorSubject<ClienteModel>();
  Stream<ClienteModel> get clienteStream => _clienteController.stream;
  Function(ClienteModel) get chanceClienteStream => _clienteController.sink.add;
  ClienteModel get getcliente  => _clienteController.value;

  void agregarCliente(ClienteModel cliente) async {
    _cargandoController.sink.add(true);
    await _clienteProvider.nuevoCliente(cliente);
    _cargandoController.sink.add(false);
  }

  Future editarCliente (ClienteModel cliente) async{
    _cargandoController.sink.add(true);
    await _clienteProvider.actualizarCliente(cliente);
    _cargandoController.sink.add(false);
  }

  void cargarCliente (int id) async{
    final cliente = await _clienteProvider.getCliente(id);
    _clienteController.sink.add(cliente);
  }

  dispose(){
    _clienteController?.close();
    _cargandoController?.close();
  }
}