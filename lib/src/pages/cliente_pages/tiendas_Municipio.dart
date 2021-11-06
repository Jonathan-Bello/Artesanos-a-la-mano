import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/artesano_model.dart';
import 'package:artesanos_a_la_mano/src/providers/productos_provider.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:flutter/material.dart';

class ListadoTiendasMunicipio extends StatelessWidget {
  //const ListadoCategoria({Key key}) : super(key: key);
  final productosProvider= new ProductosProvider();
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    final String idMunicipio= ModalRoute.of(context).settings.arguments;
    final artesanoBloc= Provider.ofArtesano(context);
    // artesanoBloc.cargarartesanoCategoria(categoria);
    Future<bool>_vaciarStream() async {
      artesanoBloc.changeStreamArtesanosMunicipio(null);
      return true;
    }
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
              title: Text(''+idMunicipio.toString(),
                style: TextStyle(
                color: Colors.white, 
                fontStyle: FontStyle.italic, 
                wordSpacing: 5.0, fontSize: 25.0, 
                ),
              ),
            ),
            body: _crearListadoStream(artesanoBloc)
            //_crearListado(categoria),
          )
        ],
      ),
    );
  }

  Widget _crearListadoStream(ArtesanoBloc bloc){
    return StreamBuilder(
      stream: bloc.artesanosMunicipioStream,
      builder: (BuildContext context, AsyncSnapshot<List<ArtesanosModel>> snapshot){
        if(snapshot.hasData){
        final productos = snapshot.data;
        return ListView.builder(
          itemCount: productos.length,
          itemBuilder: (BuildContext context, int index) {
          return  _crearItem(context,productos[index]);
          },
        );
        }else{
          return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.amber,),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ArtesanosModel artesano){
    //return //CardProductoShow(producto: producto,ruta: 'ProductoDetalle');
    //final _screenSize= MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          //trailing: Icon(Icons.ac_unit),
          leading: Icon(Icons.store_mall_directory,color: Colors.purple,),
          title: Text(artesano.tienda),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10,),
              Text(
                'Calle: '+artesano.calle,
                style: TextStyle(),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5,),
              Text(
                'Colonia: '+artesano.colonia,
                style: TextStyle(),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5,),
              Text(
                'Referencias: '+artesano.referencias,
                style: TextStyle(),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          onTap: () async {
            // Navigator.pop(context);
            final blocP = Provider.ofProduc(context);
            blocP.cargarProductos(artesano.id,prefs.idCliente);
            Navigator.pushNamed(context, 'TiendaCliente',arguments: artesano);
          },
        ),
      ),
    );
  }
}