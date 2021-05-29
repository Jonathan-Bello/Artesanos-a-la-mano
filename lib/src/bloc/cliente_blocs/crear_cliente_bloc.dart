
import 'package:artesanos_a_la_mano/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class CrearClienteBloc with Validators{

  final _nombreController   = BehaviorSubject<String>();
  final _apellidosController = BehaviorSubject<String>();
  final _correoController = BehaviorSubject<String>();
  final _celularController = BehaviorSubject<String>();
  final _usuarioController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get nombreStream     => _nombreController.stream.transform(validarPalabra);
  Stream<String> get apellidosStream  => _apellidosController.stream.transform(validarPalabra);
  Stream<String> get correoStream     => _correoController.stream.transform(validarEmail);
  Stream<String> get celularStream    => _celularController.stream.transform(validarPalabra);
  Stream<String> get usuarioStream    => _usuarioController.stream.transform(validarUsuario);
  Stream<String> get passwordStream   => _passwordController.stream.transform(validarPassWord);

  //Validar que ambas estan lllenas
  Stream<bool> get formValidStream => 
  CombineLatestStream.combine6(nombreStream,apellidosStream,correoStream,celularStream,usuarioStream,passwordStream, 
  (n,a,c,cel,u,p) => true);

  // Insertar valores al Stream
  Function(String) get changeNombre     => _nombreController.sink.add;
  Function(String) get changeApellidos  => _apellidosController.sink.add;
  Function(String) get changeCorreo     => _correoController.sink.add;
  Function(String) get changeCelular    => _celularController.sink.add;
  Function(String) get changeUsuario    => _usuarioController.sink.add;
  Function(String) get changePassword   => _passwordController.sink.add;

  // Obtener el último valor ingresado a los streams
  // String get user    => _userController.value;
  // String get password => _passwordController.value;

  String get nombre     => _nombreController.value;
  String get apellidos  => _apellidosController.value;
  String get correo     => _correoController.value;
  String get celular    => _celularController.value;
  String get usuario    => _usuarioController.value;
  String get password   => _passwordController.value;

  dispose() {
    // _userController?.close();
    // _passwordController?.close();
  _nombreController?.close();
  _apellidosController?.close();
  _correoController?.close();
  _celularController?.close();
  _usuarioController?.close();
  _passwordController?.close();
  }
}