import 'package:artesanos_a_la_mano/src/bloc/cliente_blocs/login_cliente_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/providers/cliente_provider.dart';
import 'package:artesanos_a_la_mano/src/utils/utils.dart';
import 'package:artesanos_a_la_mano/src/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCliente extends StatefulWidget {
  @override
  _LoginClienteState createState() => _LoginClienteState();
}

class _LoginClienteState extends State<LoginCliente> {
  final providerCliente = ClienteProvider();

  bool _cargando = false;

  @override
  Widget build(BuildContext context) {
    final loginBloc = Provider.ofClienteLogin(context);

    // double height = MediaQuery.of(context).size.height;

    Future<bool> _vaciarStream() async {
      loginBloc.changeUser("");
      loginBloc.changePassword("");
      return true;
    }

    return WillPopScope(
      onWillPop: _vaciarStream,
      child: Stack(
        children: <Widget>[
          // FondoCliente(),
          HeaderDiagonalRect(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(child: _loginForm(context)),
          )
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.ofClienteLogin(context);

    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: SizedBox(
            height: 80,
          )),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.account_box,
                    color: Colors.black,
                    size: 70,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Inicia Sesión',
                  style: TextStyle(
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
                    fontSize: 30.0,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                _ingresarCliente(bloc),
                SizedBox(
                  height: 20,
                ),
                _ingresarPassword(bloc),
                SizedBox(
                  height: 20,
                ),
                _crearBoton(context, bloc),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 30.0),
            width: size.width * .85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 0.5),
                  spreadRadius: 3.0,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '¿Aún no tienes un cuenta?',
            style: TextStyle(color: Colors.white70),
          ),
          ElevatedButton(
            child: Container(
              child: Text('Registrate'),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'crearCliente');
            },
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget _ingresarCliente(LoginClienteBloc bloc) {
    return StreamBuilder(
      stream: bloc.userStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle, color: Colors.black54),
              hintText: 'NombreUsuario',
              labelText: 'Nombre de cliente',
              //counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeUser,
          ),
        );
      },
    );
  }

  Widget _ingresarPassword(LoginClienteBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock, color: Colors.black54),
                    labelText: 'Contraseña',
                    errorText: snapshot.error),
                onChanged: bloc.changePassword),
          );
        });
  }

  Widget _crearBoton(BuildContext context, LoginClienteBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
            child: Text('Ingresar'),
          ),
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          onPressed: snapshot.hasData && _cargando == false
              ? () async {
                  mostrarCarga(context);
                  await _login(bloc, context);
                }
              : null,
        );
      },
    );
  }

  _login(LoginClienteBloc bloc, BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _cargando = true;
    });

    await providerCliente.loginCliente(bloc.user, bloc.password).then((value) {
      String estatus = value['Estatus'];
      int id = value['IdCliente'];
      _guardar(id);
      if (estatus == "200") {
        Navigator.pushReplacementNamed(context, 'ClienteHome');
        bloc.changeUser('');
        bloc.changePassword('');
        // ProductosClienteBloc blocP = new ProductosClienteBloc();
        final productosBloc = Provider.ofClienteProductos(context);
        productosBloc.cargarProductosRecientes(id);
        //_cargando=false;
      } else {
        _crearAlert(context);
      }
    });

    setState(() {
      _cargando = false;
    });
  }

  _guardar(int id) async {
    if (id == null) {
      return;
    }
    final pref = await SharedPreferences.getInstance();
    final key = 'ClienteId';
    pref.setInt(key, id);
  }

  Future<void> _crearAlert(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext c) {
          return AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(fontSize: 25.0),
            ),
            content: Text('Por favor, inténtelo de nuevo'),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(color: Colors.blueAccent))),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
