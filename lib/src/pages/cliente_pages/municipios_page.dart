import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/municipios_productos.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/municipios_tienda.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:flutter/material.dart';
class ListadoMunicipiosPage extends StatefulWidget {
  //const ListadoMunicipiosPage({Key key}) : super(key: key);
  @override
  _ListadoMunicipiosPageState createState() => _ListadoMunicipiosPageState();
}

class _ListadoMunicipiosPageState extends State<ListadoMunicipiosPage> {
  final prefs = new PreferenciasUsuario();

  int opcion=0;


  @override
  Widget build(BuildContext context) {
    final int region= ModalRoute.of(context).settings.arguments;
    final municipioBloc= Provider.ofMunicipios(context);

    // municipioBloc.cargarProductosCategoria(categoria);
    Future<bool>_vaciarStream() async {
      municipioBloc.changeStreamMuncipiosRegion(null);
      return true;
    }

    String reg='';
    switch(region){
      case 1: reg='Huauchinango';
      break;
      case 2: reg='Teziutlán';
      break;
      case 3: reg='Ciudad Serdán';
      break;
      case 4: reg='San Pedro Cholula';
      break;
      case 5: reg='Puebla';
      break;
      case 6: reg='Izúcar De Matamoros';
      break;
      case 7: reg='Tehuacán Y Sierra Negra';
      break;
    }
    // final _screenSize= MediaQuery.of(context).size;
    

    return WillPopScope(
      onWillPop: _vaciarStream,
      child: Stack(
        children: <Widget>[
          FondoCliente(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              flexibleSpace: FondoClienteBar(),
              centerTitle: true,
              title: Text(''+reg,
                style: TextStyle(
                color: Colors.brown, 
                fontStyle: FontStyle.italic, 
                wordSpacing: 5.0, fontSize: 25.0, 
                ),
              ),
            ),
            // body:_crearListadoStream(municipioBloc),
            body: paginas(),
            bottomNavigationBar: _navegacion(),
            // bottomSheet: Container(
            //   color: Color.fromRGBO(232, 217, 56, 1),
            //   width: double.infinity,
            //   child: Padding(
            //     //padding: EdgeInsets.symmetric(horizontal: _screenSize.width*.45, ),
            //     padding: EdgeInsets.only(left: _screenSize.width*.45, ),
            //     child: Text('Filtros',
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontStyle: FontStyle.italic
            //       ),
            //     ),
            //   )
            // ),
          )
        ],
      ),
    );
  }

  // Widget _crearListadoStream(MunicipiosBloc bloc){
  //   return StreamBuilder(
  //     stream: bloc.municipiosRegion,
  //     builder: (BuildContext context, AsyncSnapshot<List<MunicipioModel>> snapshot){
  //       if(snapshot.hasData){
  //       final muncipios = snapshot.data;
  //       return ListView.builder(
  //         itemCount: muncipios.length,
  //         itemBuilder: (BuildContext context, int index) {
  //         return 
  //         //FadeIn(
  //           //duration: Duration(milliseconds: 100*index),
  //           /* child:*/ _crearItem(context,muncipios[index]);
  //         //);
  //         },
  //       );
  //       }else{
  //         return Center(
  //           child: CircularProgressIndicator(backgroundColor: Colors.amber,),
  //         );
  //       }
  //     },
  //   );
  // }

  // Widget _crearItem(BuildContext context, MunicipioModel municipio){
  //   final _screenSize= MediaQuery.of(context).size;
  //   return ListTile(
  //     title: Container(
  //       height: _screenSize.height*.08,
  //       // width: _screenSize.width*.5,
  //       child: Card(
  //         child:Center(
  //           child: Text(
  //             municipio.nombre,
  //             style: TextStyle(fontSize: 20),
  //           ),
  //         ),
  //         color: Colors.white60,
  //       ),
  //     ),

  //     onTap: (){
  //       if(opcion==0){
  //         final artesanoBloc= Provider.ofArtesano(context);
  //         artesanoBloc.cargarArtesanoMunicipio(municipio.idMunicipio);
  //         Navigator.pushNamed(context, 'ListadoTiendasMunicipio',arguments: 'Tiendas');
  //       }else{
  //         final productosBloc= Provider.ofClienteProductos(context);
  //         productosBloc.cargarProductosMunicipio(municipio.idMunicipio, prefs.idCliente);
  //         Navigator.pushNamed(context, 'ListadoProductosMunicipios',arguments: municipio.nombre);
  //       }
  //     },
  //   );
  // }

  Widget _navegacion(){
    return BottomNavigationBar(
      currentIndex: opcion,
      backgroundColor: Color.fromRGBO(232, 217, 56, 1),
      iconSize: 30,
      selectedItemColor: Colors.purple,
      onTap: (i){
        setState(() {
          opcion=i;
          p.animateToPage(i, duration: Duration(milliseconds: 500), curve: Curves.bounceOut);
        });
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.store_mall_directory,),title: Text('Tiendas')),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_basket, ),title: Text('Productos'))
      ]
    );
  }

  Widget paginas(){
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: p,
      children: <Widget>[
         MunicipiosTienda(),
        MunicipiosProductos(),
        // MunicipiosProductos(),
      ],
    );
  }

  PageController p= new PageController(
    initialPage: 0,
  );

}

