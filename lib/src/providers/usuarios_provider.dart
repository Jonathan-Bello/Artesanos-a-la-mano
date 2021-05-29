import 'package:http/http.dart' as http;
import 'dart:convert';


class UsuariosProvider{
  //String _url = "hackatecweb.azurewebsites.net";
  String _url = "valorarte.000webhostapp.com";

  Future loginArtesano(String user, String pass) async{
    final url = Uri.https(_url, 'Artesanos/Login.php', {
      'usuario'  : user,
      'password'  : pass
    });
    print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    return decodedData;
  }

  Future nuevoUsuario(String user, String pass) async{
    final url = Uri.https(_url, 'Movil/Login', {
      'user'  : user,
      'pass'  : pass
    });

    print(url);

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    return decodedData;
  }
  //String _url = "hackatecweb.azurewebsites.net";
  Future cadena(String bob) async{
    final url = Uri.https(_url, 'Movil/AgregarPrueba', {
      'cadena'  : bob,
    });

    print(url);
    final response = await http.post(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    return decodedData;
  }
}