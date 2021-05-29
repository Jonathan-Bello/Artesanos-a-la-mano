import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:artesanos_a_la_mano/src/bloc/productoC_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';

class HomePage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  
  Widget build(BuildContext context) {
  final productosBloc= Provider.ofClienteProductos(context);
    prefs.ultimaPagina="Home";
    return Stack(
      children: <Widget>[
        FondoCliente(),
        Scaffold(
         backgroundColor: Colors.transparent,
         appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Artesanos a la Mano',
            style: TextStyle(
              color: Colors.brown, 
              fontStyle: FontStyle.italic, 
              wordSpacing: 5.0, fontSize: 30.0, 
              ),
            ),
          leading: Container(
            child: Image(image: AssetImage('assets/img/propio/rostro.png'),)
          ),
          centerTitle: true,
          flexibleSpace: FondoClienteBar()
          ),
          
          body:
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[ 
                  _imagenLogo(),
                  SizedBox(height: 50.0),
                  _butonCliente(context,productosBloc),
                  SizedBox(height: 50.0),
                  _butonArtesano(context),
                  SizedBox(height: 100,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _imagenLogo(){
    return Container(
      padding: EdgeInsets.only(top: 30, left: 20,right: 20),
      child: Card(
        color: Color.fromRGBO(255, 180, 10, 0.5),
        child: Image(
          image: AssetImage('assets/img/propio/Logo2.png')
        ),
      )
    );
  }
  
  Widget _butonArtesano(BuildContext context){
    return RaisedButton(
      child: Container(
        height: 80,
        width: 250,
        child: Center(
          child: Text(
            'Ingresar como Artesano',
            style: TextStyle(
              fontStyle: FontStyle.italic, 
              wordSpacing: 5.0,
              fontSize: 20.0, 
            ),
          )
        )
      ),
      color: Color.fromRGBO(255, 180, 10, 0.7),
      textColor: Colors.white,
      shape: StadiumBorder(),
      onPressed: (){
        timeDilation = 2.0;
        Navigator.pushNamed(
          context, 'login'
        );
      },
    );
  }

  Widget _butonCliente(BuildContext context,ProductosClienteBloc bloc){
    return RaisedButton(
      child: Container(
        height: 80,
        width: 250,
        child: Center(
          child: Text(
            'Ingresar ',
            style: TextStyle(
              fontStyle: FontStyle.italic, 
              wordSpacing: 5.0,
              fontSize: 20.0, 
            ),
          )
        )
      ),
      color: Color.fromRGBO(255, 180, 10, 0.7),
      textColor: Colors.white,
      shape: StadiumBorder(),
      onPressed: (){
        //bloc.cargarProductosRecientes();
        Navigator.pushNamed(context, 'loginCliente');
      },
    );
  }
}