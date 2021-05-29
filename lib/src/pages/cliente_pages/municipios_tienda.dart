import 'package:artesanos_a_la_mano/src/bloc/municipios_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/municipio_model.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:flutter/material.dart';

class MunicipiosTienda extends StatelessWidget {
  //const MunicipiosTienda({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final municipioBloc= Provider.ofMunicipios(context);

    // productosBloc.cargarProductosCategoria(categoria);
    Future<bool>_vaciarStream() async {
      //municipioBloc.changeStreamMuncipiosRegion(null);
      return true;
    }

    return WillPopScope(
      onWillPop: _vaciarStream,
      child: Stack(
        children: <Widget>[
          FondoCliente(),
          Scaffold(
            appBar: AppBar(
              leading: Container(),
              flexibleSpace: Container(
                color: Colors.white60,
              ),
              centerTitle: true,
              title: Text('Tiendas'),
            ),
            backgroundColor: Colors.transparent,
            body: _crearListadoStream(municipioBloc),
          )
        ],
      ),
    );
  }
  }

  Widget _crearListadoStream(MunicipiosBloc bloc){
    return StreamBuilder(
      stream: bloc.municipiosRegion,
      builder: (BuildContext context, AsyncSnapshot<List<MunicipioModel>> snapshot){
        if(snapshot.hasData){
        final muncipios = snapshot.data;
        return ListView.builder(
          itemCount: muncipios.length,
          itemBuilder: (BuildContext context, int index) {
          return  _crearItem(context,muncipios[index]);
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

  Widget _crearItem(BuildContext context, MunicipioModel municipio){
    final _screenSize= MediaQuery.of(context).size;
    return ListTile(
      title: Container(
        height: _screenSize.height*.08,
        // width: _screenSize.width*.5,
        child: Card(
          child:Center(
            child: Text(
              municipio.nombre,
              style: TextStyle(fontSize: 20),
            ),
          ),
          color: Colors.white60,
        ),
      ),

      onTap: (){
        // if(opcion==0){
          final artesanoBloc= Provider.ofArtesano(context);
          artesanoBloc.cargarArtesanoMunicipio(municipio.idMunicipio);
          Navigator.pushNamed(context, 'ListadoTiendasMunicipio',arguments: 'Tiendas');
        // }else{
        //   final productosBloc= Provider.ofClienteProductos(context);
        //   productosBloc.cargarProductosMunicipio(municipio.idMunicipio, prefs.idCliente);
        //   Navigator.pushNamed(context, 'ListadoProductosMunicipios',arguments: municipio.nombre);
        // }
      },
    );
}

