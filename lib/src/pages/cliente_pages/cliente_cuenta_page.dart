import 'package:artesanos_a_la_mano/src/bloc/cliente_blocs/cliente_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/cliente_model.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:artesanos_a_la_mano/src/widgets/headers.dart';
import 'package:flutter/material.dart';

class ClienteCuenta extends StatefulWidget {
  //const ClienteCuenta({Key key}) : super(key: key);
  @override
  _ClienteCuentaState createState() => _ClienteCuentaState();
}

class _ClienteCuentaState extends State<ClienteCuenta> {
  final prefs = new PreferenciasUsuario();

  // bool _cargando=true;

  @override
  Widget build(BuildContext context) {
    final clienteBloc = Provider.ofCliente(context);
    clienteBloc.cargarCliente(prefs.idCliente);
    return Stack(
      children: <Widget>[
        FondoCliente(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              HeaderDiagonal(
                icon: Icons.account_circle,
                titulo: 'Tu cuenta',
                color1: Colors.orange,
                color2: Color.fromRGBO(232, 217, 56, 1),
              ),
              _datosCliente(clienteBloc),
              Positioned(
                top: 270,
                right: 10,
                child: Transform.rotate(
                  angle: 0.2,
                  child: ElevatedButton.icon(
                    label: Text('Editar'),
                    icon: Icon(
                      Icons.edit,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    onPressed: _editio,
                    // onPressed: ()=> null,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void _editio() {
    Navigator.pushNamed(context, 'EditarCuentaPage');
  }

  // void habilitar(){
  //   setState(() {
  //     _cargando=false;
  //   });
  // }

  Widget _datosCliente(ClienteBloc bloc) {
    return StreamBuilder(
        stream: bloc.clienteStream,
        builder: (BuildContext context, AsyncSnapshot<ClienteModel> snapshot) {
          if (snapshot.hasData) {
            // setState(() {
            // _cargando=false;
            // });
            final cliente = snapshot.data;
            final _screenSize = MediaQuery.of(context).size;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SafeArea(
                      child: Container(
                    height: 305.0,
                  )),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
                    width: _screenSize.width * .85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white54,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 3.0,
                              offset: Offset(0.0, 0.5),
                              spreadRadius: 3.0)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'nombre ${cliente.nombre}',
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'apellidos ${cliente.apellido}',
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'celular ${cliente.celular}',
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'correo ${cliente.correo}',
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  // ButtonGordo(
                  //   icon: FontAwesomeIcons.solidHeart,
                  //   texto: 'Tus favoritos',
                  //   color1: Colors.purple,
                  //   color2: Colors.red,
                  //   onPress: (){
                  //     Navigator.pushNamed(context, 'EditarCuentaPage');
                  //     // bloc.cargarProductosCategoria('Varios',prefs.idCliente);
                  //     // Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Varios');
                  //   },
                  // )
                  //SizedBox(height: 100,),
                ],
              ),
            );
          } else {
            return Column(
              children: <Widget>[
                SafeArea(
                    child: Container(
                  height: 400.0,
                )),
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.amber,
                  ),
                ),
              ],
            );
          }
        });
  }
}
