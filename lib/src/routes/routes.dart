import 'package:artesanos_a_la_mano/src/pages/cliente_pages/cliente_editar_cuenta.dart';
import 'package:artesanos_a_la_mano/src/pages/politicas_pages.dart';
import 'package:flutter/material.dart';

import 'package:artesanos_a_la_mano/src/pages/home_page.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/cliente_categoria.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/cliente_home.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/cliente_producto.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/cliente_producto_tienda.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/cliente_tiendadatos.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/login_cliente.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/municipios_page.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/productors_Populares.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/productos_Categoria.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/productos_Municipio.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/regiones_page.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/registrar_cliente.dart';
import 'package:artesanos_a_la_mano/src/pages/cliente_pages/tiendas_municipio.dart';

import 'package:artesanos_a_la_mano/src/pages/artesano_pages/artesano_menu_page.dart';
import 'package:artesanos_a_la_mano/src/pages/artesano_pages/login_page.dart';
import 'package:artesanos_a_la_mano/src/pages/artesano_pages/artesano_add_producto.dart';
import 'package:artesanos_a_la_mano/src/pages/artesano_pages/artesano_productos.dart';
import 'package:artesanos_a_la_mano/src/pages/artesano_pages/artesano_perfil_page.dart';

import 'package:artesanos_a_la_mano/src/pages/cliente_pages/cliente_cuenta_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'Home': (BuildContext context) => HomePage(),
    'login': (BuildContext context) => LoginPage(),
    'MenuArtesano': (BuildContext context) => ArtesanoPage(),
    'listaProductosA': (BuildContext context) => ListaProductos(),
    'productosAdd': (BuildContext context) => ProductoPage(),
    'PerfilTienda': (BuildContext context) => PerfilArtesanoPage(),

    //rutas cliente
    'ClienteHome': (BuildContext context) => ClienteHome(),
    'ProductoDetalle': (BuildContext context) => ProductoDetalles(),
    'ListadoCategoria': (BuildContext context) => ListadoCategoria(),
    'TiendaCliente': (BuildContext context) => ClienteTiendaPage(),

    'crearCliente': (BuildContext context) => RegistrarCliente(),
    'loginCliente': (BuildContext context) => LoginCliente(),
    'ListadoMunicipios': (BuildContext context) => ListadoMunicipiosPage(),
    'ListadoProductosMunicipios': (BuildContext context) =>
        ListadoProductosMunicipio(),
    'ListadoProductosPopulares': (BuildContext context) =>
        ListadoProductosPopulares(),
    'ClienteCategorias': (BuildContext context) => ClienteCategorias(),
    'ListadoRegiones': (BuildContext context) => ListadoRegiones(),
    'ProductoDetallesTienda': (BuildContext context) =>
        ProductoDetallesTienda(),
    'ListadoTiendasMunicipio': (BuildContext context) =>
        ListadoTiendasMunicipio(),

    'ClienteCuenta': (BuildContext context) => ClienteCuenta(),
    'EditarCuentaPage': (BuildContext context) => EditarCuentaPage(),

    'PoliticasPages': (BuildContext context) => PoliticasPages()
  };
}
