import 'package:artesanos_a_la_mano/src/bloc/municipios_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/widgets/drawer_cliente.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:flutter/material.dart';

class ListadoRegiones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final municipiosBloc= Provider.ofMunicipios(context);
    return Stack(
      children: <Widget>[
        FondoCliente(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            flexibleSpace: FondoClienteBar(),
            centerTitle: true,
            title: Text(
              'Regiones',
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                wordSpacing: 5.0,
                fontSize: 25.0,
              ),
            ),
          ),
          drawer: DrawerCliente(),
          body: Center(
            child: SingleChildScrollView(child: regiones(context,municipiosBloc)),
          ),
        )
      ],
    );
  }

  Widget regiones(BuildContext context,MunicipiosBloc bloc) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      width: size.width * .85,
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
        children: <Widget>[
          // Center(
          // //   child: Text(
          // //     'Tiendas por ',
          // //     style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          // //   ),
          // // ),
          // // Center(
          // //   child: Text(
          // //     'Regiones ',
          // //     style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          // //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          Container(
              child: Image(
            image: AssetImage('assets/img/Regiones_de_Puebla.png'),
            fit: BoxFit.cover,
          )),
          SizedBox(
            height: 20,
          ),
          regionesList(context,bloc),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget regionesList(BuildContext context,MunicipiosBloc bloc) {
    return Column(
      children: <Widget>[
        Container(
          child: Card(
            child: ListTile(
              title: Text(
                'I.- Huauchinango',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              onTap: () {
                bloc.cargarMuncipiosRegion(1);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 1);
              },
            ),
            color: Color.fromRGBO(255, 245, 0, .9),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          child: Card(
            child: ListTile(
              title: Text(
                'II.- Teziutlán',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onTap: () {
                bloc.cargarMuncipiosRegion(2);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 2);
              },
            ),
            color:Color.fromRGBO(35, 10, 100, .9),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          child: Card(
            child: ListTile(
              title: Text(
                'III.- Ciudad Serdán',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              onTap: () {
                bloc.cargarMuncipiosRegion(3);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 3);
              },
            ),
            color: Color.fromRGBO(231, 120, 23, 1.0),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          child: Card(
            child: ListTile(
              title: Text(
                'IV.- San Pedro Cholula',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              onTap: () {
                bloc.cargarMuncipiosRegion(4);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 4);
              },
            ),
            color: Color.fromRGBO(0, 147, 230, 1.0),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          child: Card(
            child: ListTile(
              title: Text(
                'V.- Puebla',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              onTap: () {
                bloc.cargarMuncipiosRegion(5);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 5);
              },
            ),
            color: Color.fromRGBO(0, 146, 63, 1.0),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          child: Card(
            child: ListTile(
              title: Text(
                'VI.- Izúcar De Matamoros',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              onTap: () {
                bloc.cargarMuncipiosRegion(6);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 6);
              },
            ),
            color: Color.fromRGBO(218, 37, 29, 1.0),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          child: Card(
            child: ListTile(
              title: Text(
                'VII.- Tehuacán Y Sierra Negra',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              onTap: () {
                bloc.cargarMuncipiosRegion(7);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 7);
              },
            ),
            color: Color.fromRGBO(151, 70, 108, .8),
          ),
        ),
      ],
    );
  }

 
}
