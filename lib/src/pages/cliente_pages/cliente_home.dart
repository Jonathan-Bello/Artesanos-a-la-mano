import 'package:flutter/material.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:artesanos_a_la_mano/src/bloc/municipios_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/productoC_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/providers/productos_provider.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/widgets/card_swiper_widget.dart';
import 'package:artesanos_a_la_mano/src/widgets/drawer_cliente.dart';
import 'package:artesanos_a_la_mano/src/widgets/productos_horizontal.dart';
import 'package:artesanos_a_la_mano/src/search/search_delegate.dart';


class ClienteHome extends StatelessWidget {
  //const ClienteHome({Key key}) : super(key: key);
  final productosProvider= new ProductosProvider();

  final prefs = new PreferenciasUsuario();
  
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina="ClienteHome";
    // print(prefs.idCliente.toString());
    // timeDilation = 1.0;
    final productosBloc= Provider.ofClienteProductos(context);
    productosBloc.cargarProductosRecientes(prefs.idCliente);
    productosBloc.cargarProductosAleatorios(3,prefs.idCliente);
    
    final municipiosBloc= Provider.ofMunicipios(context);
    // final productosBloc= Provider.ofProduc(context);
    // productosBloc.cargarProductos(1,3);

    Future<bool>_vaciarStream() async {
      productosBloc.changeStreamRecientes(null);
      productosBloc.changeStreamAleatorios(null);
      return true;
    }

