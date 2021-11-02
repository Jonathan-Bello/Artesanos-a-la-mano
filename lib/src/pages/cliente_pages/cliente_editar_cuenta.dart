import 'package:artesanos_a_la_mano/src/bloc/cliente_blocs/cliente_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/cliente_model.dart';
import 'package:artesanos_a_la_mano/src/providers/cliente_provider.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:flutter/material.dart';
import 'package:artesanos_a_la_mano/src/utils/utils.dart' as utils;


class EditarCuentaPage extends StatefulWidget {
  // const EditarCuentaPage({Key key}) : super(key: key);
  @override
  _EditarCuentaPageState createState() => _EditarCuentaPageState();
}

class _EditarCuentaPageState extends State<EditarCuentaPage> {
  ClienteModel cliente = new ClienteModel();

  ClienteBloc clienteBloc;

  final formKey = GlobalKey<FormState>();

  final scaffoldKey= GlobalKey<ScaffoldMessengerState>();

  final prefs = new PreferenciasUsuario();

  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    final bloc= Provider.ofCliente(context);
    cliente = bloc.getcliente;
    return Stack(
      children: <Widget>[
      FondoCliente(),
        Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            flexibleSpace: FondoClienteBar(),
            title: Text('Editar Cuenta',
              style: TextStyle(
              color: Colors.brown, 
              fontStyle: FontStyle.italic, 
              wordSpacing: 5.0, fontSize: 30.0, 
              ),
            ),
            centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: form(),
        ),
        )
      ]
    );
  }

  Widget form(){
    // final _screenSize= MediaQuery.of(context).size;
    final blocValidation= Provider.ofValitation(context);
    return Container(
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.only(top:100),
    child: Form(
      key: formKey,
      child: Container(
        color: Colors.white54,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text("Datos de Personales",style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            _txtFormNombre(),
            SizedBox(height: 5),
            _txtFormApellidos(),
            SizedBox(height: 5),
            _txtFormTelefono(),
            SizedBox(height: 5),
            _crearEmail(blocValidation),
            SizedBox(height: 5),
            _crearBoton(),
          ],
        ),
      ),
    ),
  );
  }

   Widget _txtFormNombre(){
    return TextFormField(
      initialValue: cliente.nombre,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 50,
      decoration: InputDecoration(
        labelText: 'Nombres',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.brown,width: 2)
        ),
      ),
      validator: (value){
        if(value.isEmpty){
          return 'Debe ingresar nombre su nombre o nombres';
        }else{
          return null;
        }
      },
      onSaved: (value)=> cliente.nombre = value ,
    );
  }

  Widget _txtFormApellidos(){
    return TextFormField(
      initialValue: cliente.apellido,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 50,
      decoration: InputDecoration(
        labelText: 'Apellidos',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.brown,width: 2)
        ),
      ),
      validator: (value){
        if(value.isEmpty){
          return 'Debe ingresar nombre sus apellidos';
        }else{
          return null;
        }
      },
      onSaved: (value)=> cliente.apellido = value ,
    );
  }

  Widget _txtFormTelefono(){
    return TextFormField(
      initialValue: cliente.celular.toString(),
      keyboardType: TextInputType.numberWithOptions(),
      maxLength: 10,
      decoration: InputDecoration(
        labelText: 'Telefono o Celular',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.brown,width: 2)
        ),
      ),
      validator: (value){
        if ( utils.isNumeric(value)  && value.length==10) {
          return null;
        } else {
          return 'Debe ingresar un numero telefonico valido';
        }
      },
      onSaved: (value)=> cliente.celular = int.parse(value) ,
    );
  }

  Widget _crearEmail(ValidationBloc bloc){
    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return TextFormField(
        initialValue: cliente.correo,
        keyboardType: TextInputType.emailAddress,
        maxLength: 40,
        decoration: InputDecoration(
          labelText: 'Email',
          counterText: snapshot.data,
          errorText: snapshot.error,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.brown,width: 2)
          ),
        ),
        validator: (value){
          if(snapshot.error!=null){
            return 'El email no es valido';
          }else{
            return null;
          }
        },
        onChanged: bloc.changeEmail,
        onSaved: (value)=> cliente.correo = value ,
      );
      },
    );
  }

  Widget _crearBoton(){
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      primary: Colors.brown,
      textStyle: TextStyle(
        color: Colors.white,
      ),
      ),
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed:_guardando ? null : _sumbit,
    );
  }

  void _sumbit() async{
    if(!formKey.currentState.validate()){
      //cuando los formularios no son validos
      return;
    }
    //disparo todos los saves del formulario
    formKey.currentState.save();
    setState(() {
      _guardando=true;
    });

    cliente.id= prefs.idCliente;
    print(cliente.apellido);
    print(cliente.nombre);
    final ClienteProvider provider= new ClienteProvider();
    await provider.actualizarCliente(cliente);
    // artesanoBloc.changeStreamArtesano(null);
    // await clienteBloc.editarCliente(cliente);
    //artesanoProvider.editarArtesano(artesano);

    setState(() {
      //_guardando=false;
      mostrarSnackbar('Información guardada');
      Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pop(context);
    });
    });
  }

  void mostrarSnackbar(String mensaje){
    final snackbar = new SnackBar(
      content: Text(mensaje),
      duration: Duration( milliseconds: 1500 ),
      action: SnackBarAction(
        label: 'VOLVER',
        onPressed: () => Navigator.pop(context, 'ClienteCuenta')
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}