import 'dart:async';
import 'dart:io';

import 'package:artesanos_a_la_mano/src/utils/utils.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/utils/utils.dart' as utils;


class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  ProductoModel producto= new ProductoModel();
  ProductosBloc productosBloc;
  bool _guardando = false;
  File foto;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey= GlobalKey<ScaffoldState>();

  //Preferencias de Ususario
  final prefs = new PreferenciasUsuario();

  int _usuarioId;
  
  @override
  void initState() {
    super.initState();
    _usuarioId = prefs.id;
  }
  //Ya se obtuvo el id del Artesano

  List<String> _categorias=[
    'Seleccioné Categoría',
    'Cerámica',
    'Barro',
    'Madera',
    'Mármol, Piedra y Vidrio',
    'Metal',
    'Piel y Cuero',
    'Textil',
    'Joyería',
    'Varios'
  ];
  String  _opcionSelecionada = "Seleccioné Categoría";

  @override
  Widget build(BuildContext context) {

    producto.idArtesano=_usuarioId;

    productosBloc= Provider.ofProduc(context);
    //guardo los argumentos que posiblemente me envien
    final ProductoModel prodData= ModalRoute.of(context).settings.arguments;
    if(prodData != null){
      producto = prodData;
      //Para limipiar el valor de la foto para eviatar errores
      if(producto.foto=='null'){
        producto.foto=null;
      }
      //Leemos la categoria del producto si existe.
      _opcionSelecionada = producto.categoria;
    }
    return Stack(
      children: <Widget>[
        FondoArtesano(),
        Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            flexibleSpace: FondoArtesanoBar(),
            centerTitle: true,
            title: Text('PRODUCTO',
              style: TextStyle(
              color: Colors.brown, 
              fontStyle: FontStyle.italic, 
              wordSpacing: 5.0, fontSize: 30.0, 
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add_photo_alternate),
                color: Colors.black87, 
                onPressed: _selecionarFoto,
              ),
              IconButton(
                icon: Icon(Icons.camera_alt), 
                color: Colors.black87, 
                onPressed: _tomarFoto,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Container(
                  color: Colors.white54,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      _mostrarFoto(),
                      _crearNombre(),
                      SizedBox(height: 20,),
                      _crearPrecio(),
                      _crearDisponible(),
                      _crearCategorias(),
                      _crearDecripcion(),
                      _crearBoton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      initialValue: producto.producto,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
       fillColor: Colors.amber, 
        hoverColor: Colors.white,
        focusColor: Colors.white,
        labelText: 'Nombre Producto'
      ),
      //Validación del del txtField
      validator: (value){
        if(value.length<3){
          return 'Ingrese nombre del producto';
        }else{
          //si returno null es que todo "ok"
          return null;
        }
      },
      //se ejecuta despues de validar el campo
      //Aqui le digo que al momento de que se valida el valor lo se lo asigno al proucto
      onSaved: (value)=> producto.producto = value ,
    );
  }

  Widget _crearPrecio(){
    return TextFormField(
      initialValue: producto.precio.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      validator: (value){
        if ( utils.isNumeric(value)  ) {
          return null;
        } else {
          return 'Sólo números';
        }
      },
      onSaved: (value)=> producto.precio= double.parse(value),
    );
  }

  Widget _crearBoton(){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.brown,
      textColor: Colors.white,
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
    //Validación para segurar que se eligió un categoria
    if(_opcionSelecionada=='Seleccioné Categoría'){
      mostrarAlerta(context,"Debe elegir una categoría");
      setState(() {
        _guardando=false;
      });
      return;
    }else{
      //subir la imagen que cargo el usuario
      if( foto != null ){
        producto.foto= await productosBloc.subirFoto(foto);
      }
      if(producto.idProducto == null){
      //producto.foto="https://res.cloudinary.com/fenixgames/image/upload/v1588213024/mxxg2ds51qclgwmaio3w.png";
      productosBloc.agregarProducto(producto);  
      }else{
      //producto.foto="https://res.cloudinary.com/fenixgames/image/upload/v1588212834/mruxwujnes74djab7ttw.jpg";
      productosBloc.editarProducto(producto);
      }
    }
    //Ya deberia enviar el producto
    // if(producto.idProducto == null){
    //   //producto.foto="https://res.cloudinary.com/fenixgames/image/upload/v1588213024/mxxg2ds51qclgwmaio3w.png";
    //   productosBloc.agregarProducto(producto);  
    // }else{
    //   //producto.foto="https://res.cloudinary.com/fenixgames/image/upload/v1588212834/mruxwujnes74djab7ttw.jpg";
    //   productosBloc.editarProducto(producto);
    // }

     setState(() {
      //_guardando=false;
      mostrarSnackbar('Guardando producto');
        Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pop(context);
    });
    });
  }

  void mostrarSnackbar(String mensaje){
    final snackbar = new SnackBar(
      content: Text(mensaje),
      duration: Duration( milliseconds: 1000 ),
      action: SnackBarAction(
        label: 'VOLVER',
        onPressed: () => Navigator.pop(context, 'MenuArtesano')
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _crearDisponible(){
    bool aux=false;
    if(producto.disponibilidad==1){
      aux=true;
    }else{
      aux=false;
    }

    return SwitchListTile(
      value: aux,
      title: Text('Disponible'),
      activeColor: Colors.brown,
      onChanged: (value)=> setState((){
        if(value==true){
          producto.disponibilidad = 1;
        }else{
          producto.disponibilidad = 0;
        } 
      }),
    );
  }

  Widget _crearDecripcion(){
    return TextFormField(
      initialValue: producto.descripcion,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 150,
      maxLines: 4,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.brown
        ),
        labelText: 'Descripción del Producto',
      ),
      
      validator: (value){
        if(value.length<10){
          return 'La descripcion debe ser de al menos 10 caracteres';
        }else{
          return null;
        }
      },
      //se ejecuta despues de validar el campo
      onSaved: (value)=> producto.descripcion= value ,
    );

  }
  
  Widget _crearCategorias(){
    return Row(
      children: <Widget>[
        Text('Categorías: '),
        SizedBox(width: 30.0,),
        DropdownButton(
          value: _opcionSelecionada,
          items: getOpcionesDropDown(),
          onChanged: (opt){
            setState(() {
              _opcionSelecionada=opt;  
              producto.categoria = opt.toString();
              FocusScope.of(context).requestFocus(FocusNode());
            });
          }
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown(){
    List<DropdownMenuItem<String>> lista= new List();
    _categorias.forEach((categoria){
      lista.add(DropdownMenuItem(
        child: Text(categoria),
        value: categoria,
      )
      );
    }
    );
    return lista;
  }

  //Proceso de las fotos
  Widget _mostrarFoto() {
    if (producto.foto != null) {
      return FadeInImage(
        image: NetworkImage( producto.foto ),
        placeholder: AssetImage('assets/img/loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      if( foto != null ){
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/img/imagenNull.png');
    }
  }

  _selecionarFoto() async{
    _procesarImagen(ImageSource.gallery);  
  }
 
  _tomarFoto() async{
    _procesarImagen(ImageSource.camera);
  }
  
  Future _procesarImagen(ImageSource origen) async{
    final picker = ImagePicker();
    // if(){

    // }
    final pickedFile = await picker.getImage(
      source: origen,
      imageQuality: 27,
      maxWidth: 1000,
      maxHeight: 1000
    );
    foto=File(pickedFile.path);
    if(foto != null){
      producto.foto = null;
    }
    setState(() {});
  }
}