    return WillPopScope(
      onWillPop: _vaciarStream,//_vaciarStream,
      child: Stack(
        children: <Widget>[
          FondoCliente(),
           Scaffold(
           drawer: DrawerCliente(),
           backgroundColor: Colors.transparent,
           appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Inicio',
              style: TextStyle(
                color: Colors.brown, 
                fontStyle: FontStyle.italic, 
                wordSpacing: 5.0, fontSize: 30.0, 
              ),
            ),
            centerTitle: true,
            flexibleSpace: FondoClienteBar(),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: DataSearch()
                  );
                },
                icon: Icon(Icons.search,color: Colors.brown),
              )
            ],
          ),
            body:
              SingleChildScrollView(
                child: Center(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                      // snipperProductos(productosBloc),
                      SizedBox(height: 15,),
                      footer(productosBloc),
                      //ffooter(context),
                      SizedBox(height: 20,),
                      categorias(context,productosBloc),
                      SizedBox(height: 20,),
                      //snipperProductosF(),
                      SizedBox(height: 30,),
                      regiones(context,municipiosBloc),
                      SizedBox(height: 30,),
                      snipperProductos(productosBloc),
                      SizedBox(height: 20,),
                    ],
                  ),
              ),
                ),
            ),
          ),
        ],
      ),
    );
  }

  Widget snipperProductos(ProductosClienteBloc bloc){
    return StreamBuilder(
      stream:  bloc.productosAleatorios,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){
          List<ProductoModel> productos = snapshot.data;
          return CardSwiper(productos: productos,);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget snipperProductosF(){
    return FutureBuilder(
      future: productosProvider.getProductosAleatorios(4,prefs.idCliente),  
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){
          List<ProductoModel> productos = snapshot.data;
          return CardSwiper(productos: productos,);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget footer(ProductosClienteBloc bloc){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
             padding: EdgeInsets.only(left: 20.0),
             child: Text('Recientes', 
             style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20),
             //style: Theme.of(context).textTheme.subhead,
             ),
           ),
           SizedBox(height: 5.0,),
          StreamBuilder(
            stream: bloc.productosRecientes,//peliculasProvider.popularesStream ,
            builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
              if(snapshot.hasData){
                List<ProductoModel> productos = snapshot.data;
                return ProductosHorizontal(produtos: productos,ruta: 'ProductoDetalle',);
              }else{
                return Center(child: CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                ));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget ffooter(BuildContext context){
    //final _screenSize= MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      //height: _screenSize.height*0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 10,
            color: Colors.white38,
            padding: EdgeInsets.only(left: 20.0),
           ),
           Container(
             padding: EdgeInsets.only(left: 30.0),
             child: Text('Lo nuevo', 
               style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic,fontSize: 20),
             ),
           ),
           SizedBox(height: 10.0,),
           FutureBuilder(
            future: productosProvider.getProductosRecientes(prefs.idCliente),
            builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
              if(snapshot.hasData){
                List<ProductoModel> productos = snapshot.data;
                return ProductosHorizontal(produtos: productos,ruta: 'ProductoDetalle',);
              }else{
                return Center(child: CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                ));
              }
            },
          ),
          Container(
            height: 10,
            width: double.infinity,
            color: Colors.white38,
          ),
        ],
      ),
    );
  }

  Widget categorias(BuildContext context, ProductosClienteBloc bloc){
    final size= MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      width: size.width*.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white54,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3.0,
            offset: Offset(0.0, 0.5),
            spreadRadius: 3.0
          )
        ]
      ),
      child: Column(
        children: <Widget>[
          Center(child: Text('Categorías ',style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic
          ),),),
          SizedBox(height: 20,),
          categoriasBoton(context,bloc),
          RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('Varios')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarProductosCategoria('Varios',prefs.idCliente);
                Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Varios');
              }
          ),
        ],
      ),
    );
  }

  Widget categoriasBoton(context,ProductosClienteBloc bloc){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: <Widget>[
        Column(
          children: <Widget>[
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('Cerámica')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarProductosCategoria('Cerámica',prefs.idCliente);
                Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Cerámica');
              }
            ),
            SizedBox(height: 5),
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('Madera')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarProductosCategoria('Madera',prefs.idCliente);
                Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Madera');
              }
            ),
            SizedBox(height: 5),
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('Mármol, Piedra y Vidrio')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarProductosCategoria('Mármol, Piedra y Vidrio',prefs.idCliente);
                Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Mármol, Piedra y Vidrio');
              }
            ),
            SizedBox(height: 5),
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('Metal')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarProductosCategoria('Metal',prefs.idCliente);
                Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Metal');
              }
            ),
            SizedBox(height: 5),
          ],
        ),
        SizedBox(width: 40,),
        Column(
          children: <Widget>[
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('Barro')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarProductosCategoria('Barro',prefs.idCliente);
                Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Barro');
              }
            ),
            SizedBox(height: 5),
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('Piel y Cuero')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarProductosCategoria('Piel y Cuero',prefs.idCliente);
                Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Piel y Cuero');
              }
            ),
            SizedBox(height: 5),
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('Textil')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarProductosCategoria('Textil',prefs.idCliente);
                Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Textil');
              }
            ),
            SizedBox(height: 5),
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('Joyería')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarProductosCategoria('Joyería',prefs.idCliente);
                Navigator.pushNamed(context, 'ListadoCategoria',arguments: 'Joyería');
              }
            ),
            SizedBox(height: 5),
          ],
        ),
      ],
    );
  }

  Widget regiones(BuildContext context,MunicipiosBloc bloc){
    final size= MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      width: size.width*.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white54,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3.0,
            offset: Offset(0.0, 0.5),
            spreadRadius: 3.0
          )
        ]
      ),
      child: Column(
        children: <Widget>[
          Center(child: Text('Búsqueda por ',style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic
          ),),),
          Center(child: Text('Regiones ',style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic
          ),),),
          SizedBox(height: 20,),
          regionesBoton(context,bloc),
          RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('VII - Tehuacán Y Sierra Negra')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarMuncipiosRegion(7);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 7);
              }
          ),
        ],
      ),
    );
  }

  Widget regionesBoton(BuildContext context,MunicipiosBloc bloc){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: <Widget>[
        Column(
          children: <Widget>[
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('I-Huauchinango')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarMuncipiosRegion(1);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 1);
              }
            ),
            SizedBox(height: 5),
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('III - Ciudad Serdán')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarMuncipiosRegion(3);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 3);
              }
            ),
            SizedBox(height: 5),
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('V - Puebla')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarMuncipiosRegion(5);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 5);
              }
            ),
            SizedBox(height: 5),
          ],
        ),
        SizedBox(width: 40,),
        Column(
          children: <Widget>[
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('II-Teziutlán')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarMuncipiosRegion(2);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 2);
              }
            ),
            SizedBox(height: 5),
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('IV - San Pedro Cholula')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarMuncipiosRegion(4);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 4);
              }
            ),
            SizedBox(height: 5),
            RaisedButton(
              color: Colors.brown,
              textColor: Colors.white,
              child: Container(child: Center(child: Text('VI - Izúcar De Matamoros')),width: 100,),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: (){
                bloc.cargarMuncipiosRegion(6);
                Navigator.pushNamed(context, 'ListadoMunicipios',arguments: 6);
              }
            ),
            SizedBox(height: 5),
          ],
        ),
      ],
    );
  }
}