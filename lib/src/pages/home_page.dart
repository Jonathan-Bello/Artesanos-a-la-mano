import 'package:artesanos_a_la_mano/src/theme/tema.dart';
import 'package:artesanos_a_la_mano/src/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:artesanos_a_la_mano/src/bloc/productoC_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';

class HomePage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final productosBloc = Provider.ofClienteProductos(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    prefs.ultimaPagina = "Home";
    return Scaffold(
      body: Stack(
        children: [
          HeaderDiagonalRect(),
          Column(
            children: <Widget>[
              SizedBox(height: height * .125),
              _imagenLogo(),
              SizedBox(height: 50.0),
              _butonCliente(context, productosBloc),
            ],
          ),
          Positioned(
            child: _butonArtesano(context),
            bottom: 20,
            left: width * .22,
          ),
        ],
      ),
    );
  }

  Widget _imagenLogo() {
    return Container(
      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
      alignment: AlignmentDirectional.center,
      child: Image(
        image: AssetImage('assets/img/propio/Logo2.png'),
        width: 300,
      ),
    );
  }

  Widget _butonArtesano(BuildContext context) {
    return TextButton(
      child: Center(
          child: Text(
        'Ingresar como Artesano',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          wordSpacing: 5.0,
          fontSize: 20.0,
          color: miTemaA.hintColor,
          decoration: TextDecoration.underline
        ),
      )),
      onPressed: () {
        timeDilation = 2.0;
        Navigator.pushNamed(context, 'login');
      },
    );
  }

  Widget _butonCliente(BuildContext context, ProductosClienteBloc bloc) {
    return ElevatedButton(
      child: Container(
          height: 50,
          width: 200,
          child: Center(
        child: Text(
          'Ingresar',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            wordSpacing: 5.0,
            fontSize: 20.0,
          ),
        ),
      )),
      onPressed: () {
        //bloc.cargarProductosRecientes();
        Navigator.pushNamed(context, 'loginCliente');
      },
    );
  }
}
