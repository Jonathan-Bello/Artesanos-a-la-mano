import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:flutter/material.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/providers/usuarios_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  //const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final providerUsuario = UsuariosProvider();
  bool _cargando=false;
  
  @override
  Widget build(BuildContext context) {
    final loginBloc= Provider.of1(context);
    Future<bool>_vaciarStream() async {
      loginBloc.changeUser("");
      loginBloc.changePassword("");
      return true;
    }

    return WillPopScope(
      onWillPop: _vaciarStream,
      child: Stack(
        children: <Widget>[
          FondoArtesano(),
          Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
          flexibleSpace: FondoArtesanoBar()
          ),
          body: 
          Stack(children: <Widget>[
            //HeaderWaveGradient(),
            _loginForm(context),
          ],)
          ),
        ], 
      ),
    );
  }

  Widget _loginForm(BuildContext context){
    final bloc= Provider.of1(context);
    //final bloc1= Provider.of1(context);
    final size= MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 120.0,
            )
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.account_box,
                    color: Colors.black,
                    size: 70,
                  )
                ),
                SizedBox(height: 20),
                Text('INGRESAR A CUENTA', style:  TextStyle(color: Colors.brown,fontStyle: FontStyle.italic,fontSize: 30.0),),
                SizedBox(height: 50,),
                _crearUser(bloc),
                SizedBox(height: 20,),
                _crearPassword(bloc),
                SizedBox(height: 20,),
                _crearBoton(context, bloc)
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 50.0),
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
          ),
          SizedBox(height: 100,),
        ],
      ),
    );
  }

  Widget _crearUser(CrearUserBloc bloc){
    return StreamBuilder(
      stream: bloc.userStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
         return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon( Icons.account_circle, color: Colors.brown ),
              hintText: 'NombreUsuario',
              labelText: 'Nombre de Usuario',
              //counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeUser
          )
        );
      },
    );
  }

  Widget _crearPassword(CrearUserBloc bloc){
    return StreamBuilder(
      stream: bloc.passwordStream,
      initialData: bloc.password,
      builder: (BuildContext context, AsyncSnapshot snapshot){
       return Container(
       padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          obscureText: true, 
          decoration: InputDecoration(
            icon: Icon( Icons.lock, color: Colors.brown ),
            labelText: 'Contraseña',
            //counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changePassword
        )
      );
      }
     );
  }

  Widget _crearBoton(BuildContext context, CrearUserBloc bloc){
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 20.0),
          child: Text('Ingresar'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        elevation: 0.0,
        color: Colors.brown,
        textColor: Colors.white,
        //onPressed:_cargando ? null : _login(bloc, context),
        //onPressed: _cargando,
        onPressed: snapshot.hasData&&_cargando==false ? ()=> _login(bloc, context) : null,
        animationDuration: Duration(milliseconds: 200));
      },
    );
  }

  _login(CrearUserBloc bloc, BuildContext context) async {
    //var _circularProgressIndicator = CircularProgressIndicator();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _cargando=true;
      //_circularProgressIndicator.createElement();
    });
    //mostrarCarga(context);
    await providerUsuario.loginArtesano(bloc.user, bloc.password).then((value) {
    //CircularProgressIndicator();
    String estatus = value['Estatus'];
    int id = value['IdArtesano'];
    _guardar(id);
    //print(value);
    if(estatus=="200"){
      Navigator.pushReplacementNamed(context, 'MenuArtesano');
      final productoBloc=Provider.ofProduc(context);
      productoBloc.productoArtesanoLikes(id);
      // bloc.changeUser("");
      // bloc.changePassword("");
      //bloc.dispose();
    }else{
      print("ERROR");
      _crearAlert(context);
    }
    });

    setState(() {
      _cargando=false;
    });
  }

  _guardar(int id) async{
  if(id==null){
    return;
  }
  final pref = await SharedPreferences.getInstance();
  final key = 'UsuarioId';
  pref.setInt(key, id);
  }

  Future<void> _crearAlert(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext c) {
        return AlertDialog(
          title: Text('Usuario y/o contraseña incorrectos.', style: TextStyle(fontSize: 25.0),),
          content: Text('Por favor, inténtelo de nuevo'),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              textColor: Colors.blueAccent,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );  
  }
}