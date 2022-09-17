import 'package:animate_do/animate_do.dart';
import 'package:artesanos_a_la_mano/src/bloc/artesano_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/artesano_model.dart';
import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/providers/artesano_provider.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:flutter/material.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/widgets/drawer_artesano_widget.dart';

class ArtesanoPage extends StatefulWidget {
  @override
  _ArtesanoPageState createState() => _ArtesanoPageState();
}

class _ArtesanoPageState extends State<ArtesanoPage> {
//Preferencias de Ususario

  final prefs = new PreferenciasUsuario();
  int _usuarioId;
  ArtesanoBloc artesanoBloc;
  ArtesanosModel artesano;
  final artesanoProvider = ArtesanoProvider();

  @override
  void initState() {
    super.initState();
    _usuarioId = prefs.id;
  }
//Ya se obtuvo el id del Artesano

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = "MenuArtesano";

    artesanoBloc = Provider.ofArtesano(context);
    artesanoBloc.cargarArtesano(_usuarioId);

    final productoBloc = Provider.ofProduc(context);
    productoBloc.productoArtesanoLikes(_usuarioId);

    Future<bool> _vaciarStream() async {
      //final productoBloc=Provider.ofProduc(context);
      productoBloc.changeStreamProductos(null);
      productoBloc.changeStreamproductoALikes(null);
      //artesanoBloc=Provider.ofArtesano(context);
      artesanoBloc.changeStreamArtesano(null);
      final loginBloc = Provider.of1(context);
      loginBloc.changeUser("");
      loginBloc.changePassword("");
      return true;
    }

    return WillPopScope(
      onWillPop: _vaciarStream,
      child: Stack(children: <Widget>[
        FondoArtesano(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            flexibleSpace: FondoArtesanoBar(),
            title: Text(
              'Menú Artesano',
              style: TextStyle(
                color: Colors.brown,
                fontStyle: FontStyle.italic,
                wordSpacing: 5.0,
                fontSize: 30.0,
              ),
            ),
            centerTitle: true,
          ),
          body: //Column(
              // children: <Widget>[
              _obtenerArtesano(artesanoBloc, productoBloc),
          //     SizedBox(height: 20,),
          //     _crearProductoLkesStream(productoBloc),
          //   ],
          // ),
          // drawer: _drawerArtesano(artesanoBloc),
        )
      ]),
    );
  }

  Widget _cardArtesano(int i, context) {
    if (i == 1) {
      return Card(
        elevation: 10,
        margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        //clipBehavior: Clip.antiAlias,
        color: Colors.brown,
        child: ListTile(
          title: Text(
            'PRODUCTOS',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onTap: () => Navigator.pushNamed(context, 'listaProductosA'),
        ),
      );
    } else if (i == 2) {
      return Card(
        elevation: 10,
        margin: EdgeInsets.all(20),
        clipBehavior: Clip.antiAlias,
        color: Colors.brown,
        child: ListTile(
          title: Text(
            'PERFIL DE TIENDA',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onTap: () =>
              Navigator.pushNamed(context, 'PerfilTienda', arguments: artesano),
        ),
      );
    }
    return null;
  }

  Widget _obtenerArtesano(ArtesanoBloc bloc, ProductosBloc productosBloc) {
    return StreamBuilder(
      stream: bloc.artesanoStream,
      builder: (BuildContext context, AsyncSnapshot<ArtesanosModel> snapshot) {
        if (snapshot.hasData) {
          artesano = snapshot.data;
          return Column(
            children: <Widget>[
              FadeInRight(
                child: _cardArtesano(1, context),
                duration: Duration(milliseconds: 300),
              ),
              FadeInRight(
                duration: Duration(milliseconds: 700),
                child: Card(
                  elevation: 10,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.brown,
                  child: ListTile(
                      title: Text(
                        'PERFIL DE TIENDA',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 0), () {
                          //Navigator.pop(context);
                          Navigator.pushNamed(context, 'PerfilTienda',
                              arguments: artesano);
                        });
                      }),
                ),
              ),
              FadeIn(
                  duration: Duration(milliseconds: 500),
                  child: _crearProductoLkesStream(productosBloc)),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _drawerArtesano(ArtesanoBloc bloc) {
    return StreamBuilder(
      stream: bloc.artesanoStream,
      builder: (BuildContext context, AsyncSnapshot<ArtesanosModel> snapshot) {
        if (snapshot.hasData) {
          artesano = snapshot.data;
          return DrawerArtesano(artesano: artesano);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearProductoLkesStream(ProductosBloc bloc) {
    return StreamBuilder(
      stream: bloc.productoALikesStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          if (snapshot.data == 2) {
            return Container();
          } else {
            final producto = snapshot.data;
            return _crearItem(context, producto);
          }
        } else {
          return Center(
              //child: CircularProgressIndicator(backgroundColor: Colors.amber,),
              );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, Map<String, dynamic> producto) {
    final _screenSize = MediaQuery.of(context).size;
    ProductoModel productox = new ProductoModel();
    productox.idProducto = producto['id'];
    productox.producto = producto['producto'];
    productox.descripcion = producto['descripcion'];
    productox.disponibilidad = int.parse(producto['disponibilidad']);
    productox.foto = producto['foto'];
    productox.categoria = producto['categoria'];
    productox.precio = double.parse(producto['precio']);
    productox.idArtesano = prefs.id;
    return Container(
        color: Colors.brown,
        child: Card(
          child: Column(
            children: <Widget>[
              Text(
                'Tu producto con mas popular',
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Container(
                    child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: (producto['Foto'] == "null")
                          ? Image(
                              image: AssetImage('assets/img/imagenNull.png'),
                              height: 300.0,
                              width: 200.0,
                              fit: BoxFit.cover,
                            )
                          : FadeInImage(
                              image: NetworkImage(producto['Foto']),
                              placeholder: AssetImage('assets/img/loading.gif'),
                              height: 300.0,
                              width: _screenSize.width * .5,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        width: _screenSize.width * .4,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "   Nombre: " + producto['Producto'],
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Disponibilidad'),
                            (int.parse(producto['Disponibilidad']) == 1)
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 40,
                                  )
                                : Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "   Categoría: " + producto['Categoria'],
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "   Precio: \u0024${producto['Precio']}",
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.favorite,
                                  color: Colors.purple,
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${producto['NoLikes']}',
                                  overflow: TextOverflow.clip,
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                )),
                subtitle: Text(
                  "Descripción: " + producto['Descripcion'],
                  style: TextStyle(
                      //fontSize: 10
                      ),
                ),
                dense: true,
                //onTap: () =>Navigator.pushNamed(context, 'productosAdd', arguments: productox)/*.then((value){setState((){});})*/,
              ),
            ],
          ),
        ));
  }
}
