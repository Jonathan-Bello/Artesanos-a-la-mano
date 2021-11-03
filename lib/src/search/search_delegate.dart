import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/providers/productos_provider.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';


class DataSearch extends SearchDelegate {

  String seleccion = '';
  final prefs = new PreferenciasUsuario();
  final productosProvider = new ProductosProvider();
  List<ProductoModel> productos;

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close( context, null );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    if ( query.isEmpty ) {
      return Container();
    }

    if(productos.isEmpty){
      return FutureBuilder(
      future: productosProvider.getProductosBusqueda(query,prefs.idCliente),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if( snapshot.hasData ) {
          productos = snapshot.data;
          if(productos.isEmpty){
            return Center(
              child: Container(
                child: Text('No se encuentran resultados'),
              )
            );
          }

          return ListView(
            children: productos.map( (producto) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage( producto.getImagen() ),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text( producto.producto ),
                  subtitle: Text( producto.descripcion ),
                  onTap: (){
                    close( context, null);
                    //producto.uniqueId = '';
                    Navigator.pushNamed(context, 'ProductoDetalle', arguments: producto);
                  },
                );
            }).toList()
          );

        } else {
          return Center(
            child: CircularProgressIndicator()
          );
        }
      },
    );
    }

    return ListView(
      children: productos.map( (producto) {
          return ListTile(
            leading: FadeInImage(
              image: NetworkImage( producto.getImagen() ),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              width: 50.0,
              fit: BoxFit.contain,
            ),
            title: Text( producto.producto ),
            subtitle: Text( producto.descripcion ),
            onTap: (){
              close( context, null);
              //producto.uniqueId = '';
              Navigator.pushNamed(context, 'ProductoDetalle', arguments: producto);
            },
          );
      }).toList()
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    if ( query.isEmpty ) {
      return Container();
    }

    return FutureBuilder(
      future: productosProvider.getProductosBusqueda(query,prefs.idCliente),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
          if( snapshot.hasData ) {
            productos = snapshot.data;


            if(productos.isEmpty){
              return Center(
                child: Container(
                  child: Text('No se encuentran resultados'),
                )
              );
            }

            return ListView(
              children: productos.map( (producto) {
                  return ListTile(
                    leading: FadeInImage(
                      image: NetworkImage( producto.getImagen() ),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      width: 50.0,
                      fit: BoxFit.contain,
                    ),
                    title: Text( producto.producto ),
                    subtitle: Text( producto.descripcion ),
                    onTap: (){
                      close( context, null);
                      //producto.uniqueId = '';
                      Navigator.pushNamed(context, 'ProductoDetalle', arguments: producto);
                    },
                  );
              }).toList()
            );

          } else {
            return Center(
              child: CircularProgressIndicator()
            );
          }

      },
    );


  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias que aparecen cuando la persona escribe

  //   final listaSugerida = ( query.isEmpty ) 
  //                           ? peliculasRecientes
  //                           : peliculas.where( 
  //                             (p)=> p.toLowerCase().startsWith(query.toLowerCase()) 
  //                           ).toList();


  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: (){
  //           seleccion = listaSugerida[i];
  //           showResults( context );
  //         },
  //       );
  //     },
  //   );
  // }

}

