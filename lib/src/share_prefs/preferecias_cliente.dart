import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasCliente {

  static final PreferenciasCliente _instancia = new PreferenciasCliente._internal();

  factory PreferenciasCliente() {
    return _instancia;
  }

  PreferenciasCliente._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get idCliente{
    return _prefs.getInt('ClienteId') ?? 1;
  }

  set idCliente( int value ) {
    _prefs.setInt('ClienteId', value);
  }

}