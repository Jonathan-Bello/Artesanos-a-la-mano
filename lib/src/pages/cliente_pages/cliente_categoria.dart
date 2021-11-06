import 'package:animate_do/animate_do.dart';
import 'package:artesanos_a_la_mano/src/bloc/productoC_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/widgets/boton_gordo.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:artesanos_a_la_mano/src/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClienteCategorias extends StatelessWidget {
  //const ClienteCategorias({Key key}) : super(key: key);
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final productosBloc= Provider.ofClienteProductos(context);
    return Container(
      child: Stack(
        children: <Widget>[
          FondoCliente(),
          Scaffold(
            body:  Stack(
              children: <Widget>[
                listado(context,productosBloc),
                _HeaderPage(),
              ],
            )
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   //flexibleSpace: Colors.transparent,
            //   //flexibleSpace: FondoClienteBar(),
            //   // centerTitle: true,
            //   // title: Text('Categorías',
            //   //   style: TextStyle(
            //   //   color: Colors.brown, 
            //   //   fontStyle: FontStyle.italic, 
            //   //   wordSpacing: 5.0, fontSize: 25.0, 
            //   //   ),
            //   // ),
            // ),
            // drawer: DrawerCliente(),
            //body: //SingleChildScrollView(child: listasCategorias(context,productosBloc)),
            //_crearListadoStream(productosBloc)
          )
        ],
      ),
    );
  }


  Widget listado(BuildContext context, ProductosClienteBloc bloc){

    return Container(
      margin: EdgeInsets.only(top:280),
      child: FadeInLeft(
        duration: Duration(milliseconds: 600),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            ButtonGordo(
            icon: Icons.free_breakfast,
            texto: 'Cerámica',
            color1: Color(0xff6989F5),
            color2: Color(0xff906EF5),
            onPress: (){
              bloc.cargarProductosCategoria('Cerámica',prefs.idCliente);
              Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Cerámica');
            },
            ),
            ButtonGordo(
            icon: FontAwesomeIcons.mortarPestle,
            texto: 'Barro',
            color1: Color(0xff66A9F2),
            color2: Color(0xff536CF6),
            onPress: (){
              bloc.cargarProductosCategoria('Barro',prefs.idCliente);
              Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Barro');
            },
            ),

            ButtonGordo(
            icon:  FontAwesomeIcons.tree,
            texto: 'Madera',
            color1:  Color(0xffF2D572),
            color2: Color(0xffE06AA3),
            onPress: (){
              bloc.cargarProductosCategoria('Madera',prefs.idCliente);
              Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Madera');
            },
            ),


            ButtonGordo(
            icon: FontAwesomeIcons.horse,
            texto: 'Piel y Cuero',
            color1: Color(0xff317183),
            color2: Color(0xff46997D),
            onPress: (){
              bloc.cargarProductosCategoria('Piel y Cuero',prefs.idCliente);
              Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Piel y Cuero');
            },
            ),

            ButtonGordo(
            icon: FontAwesomeIcons.glassMartini,
            texto: 'Mármol, Piedra y Vidrio',
            color1: Color(0xff0EC654),
            color2: Color(0xff53A271),
            onPress: (){
              bloc.cargarProductosCategoria('Mármol, Piedra y Vidrio',prefs.idCliente);
              Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Mármol, Piedra y Vidrio');
            },
            ),

            ButtonGordo(
            icon: FontAwesomeIcons.tshirt,
            texto: 'Textil',
            color1: Color(0xffF58C72),
            color2: Color(0xffF3471D),
            onPress: (){
              bloc.cargarProductosCategoria('Textil',prefs.idCliente);
              Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Textil');
            },
            ),

            ButtonGordo(
            icon: Icons.watch,
            texto: 'Metal',
            color1: Color(0xffB6C7BD),
            color2: Color(0xff7C8981),
            onPress: (){
              bloc.cargarProductosCategoria('Metal',prefs.idCliente);
              Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Metal');
            },
            ),

            ButtonGordo(
            icon: FontAwesomeIcons.sketch,
            texto: 'Joyería',
            color1: Color(0xffF09BEA),
            color2: Color(0xffF144E6),
            onPress: (){
              bloc.cargarProductosCategoria('Joyería',prefs.idCliente);
              Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Joyería');
            },
            ),

            ButtonGordo(
            icon: FontAwesomeIcons.gifts,
            texto: 'Varios',
            color1: Colors.amber,
            color2: Colors.orange,
            onPress: (){
              bloc.cargarProductosCategoria('Varios',prefs.idCliente);
              Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Varios');
            },
            ),

          ], 
        ),
      ),
    );
  }

  Widget listasCategorias(BuildContext context,ProductosClienteBloc bloc){
    final _screenSize= MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            //height: _screenSize.height*.08,
            width: _screenSize.width*.9,
            child: Card(
              child: ListTile(
                title: Text(
                  'Puede encontrar artesanías médiate los filtros de la siguientes categorías.',
                  style: TextStyle(fontSize: 20),
                ),
                // subtitle: Text('Ladrillero, Ceramista, Esmaltador, Alfareroinfosegovia.com Todos los derechos reservados.'),
                // trailing: Icon(Icons.category),
                // onTap: (){
                //   bloc.cargarProductosCategoria('Cerámica',prefs.idCliente);
                //   Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Cerámica');
                // },
              ),
            ),
          ),
        ),
        

        Center(
          child: Container(
            //height: _screenSize.height*.08,
            width: _screenSize.width*.8,
            child: Card(
              child: ListTile(
                title: Text(
                  'Cerámica',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('Ladrillero, Ceramista, Esmaltador, Alfareroinfosegovia.com Todos los derechos reservados.'),
                trailing: Icon(Icons.category),
                onTap: (){
                  bloc.cargarProductosCategoria('Cerámica',prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Cerámica');
                },
              ),
            ),
          ),
        ),


        Center(
          child: Container(
            //height: _screenSize.height*.08,
            width: _screenSize.width*.8,
            child: Card(
              child: ListTile(
                title: Text(
                  'Barro',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('----Dudas-----'),
                trailing: Icon(Icons.category),
                onTap: (){
                  bloc.cargarProductosCategoria('Barro',prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Barro');
                },
              ),
            ),
          ),
        ),


        Center(
          child: Container(
            //height: _screenSize.height*.08,
            width: _screenSize.width*.8,
            child: Card(
              child: ListTile(
                title: Text(
                  'Madera',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('Dorador, Tallista, Tornero.'),
                trailing: Icon(Icons.category),
                onTap: (){
                  bloc.cargarProductosCategoria('Madera',prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Madera');
                },
              ),
            ),
          ),
        ),

        Center(
          child: Container(
            //height: _screenSize.height*.08,
            width: _screenSize.width*.8,
            child: Card(
              child: ListTile(
                title: Text(
                  'Piel y Cuero',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('----------------'),
                trailing: Icon(Icons.category),
                onTap: (){
                  bloc.cargarProductosCategoria('Piel y Cuero',prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Piel y Cuero');
                },
              ),
            ),
          ),
        ),

        Center(
          child: Container(
            //height: _screenSize.height*.08,
            width: _screenSize.width*.8,
            child: Card(
              child: ListTile(
                title: Text(
                  'Mármol, Piedra y Vidrio',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('Cantero, Vidrio emplomado, Tallista de Cristal.'),
                trailing: Icon(Icons.category),
                onTap: (){
                  bloc.cargarProductosCategoria('Mármol, Piedra y Vidrio',prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Mármol, Piedra y Vidrio');
                },
              ),
            ),
          ),
        ),

        Center(
          child: Container(
            //height: _screenSize.height*.08,
            width: _screenSize.width*.8,
            child: Card(
              child: ListTile(
                title: Text(
                  'Textil',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('Telar, Telas pintadas, Bordado.'),
                trailing: Icon(Icons.category),
                onTap: (){
                  bloc.cargarProductosCategoria('Textil',prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Textil');
                },
              ),
            ),
          ),
        ),

        Center(
          child: Container(
            //height: _screenSize.height*.08,
            width: _screenSize.width*.8,
            child: Card(
              child: ListTile(
                title: Text(
                  'Metal',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('Cobre, Hierro, Estaño.'),
                trailing: Icon(Icons.category),
                onTap: (){
                  bloc.cargarProductosCategoria('Metal',prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Metal');
                },
              ),
            ),
          ),
        ),

        Center(
          child: Container(
            //height: _screenSize.height*.08,
            width: _screenSize.width*.8,
            child: Card(
              child: ListTile(
                title: Text(
                  'Joyería',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('Orfebrería.'),
                trailing: Icon(Icons.category),
                onTap: (){
                  bloc.cargarProductosCategoria('Joyería',prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Joyería');
                },
              ),
            ),
          ),
        ),

        Center(
          child: Container(
            //height: _screenSize.height*.08,
            width: _screenSize.width*.8,
            child: Card(
              child: ListTile(
                title: Text(
                  'Varios',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('Cerería, Flores secas, Perfumista, Relojero, Tapicero, Fundidor, Restauración, Grabador.'),
                trailing: Icon(Icons.category),
                onTap: (){
                  bloc.cargarProductosCategoria('Varios',prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Varios');
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}

class _HeaderPage extends StatelessWidget {
  const _HeaderPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconHeader(
      icon: Icons.local_mall,
      titulo: 'Categorías',
      color1: Colors.purple[700],
      color2: Colors.purple,
    );
  }
}
