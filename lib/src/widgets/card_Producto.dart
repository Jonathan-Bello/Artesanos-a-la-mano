import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';

class CardProducto extends StatelessWidget {
  //const CardProducto({Key key}) : super(key: key);
  final ProductoModel producto;
  final String ruta;

  CardProducto({
    @required
    this.producto,
    this.ruta
  });

  @override
  Widget build(BuildContext context) {
    
   final _screenSize= MediaQuery.of(context).size;
    final ProductosProvider productosProvider= new ProductosProvider();
    //productosProvider.getLikesdeProducto(int.parse(producto.idProducto));
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
              ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Container(
                child: Row(
                  children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ( producto.foto == "null") 
                    ? Image(image: AssetImage('assets/img/imagenNull.png'), height: 300.0, width: 200.0,fit: BoxFit.cover,)
                    : FadeInImage(
                    image: NetworkImage( producto.foto ),
                    placeholder: AssetImage('assets/img/loading.gif'),
                    height: 300.0,
                    width: _screenSize.width*.5,
                    fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: _screenSize.width*.4,
                    child: Column(   
                      children: <Widget>[
                        Text(
                          "   Nombre: "+producto.producto,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 20,),
                        Text('Disponibilidad'),
                        (producto.disponibilidad==1)
                        ? Icon(Icons.check_circle, color: Colors.green,size: 40,)
                        : Icon(Icons.cancel, color: Colors.red, size: 40,),
                        SizedBox(height: 20,),
                        Text(
                          "   Categoría: "+producto.categoria,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "   Precio: \u0024${producto.precio}",
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.favorite, color: Colors.purple,size: 40,),
                            SizedBox(width: 10,),
                            FutureBuilder(
                            future: productosProvider.getLikesdeProducto(int.parse(producto.idProducto)),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData){
                                return Text('${snapshot.data.toString()}',overflow: TextOverflow.clip,);
                              }else{
                                return Center(
                                  //child: CircularProgressIndicator()
                                );
                              }
                            },
                            ), 
                          ],
                        ),
                      ],
                    )
                  ),
                ],
                )
              ),
              subtitle: Text( "Descripción: "+producto.descripcion ),
              dense: true,
              onLongPress: (){
                showDialog(
                  context: context,
                  builder: ( context ) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      // title: Text('Información incorrecta'),
                      // content: Text(mensaje),
                      title: Column(
                        children: <Widget>[
                          FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          color: Colors.grey[200],
                          child: Container(child: Center(child: Text('Editar')),width: double.maxFinite,height: 50,),
                          onPressed: (){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '$ruta', arguments: producto);
                          }
                        ),
                        SizedBox(height: 10,),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          color: Colors.grey[200],
                          child: Container(child: Center(child: Text('Borrar')),width: double.maxFinite,height: 50,),
                          onPressed: (){
                            final productosBloc= Provider.ofProduc(context);
                            productosBloc.borrarProducto(int.parse(producto.idProducto));
                            Future.delayed(const Duration(milliseconds: 500), () {
                              productosBloc.cargarProductos(producto.idArtesano,1);
                              Navigator.pop(context);
                            });
                          }
                        ),
                        ],
                      ),
                    );
                  }
                );
              },
              onTap: () =>Navigator.pushNamed(context, '$ruta', arguments: producto)/*.then((value){setState((){});})*/,
            ),
          ],
        ),
      )
    );
  }
}



class CardProductoShow extends StatelessWidget {
  //const CardProductoShow({Key key}) : super(key: key);
  final ProductoModel producto;
  final String ruta;

  CardProductoShow({
    @required
    this.producto,
    this.ruta
  });

  @override
  Widget build(BuildContext context) {
    
  final _screenSize= MediaQuery.of(context).size;
  final ProductosProvider productosProvider= new ProductosProvider();
  //productosProvider.getLikesdeProducto(int.parse(producto.idProducto));
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
              ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Container(
                child: Row(
                  children: <Widget>[
                  Hero(
                    tag: producto.idProducto,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ( producto.foto == "null") 
                      ? Image(image: AssetImage('assets/img/imagenNull.png'), height: 300.0, width: 200.0,fit: BoxFit.cover,)
                      : FadeInImage(
                      image: NetworkImage( producto.foto ),
                      placeholder: AssetImage('assets/img/loading.gif'),
                      height: 300.0,
                      width: _screenSize.width*.5,
                      fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: _screenSize.width*.4,
                    child: Column(   
                      children: <Widget>[
                        Text(
                          "   Nombre: "+producto.producto,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 20,),
                        Text('Disponibilidad'),
                        (producto.disponibilidad==1)
                        ? Icon(Icons.check_circle, color: Colors.green,size: 40,)
                        : Icon(Icons.cancel, color: Colors.red, size: 40,),
                        SizedBox(height: 20,),
                        Text(
                          "   Categoría: "+producto.categoria,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "   Precio: \u0024${producto.precio}",
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 20,),
                        Text('Favorito'),
                        SizedBox(height: 5,),
                        (producto.tieneLike==1)
                        ? Icon(Icons.favorite, color: Colors.purple,size: 40,)
                        : Icon(Icons.favorite_border, color: Colors.purple, size: 40,),
                        SizedBox(height: 0,),
                        FutureBuilder(
                        future: productosProvider.getLikesdeProducto(int.parse(producto.idProducto)),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if(snapshot.hasData){
                            return Text('${snapshot.data.toString()}',overflow: TextOverflow.clip,);
                          }else{
                            return CircularProgressIndicator();
                          }
                        },
                        ), 
                      ],
                    )
                  ),
                ],
                )
              ),
              subtitle: Text( "Descripción: "+producto.descripcion ),
              dense: true,
              onTap: () =>Navigator.pushNamed(context, '$ruta', arguments: producto)
            ),
          ],
        ),
      )
    );
  }
}