import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  //const CardSwiper({Key key}) : super(key: key);

  final List<ProductoModel> productos;

  CardSwiper({
    @required
    this.productos
  });

  @override
  Widget build(BuildContext context) {
    
    final _screenSize= MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
       //height: 500.0,
       //width: 300.0,
        child: new Swiper(
          itemHeight: _screenSize.height * 0.5,
          itemWidth: _screenSize.width * 0.7,
          layout: SwiperLayout.STACK,
          itemBuilder: (BuildContext context,int index){
            //String idTagProducto = '${productos[index].idProducto}-tarjeta';
            //productos[index].idProducto= '${productos[index].idProducto}-tarjeta';
            //producto.idProducto = producto.idProducto+'-Hori';
            //print(idTagProducto);
            // return Hero(
            //   tag: productos[index].idProducto,
            //   child: 
              return ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: (){
                      timeDilation = 2.0;
                      Navigator.pushNamed(
                        context, 
                        'ProductoDetalle',
                        arguments: productos[index],);
                  },
                  child: FadeInImage(
                    image: NetworkImage(productos[index].getImagen()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                )
              );
            // );
          },
          itemCount: productos.length,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
        ),
    );
  }
}