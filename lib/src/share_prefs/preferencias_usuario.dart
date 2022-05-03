import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }
    // GET y SET de la ultima pagina
  get ultimaPagina{
    return _prefs.getString('ultimaPagina') ?? 'Home';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }
  //------

  // GET y SET del Id del Usuario Artesano
  get id{
    return _prefs.getInt('UsuarioId') ?? 1;
  }

  set id( int value ) {
    _prefs.setInt('UsuarioId', value);
  }
  //------
  int get idCliente{
    return _prefs.getInt('ClienteId') ?? 1;
  }

  set idCliente( int value ) {
    _prefs.setInt('ClienteId', value);
  }
}


