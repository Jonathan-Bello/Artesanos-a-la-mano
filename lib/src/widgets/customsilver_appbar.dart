import 'fondos_widgets.dart';
import 'package:flutter/material.dart';

import 'package:artesanos_a_la_mano/src/models/producto_model.dart';

class CustomSilverAppBar extends StatelessWidget {
  // const CustomSilverAppBar({ Key? key }) : super(key: key);
  final ProductoModel producto;

  const CustomSilverAppBar({Key key, this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      elevation: 2.0,

      backgroundColor: Colors.purple,

      expandedHeight: 100.0,
      floating: false,
      //que se muestre siempre aunque se haga scroll
      pinned: true,
      // leading: Icon(Icons.ac_unit),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),

      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          producto.producto,
          style: TextStyle(color: Colors.white, fontSize: 14.0),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        background: FondoClienteBar(),
      ),
    );
  }
}