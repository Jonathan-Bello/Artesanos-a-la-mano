import 'package:artesanos_a_la_mano/src/bloc/productoC_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/widgets/card_Producto.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:flutter/material.dart';
class ListadoProductosPopulares extends StatelessWidget {
  //const ListadoProductosPopulares({Key key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {

    //final String idMunicipio= ModalRoute.of(context).settings.arguments;
    final productosBloc= Provider.ofClienteProductos(context);
    // productosBloc.cargarProductosCategoria(categoria);
    Future<bool>_vaciarStream() async {
      productosBloc.changeStreamMunicipio(null);
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
              title: Text('Lo mas popular',
                style: TextStyle(
                color: Colors.brown, 
                fontStyle: FontStyle.italic, 
                wordSpacing: 5.0, fontSize: 25.0, 
                ),
              ),
            ),
            body:
            _crearListadoStream(productosBloc)
            //_crearListado(categoria),
          )
        ],
      ),
    );
  }

  Widget _crearListadoStream(ProductosClienteBloc bloc){
    return StreamBuilder(
      stream: bloc.productosPopulares,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){
        final productos = snapshot.data;
        return ListView.builder(
          itemCount: productos.length,
          itemBuilder: (BuildContext context, int index) {
          return 
          //FadeIn(
            //duration: Duration(milliseconds: 100*index),
            /* child:*/ _crearItem(context,productos[index]);
          //);
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

  Widget _crearItem(BuildContext context, ProductoModel producto){
    return CardProductoShow(producto: producto,ruta: 'ProductoDetalle');
  }
}