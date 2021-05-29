import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:artesanos_a_la_mano/src/routes/routes.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/theme/tema.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  // timeDilation = 2.0;

  // final ProductosClienteBloc b = new ProductosClienteBloc();
  // b.cargarProductosAleatorios(3,7);
  //runApp(MyApp());
  //Bloquear la orinetacion del dispositivo
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    // final productosBloc= Provider.ofClienteProductos(context);
    // productosBloc.cargarProductosAleatorios(3,prefs.idCliente);
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Artesanos a la Mano',
      initialRoute: prefs.ultimaPagina,
      routes: getApplicationRoutes(),
      theme: miTemaA,
    ));
  }
}
