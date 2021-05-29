import 'package:artesanos_a_la_mano/src/bloc/cliente_blocs/cliente_bloc.dart';
import 'package:flutter/material.dart';

import 'package:artesanos_a_la_mano/src/bloc/cliente_blocs/login_cliente_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/municipios_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/productoC_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/validation_bloc.dart';

export 'package:artesanos_a_la_mano/src/bloc/cliente_blocs/login_cliente_bloc.dart';
export 'package:artesanos_a_la_mano/src/bloc/municipios_bloc.dart';
export 'package:artesanos_a_la_mano/src/bloc/productoC_bloc.dart';
export 'package:artesanos_a_la_mano/src/bloc/validation_bloc.dart';

import 'package:artesanos_a_la_mano/src/bloc/login_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/crear_user_broc.dart';
import 'package:artesanos_a_la_mano/src/bloc/producto_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/artesano_bloc.dart';

export 'package:artesanos_a_la_mano/src/bloc/login_bloc.dart';
export 'package:artesanos_a_la_mano/src/bloc/crear_user_broc.dart';
export 'package:artesanos_a_la_mano/src/bloc/producto_bloc.dart';
export 'package:artesanos_a_la_mano/src/bloc/artesano_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;

  factory Provider({ Key key, Widget child }) {

    if ( _instancia == null ) {
      _instancia = new Provider._internal(key: key, child: child );
    }
    return _instancia;
  }

  Provider._internal({ Key key, Widget child })
    : super(key: key, child: child );
    
  final loginBloc = LoginBloc();
  final crearUserBroc = CrearUserBloc();
  final productosBloc = ProductosBloc();
  final artesanoBloc = ArtesanoBloc();
  final validationBloc = ValidationBloc();
  final productosClienteBloc=ProductosClienteBloc();
  final municipiosBloc=MunicipiosBloc();
  final clienteBloc= ClienteBloc();

  final loginClienteBloc = LoginClienteBloc();
  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ) {
    return   context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static CrearUserBloc of1 (BuildContext context){
    return  context.dependOnInheritedWidgetOfExactType<Provider>().crearUserBroc;
  }

  static ProductosBloc ofProduc (BuildContext context){
    return  context.dependOnInheritedWidgetOfExactType<Provider>().productosBloc;
  }

  static ArtesanoBloc ofArtesano(BuildContext context){
    return  context.dependOnInheritedWidgetOfExactType<Provider>().artesanoBloc;
  }

  static ValidationBloc ofValitation(BuildContext context){
    return  context.dependOnInheritedWidgetOfExactType<Provider>().validationBloc;
  }
  static ProductosClienteBloc ofClienteProductos(BuildContext context){
    return  context.dependOnInheritedWidgetOfExactType<Provider>().productosClienteBloc;
  }
  
  static ClienteBloc ofCliente(BuildContext context){
    return  context.dependOnInheritedWidgetOfExactType<Provider>().clienteBloc;
  }

  static LoginClienteBloc ofClienteLogin (BuildContext context){
    return  context.dependOnInheritedWidgetOfExactType<Provider>().loginClienteBloc;
  }

  static MunicipiosBloc ofMunicipios (BuildContext context){
    return  context.dependOnInheritedWidgetOfExactType<Provider>().municipiosBloc;
  }
}