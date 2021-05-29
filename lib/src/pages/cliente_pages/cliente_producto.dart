import 'package:artesanos_a_la_mano/src/bloc/productoC_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/artesano_model.dart';
import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/providers/productos_provider.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/utils/utils.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:flutter/material.dart';

class ProductoDetalles extends StatefulWidget {
  //const ProductoDetalles({Key key}) : super(key: key);

  @override
  _ProductoDetallesState createState() => _ProductoDetallesState();
}

class _ProductoDetallesState extends State<ProductoDetalles> {
  Icon icon= Icon(Icons.favorite_border);
  final prefs = new PreferenciasUsuario();
  final ProductosProvider productosProvider= new ProductosProvider();
    // if(false){
    //   icon = Icon(Icons.favorite);
    // }

  @override
  Widget build(BuildContext context) {

    final artesanoBloc=Provider.ofArtesano(context);
    final productosBloc= Provider.ofProduc(context);
    final productosBlocCliente= Provider.ofClienteProductos(context);

    final ProductoModel producto= ModalRoute.of(context).settings.arguments;

    productosBlocCliente.obtenerLike(int.parse(producto.idProducto));

    
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(producto),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                _imagenProducto(producto, context,artesanoBloc,productosBloc),
                _like(producto,productosBlocCliente),
                _descripcion(producto),
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _crearAppbar(ProductoModel productoModel){
    return SliverAppBar(
      elevation: 2.0, 
      backgroundColor: Color.fromRGBO(232, 217, 56, 1),
      expandedHeight: 100.0,
      floating: false,
      //que se muestre siempre aunque se haga scroll
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          productoModel.producto,
          style: TextStyle(color: Colors.brown, fontSize: 16.0),
          overflow: TextOverflow.clip,
          maxLines: 2,
        ),
        background: FondoClienteBar(),
        // background: FadeInImage(
        //   placeholder: AssetImage('assets/img/loading.gif'), 
        //   image: NetworkImage(productoModel.getImagen()),
        //   fadeInDuration: Duration(milliseconds: 150),
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }

  Widget _imagenProducto(ProductoModel productoModel, BuildContext context, ArtesanoBloc bloc,ProductosBloc blocP){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: productoModel.idProducto,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              //child: CachedNetworkImage(imageUrl: productoModel.getImagen(),),
              child: Image(
                image: NetworkImage(productoModel.getImagen()),
                //height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text( 
            productoModel.producto, 
            style: Theme.of(context).textTheme.title,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10,),
          Text(
            'Categoría:'+productoModel.categoria,
            style: Theme.of(context).textTheme.subhead,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.attach_money),
              Text(productoModel.precio.toString()),
              SizedBox(width: 60,),
              Text('Disponibilidad'),
              (productoModel.disponibilidad==1)
              ? Icon(Icons.check_circle, color: Colors.green,size: 40,)
              : Icon(Icons.cancel, color: Colors.red, size: 40,),
            ],
          ),
          RaisedButton.icon(
            onPressed: ()  async {
              mostrarCarga(context);
              await bloc.cargarArtesano(productoModel.idArtesano);
              blocP.cargarProductos(productoModel.idArtesano,prefs.idCliente);//aqui cambiale yo del futuro
              ArtesanosModel a = bloc.artesano;
              Navigator.pop(context);
              Navigator.pushNamed(context, 'TiendaCliente',arguments: a);
            },
            icon: Icon(Icons.store_mall_directory),
            label: Text('Datos de la tienda')
          ),
          SizedBox(height: 20,),
          
          // Flexible(
          //   child: Column(
          //     children: <Widget>[
          //       Text(
          //         productoModel.producto, 
          //         style: Theme.of(context).textTheme.title,
          //         overflow: TextOverflow.ellipsis,
          //         ),
          //       Text(
          //         'Categoría:'+productoModel.categoria,
          //         style: Theme.of(context).textTheme.subhead,
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //       Row(
          //         children: <Widget>[
          //           Icon(Icons.star_border),
          //           Text(productoModel.precio.toString())
          //         ],
          //       )
          //     ],
          //   )
          // )
        ],
      )
    );
  }

  Widget _descripcion(ProductoModel productoModel){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        productoModel.descripcion,
        textAlign: TextAlign.justify,
        ),
    );
  }

  Widget _like(ProductoModel productoModel,ProductosClienteBloc bloc){
    //final ProductosProvider productosProvider= new ProductosProvider();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Me gusta:'),
        // SizedBox(width: 2),
          (productoModel.tieneLike==1)
          ? IconButton(icon: Icon(Icons.favorite, size: 40), color: Colors.purple, onPressed: (){
            setState(() {
              productoModel.tieneLike=0;
              bloc.quitarLike(prefs.idCliente,int.parse(productoModel.idProducto));
              // bloc.obtenerLike(int.parse(productoModel.idProducto));
              // setState(() {
              //  bloc.obtenerLike(int.parse(productoModel.idProducto));
              // });
              //numeroLike(productoModel);
            });
          },)
          : IconButton(icon: Icon(Icons.favorite_border, size: 40), color: Colors.purple, onPressed: (){
            setState((){
              productoModel.tieneLike=1;
              bloc.darLike(prefs.idCliente,int.parse(productoModel.idProducto));
              // setState(() {
              //bloc.obtenerLike(int.parse(productoModel.idProducto));
              // });
              //numeroLike(productoModel);
            });
          },),
          SizedBox(width: 30,),
          // Text(likes.toString()),

          // StreamBuilder(
          //   stream: bloc.likes,
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          //     if(snapshot.hasData){
          //       return Text(snapshot.data.toString());
          //     }else{
          //       return CircularProgressIndicator();
          //     }
          //   },
          // ), 


          FutureBuilder(
            future: productosProvider.getLikesdeProducto(int.parse(productoModel.idProducto)),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return Text('A ${snapshot.data.toString()} les gusta este producto',overflow: TextOverflow.clip,);
              }else{
                return CircularProgressIndicator();
              }
            },
          ),     
      ],
    );
  }
}