import 'package:artesanos_a_la_mano/src/bloc/cliente_blocs/cliente_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/cliente_model.dart';
import 'package:artesanos_a_la_mano/src/providers/cliente_provider.dart';
import 'package:artesanos_a_la_mano/src/theme/tema.dart';
import 'package:artesanos_a_la_mano/src/utils/utils.dart' as utils;
import 'package:artesanos_a_la_mano/src/utils/utils.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrarCliente extends StatefulWidget {
  @override
  _RegistrarClienteState createState() => _RegistrarClienteState();
}

class _RegistrarClienteState extends State<RegistrarCliente> {
  ClienteModel cliente = new ClienteModel();
  bool _cargando = false;

  ClienteProvider clienteProvider;

  BuildContext context1;

  ClienteBloc clienteBloc;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FondoCliente(),
        Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            flexibleSpace: FondoClienteBar(),
          ),
          body: _loginForm(context),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 50.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            // margin: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 0.5),
                    spreadRadius: 3.0,
                  )
                ]),
            child: Form(
              key: formKey,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Para registrarte \nIngresa tus datos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                    _nombre(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _apellidos(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _crearEmail(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _celular(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _usuario(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _crearPassword(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _crearBoton(),
                  ],
                ),
              ),
            ),
          ),
          // Text('¿Olvidó la contraseña?'),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _nombre() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          maxLength: 40,
          initialValue: cliente.nombre,
          maxLines: 1,
          decoration: InputDecoration(
            icon: Icon(Icons.person_pin, color: miTemaA.primaryColor),
            labelText: 'Nombre',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.brown, width: 2)),
          ),
          validator: (value) {
            if (value.length < 3) {
              return 'Ingresa un nombre de usuario';
            } else
              value = "Hola";
            return null;
          },
          onSaved: (value) => cliente.nombre = value,
        ) // onChanged: bloc.changeNombre,
        );
  }

  Widget _apellidos() {
    return StreamBuilder(
      // stream:  bloc.apellidosStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            initialValue: cliente.apellido,
            maxLength: 50,
            maxLines: 1,
            decoration: InputDecoration(
              icon: Icon(Icons.person_outline, color: miTemaA.primaryColor),
              labelText: 'Apellidos',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.brown, width: 2)),
            ),
            validator: (value) {
              if (value.length < 0)
                return 'Ingresa un nombre de usuario';
              else
                return null;
            },
            onSaved: (value) => cliente.apellido = value,
            // onChanged: bloc.changeApellido,
          ),
        );
      },
    );
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: cliente.correo,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: miTemaA.primaryColor),
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electrónico',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.brown, width: 2)),
        ),
        // onChanged: bloc.changeCorreo,
        onSaved: (value) => cliente.correo = value,
      ),
    );
  }

  Widget _celular() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        maxLength: 10,
        maxLines: 1,
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          icon: Icon(Icons.phone, color: miTemaA.primaryColor),
          labelText: 'Celular',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.brown, width: 2)),
        ),
        validator: (value) {
          if (utils.isNumeric(value) && value.length == 10)
            return null;
          else
            return 'Sólo números con 10 digitos';
        },
        onSaved: (value) => cliente.celular = int.parse(value),
      ),
    );
  }

  Widget _usuario() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: cliente.usuario,
        decoration: InputDecoration(
          icon: Icon(Icons.person_add, color: miTemaA.primaryColor),
          labelText: 'Nombre de usuario',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.brown, width: 2)),
        ),
        validator: (value) {
          if (value.length > 3)
            return null;
          else
            return 'Debe tener más de 3 caracteres';
        },
        onSaved: (value) => cliente.usuario = value,
        // onChanged: bloc.changeUsuario,
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: cliente.contrasea,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: miTemaA.primaryColor),
          labelText: 'Contraseña',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.brown, width: 2)),
        ),
        validator: (value) {
          if (value.length > 4)
            return null;
          else
            return 'Debe tener más de 4 caracteres';
        },
        onSaved: (value) => cliente.contrasea = value,
        // onChanged: bloc.changePassword,
      ),
    );
  }

  Widget _crearBoton() {
    return ElevatedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Agregar'),
      ),
      // onPressed: _sumbit
      onPressed: _cargando ? null : _sumbit,
    );
  }

  void _sumbit() async {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();

    setState(() {
      _cargando = true;
    });

    final clienteProvider = new ClienteProvider();
    await clienteProvider.nuevoCliente(cliente).then((value) {
      String estatus = value['Estatus'];
      String mensaje = value['Mensaje'];
      if (estatus == '500') {
        setState(() {
          _cargando = false;
        });
        return mostrarAlerta(context, mensaje);
      } else {
        if (estatus != '200') {
          setState(() {
            _cargando = false;
          });
          return mostrarAlerta(context, 'Algo salio mal, intentelo de nuevo');
        }
      }
      if (estatus == '200') {
        setState(() {
          //_cargando=false;
          mostrarSnackbar('Guardando información');
          Future.delayed(const Duration(milliseconds: 2000), () {
            Navigator.pop(context);
          });
        });
      }
    });
  }

  void imprimir() {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();

    Navigator.pop(context);
    return print(cliente.toJson());
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = new SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
      // action: SnackBarAction(
      //   label: 'VOLVER',
      //   onPressed: () => Navigator.pop(context, 'MenuArtesano')
      // ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
