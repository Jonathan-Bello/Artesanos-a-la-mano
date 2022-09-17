// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/validation_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/artesano_model.dart';
import 'package:artesanos_a_la_mano/src/providers/artesano_provider.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/utils/utils.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';

import 'package:artesanos_a_la_mano/src/utils/utils.dart' as utils;

class PerfilArtesanoPage extends StatefulWidget {
  //PerfilArtesanoPage({Key key}) : super(key: key);

  @override
  _PerfilArtesanoPageState createState() => _PerfilArtesanoPageState();
}

class _PerfilArtesanoPageState extends State<PerfilArtesanoPage> {
  ArtesanosModel artesano = new ArtesanosModel();
  final artesanoProvider = new ArtesanoProvider();
  ArtesanoBloc artesanoBloc;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Preferencias de Ususario
  final prefs = new PreferenciasUsuario();
  //int _usuarioId;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();
    //_usuarioId = prefs.id;
  }
  //List a = artesanoProvider.todosLosMunicipios();

  List<String> municipios = municipiosLista();
  List<String> regiones = municipiosRegionLista();

  String _opcionSelecionada = "1";

  @override
  Widget build(BuildContext context) {
    artesanoBloc = Provider.ofArtesano(context);
    //artesanoBloc.cargarArtesano(_usuarioId);
    final ArtesanosModel artesanoData =
        ModalRoute.of(context).settings.arguments;
    if (artesanoData != null) {
      artesano = artesanoData;
      _opcionSelecionada = (artesano.idMunicipio - 1).toString();
    }
    return Stack(children: <Widget>[
      FondoArtesano(),
      Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: FondoArtesanoBar(),
          title: Text(
            'Perfil Tienda',
            style: TextStyle(
              color: Colors.brown,
              fontStyle: FontStyle.italic,
              wordSpacing: 5.0,
              fontSize: 30.0,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              form()
              //formulario(artesanoBloc),
            ],
          ),
        ),
      )
    ]);
  }

  Widget form() {
    final _screenSize = MediaQuery.of(context).size;
    final blocValidation = Provider.ofValitation(context);
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Container(
          color: Colors.white54,
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text("Datos de Tienda", style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              _txtFormTienda(),
              SizedBox(height: 10),
              Text("Ubicación de la Tienda", style: TextStyle(fontSize: 15)),
              _txtFormCalle(),
              SizedBox(height: 5),
              _txtFormColonia(),
              SizedBox(height: 5),
              _txtFormCP(),
              SizedBox(height: 5),
              _txtFormReferencias(),
              SizedBox(height: 10),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     border: Border.all(color: Colors.black45),
              //   ),
              //   //color: Colors.black,
              //   // child: Column(
              //   //   children: <Widget>[
              //   //     Container(
              //   //       child: Text(
              //   //         "    Municipio:",
              //   //         style: TextStyle(fontSize: 13, color: Colors.black45),
              //   //       ),
              //   //       width: _screenSize.width * .8,
              //   //     ),
              //   //     _crearMunicipios(),
              //     // ],
              //   // ),
              // ),
              SizedBox(height: 20),
              Text("Datos de Personales", style: TextStyle(fontSize: 20)),
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

  Widget formulario(ArtesanoBloc bloc) {
    return StreamBuilder(
      stream: bloc.artesanoStream,
      builder: (BuildContext context, AsyncSnapshot<ArtesanosModel> snapshot) {
        if (snapshot.hasData) {
          artesano = snapshot.data;
          _opcionSelecionada = (artesano.idMunicipio).toString();
          final _screenSize = MediaQuery.of(context).size;
          final blocValidation = Provider.ofValitation(context);
          return Container(
            padding: EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Container(
                color: Colors.white54,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text("Datos de Tienda", style: TextStyle(fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    _txtFormTienda(),
                    SizedBox(height: 10),
                    Text("Ubicación de la Tienda",
                        style: TextStyle(fontSize: 15)),
                    _txtFormCalle(),
                    SizedBox(height: 5),
                    _txtFormColonia(),
                    SizedBox(height: 5),
                    _txtFormCP(),
                    SizedBox(height: 5),
                    _txtFormReferencias(),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black45),
                      ),
                      //color: Colors.black,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "    Municipio:",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black45),
                            ),
                            width: _screenSize.width * .8,
                          ),
                          _crearMunicipios(),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Datos de Personales", style: TextStyle(fontSize: 20)),
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
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  //Datos de la Tienda
  Widget _txtFormTienda() {
    return TextFormField(
      initialValue: artesano.tienda,
      textCapitalization: TextCapitalization.sentences,
      //Maximo de caracteres
      maxLength: 40,
      decoration: InputDecoration(
        //Texto a desparecer cuando añades un valor
        //hintText: 'Nombre de la Tienda',
        //TextoPrincipal
        labelText: 'Nombre de tu Tienda',
        helperText: "Nombre que con el que identificaran a tu tienda",
        //Borde
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.brown, width: 2)),
        //Borde cuando no se seleciona el TextFormField
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.brown,width: 2)
        // ),
      ),
      //Validación del del txtField
      validator: (value) {
        if (value.isEmpty) {
          return 'Debe ingresar nombre de tienda';
        } else {
          //si returno null es que todo "ok"
          return null;
        }
      },
      //se ejecuta despues de validar el campo
      //Aqui le digo que al momento de que se valida el valor lo se lo asigno al proucto
      onSaved: (value) => artesano.tienda = value,
    );
  }

  Widget _txtFormCalle() {
    return TextFormField(
      initialValue: artesano.calle,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 30,
      decoration: InputDecoration(
        labelText: 'Calle',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.brown, width: 2)),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Debe ingresar calle donde se ubica tu tienda';
        } else {
          return null;
        }
      },
      onSaved: (value) => artesano.calle = value,
    );
  }

  Widget _txtFormColonia() {
    return TextFormField(
      initialValue: artesano.colonia,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 30,
      decoration: InputDecoration(
        labelText: 'Colonia',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.brown, width: 2)),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Debe ingresar colonia donde se ubica tu tienda";
        } else {
          return null;
        }
      },
      onSaved: (value) => artesano.colonia = value,
    );
  }

  Widget _txtFormCP() {
    return TextFormField(
      initialValue: artesano.cP.toString(),
      textCapitalization: TextCapitalization.sentences,
      maxLength: 5,
      decoration: InputDecoration(
        labelText: 'Código Postal',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.brown, width: 2)),
      ),
      validator: (value) {
        if (utils.isNumeric(value) && value.length == 5) {
          return null;
        } else {
          return 'Debe ingresar codigo postal válido';
        }
      },
      onSaved: (value) => artesano.cP = int.parse(value),
    );
  }

  Widget _txtFormReferencias() {
    return TextFormField(
      initialValue: artesano.referencias,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 100,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Referencias',
        helperText: 'Escribe los referencias que ayuden a ubicar tu tienda',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.brown, width: 2)),
      ),
      validator: (value) {
        if (value.length < 0) {
          return "";
        } else {
          return null;
        }
      },
      onSaved: (value) => artesano.referencias = (value),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown() {
    List<DropdownMenuItem<String>> lista = [];
    for (int i = 0; i < municipios.length; i++) {
      lista.add(DropdownMenuItem(
        child: Text(municipios.elementAt(i)),
        value: i.toString(),
      ));
    }
    return lista;
  }

  Widget _crearMunicipios() {
    return Column(
      children: <Widget>[
        DropdownButton(
            value: _opcionSelecionada,
            items: getOpcionesDropDown(),
            focusColor: Colors.brown,
            onChanged: (opt) {
              setState(() {
                _opcionSelecionada = opt;
                artesano.idMunicipio = int.parse(opt) + 1;
                artesano.region = int.parse(regiones[int.parse(opt)]);
                FocusScope.of(context).requestFocus(FocusNode());
              });
            }),
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black45),
          ),
          child: Text(
            "Región: " + artesano.region.toString(),
            style: TextStyle(color: Colors.black87),
          ),
        )
      ],
    );
  }

  //Datos Personales
  Widget _txtFormNombre() {
    return TextFormField(
      initialValue: artesano.nombre,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 50,
      decoration: InputDecoration(
        labelText: 'Nombres',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.brown, width: 2)),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Debe ingresar nombre su nombre o nombres';
        } else {
          return null;
        }
      },
      onSaved: (value) => artesano.nombre = value,
    );
  }

  Widget _txtFormApellidos() {
    return TextFormField(
      initialValue: artesano.apellidos,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 50,
      decoration: InputDecoration(
        labelText: 'Apellidos',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.brown, width: 2)),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Debe ingresar nombre sus apellidos';
        } else {
          return null;
        }
      },
      onSaved: (value) => artesano.apellidos = value,
    );
  }

  Widget _txtFormTelefono() {
    return TextFormField(
      initialValue: artesano.celular,
      keyboardType: TextInputType.numberWithOptions(),
      maxLength: 10,
      decoration: InputDecoration(
        labelText: 'Telefono o Celular',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.brown, width: 2)),
      ),
      validator: (value) {
        if (utils.isNumeric(value) && value.length == 10) {
          return null;
        } else {
          return 'Debe ingresar un numero telefonico valido';
        }
      },
      onSaved: (value) => artesano.celular = value,
    );
  }

  Widget _crearEmail(ValidationBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          initialValue: artesano.correo,
          keyboardType: TextInputType.emailAddress,
          maxLength: 40,
          decoration: InputDecoration(
            labelText: 'Email',
            counterText: snapshot.data,
            errorText: snapshot.error,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.brown, width: 2)),
          ),
          validator: (value) {
            if (snapshot.error != null) {
              return 'El email no es valido';
            } else {
              return null;
            }
          },
          onChanged: bloc.changeEmail,
          onSaved: (value) => artesano.correo = value,
        );
      },
    );
  }

  //Subir Datos

  Widget _crearBoton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          textStyle: TextStyle(color: Colors.white),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          primary: Colors.brown),
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: _guardando ? null : _sumbit,
    );
  }

  void _sumbit() async {
    if (!formKey.currentState.validate()) {
      //cuando los formularios no son validos
      return;
    }
    //disparo todos los saves del formulario

    formKey.currentState.save();
    setState(() {
      _guardando = true;
    });
    artesanoBloc.changeStreamArtesano(null);
    await artesanoBloc.editarArtesano(artesano);
    //artesanoProvider.editarArtesano(artesano);

    setState(() {
      //_guardando=false;
      mostrarSnackbar('Información guardada');
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.pop(context);
      });
    });
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = new SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
      action: SnackBarAction(
          label: 'VOLVER',
          onPressed: () => Navigator.pop(context, 'MenuArtesano')),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
