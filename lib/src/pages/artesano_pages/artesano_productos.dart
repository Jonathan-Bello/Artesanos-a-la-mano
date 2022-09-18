import 'dart:async';

import 'package:artesanos_a_la_mano/src/widgets/card_Producto.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:flutter/material.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';

class ListaProductos extends StatefulWidget {
  @override
  _ListaProductosState createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  //Preferencias de Ususario
  final prefs = new PreferenciasUsuario();
  int _usuarioId;
  @override
  void initState() {
    super.initState();
    _usuarioId = prefs.id;
  }
 //Ya se obtuvo el id del Artesano
  @override
  Widget build(BuildContext context) {
    final productosBloc= Provider.ofProduc(context);
    productosBloc.cargarProductos(_usuarioId,1);
    
    return Stack(
      children: <Widget>[
        FondoArtesano(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            flexibleSpace: FondoArtesanoBar(),
            centerTitle: true,
            title: Text('Tus Productos',
              style: TextStyle(
              color: Colors.brown, 
              fontStyle: FontStyle.italic, 
              wordSpacing: 5.0, fontSize: 30.0, 
              ),
            ),
          ),
          body:
          _crearListado(productosBloc),
          floatingActionButton: _crearBotonF(context),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        )
      ],
    );
  }

  Widget _crearBotonF(context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.brown,
      tooltip: "Agregar Producto",
      shape: StadiumBorder(
        side: BorderSide(
        color: Colors.black,
        width: 2.0,
      ),
      ),
      onPressed: ()=> Navigator.pushNamed(context, 'productosAdd')
    );
  }

  Widget _crearListado(ProductosBloc bloc){
    return StreamBuilder(
      stream: bloc.productosStream ,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){
        final productos = snapshot.data;
        return RefreshIndicator(
          onRefresh: refresh,
          child: ListView.builder(
            itemCount: productos.length,
            itemBuilder: (BuildContext context, int index) {
            return 
            //FadeIn(
              //duration: Duration(milliseconds: 100*index),
              /* child:*/ _crearItem(context,bloc,productos[index]);
            //);
            },
          ),
        );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  //Metodo del para refrescar los productos enfocado a un RefreshIndicator
  Future<void> refresh()async{
    final productosBloc= Provider.ofProduc(context);
    productosBloc.cargarProductos(_usuarioId,1);
    //Para que espere a que se vea la animación
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return;
    });
  }

  Widget _crearItem(BuildContext context,ProductosBloc bloc, ProductoModel producto){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Eliminar',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.white,fontSize: 40),
              )
            ),
            SizedBox(width: 50,),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Eliminar',
                style: TextStyle(color: Colors.white,fontSize: 40),
              )
            )
          ],
        ),
        color: Colors.red,
      ),
      onDismissed: (direccion){
      //borrar elemento
        bloc.borrarProducto(producto.idProducto);
        Future.delayed(const Duration(milliseconds: 500), () {
          bloc.cargarProductos(_usuarioId,1);
        });
      },
      child: CardProducto(producto: producto,ruta: "productosAdd"),
    );
  }
}