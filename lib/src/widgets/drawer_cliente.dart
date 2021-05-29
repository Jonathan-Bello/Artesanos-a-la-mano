import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/utils/utils.dart';
import 'package:flutter/material.dart';

class DrawerCliente extends StatelessWidget {
  //const DrawerCliente({Key key}) : super(key: key);
  final prefs = new PreferenciasUsuario();
  
  @override
  Widget build(BuildContext context) {
    final productosBloc= Provider.ofClienteProductos(context);
    final clienteBloc= Provider.ofCliente(context);
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white54,
          ),
          Container( 
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Colors.white12,
                    image: DecorationImage(
                      image: AssetImage('assets/img/propio/Logo1.png'),
                      fit: BoxFit.contain
                    )
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //colorFilter: ColorFilter.mode(Colors.black12, BlendMode.luminosity),
                    image: AssetImage('assets/img/fondo.jpg'),
                    fit: BoxFit.fill
                  )
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.home,color: Colors.purple,),
                        title: Text("Inicio"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, 'ClienteHome');
                        } 
                      ),
                      ListTile(
                        leading: Icon(Icons.star,color: Colors.purple,),
                        title: Text("Lo mas popular"),
                        onTap: () {
                          productosBloc.cargarProductosPopulares(prefs.idCliente);
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'ListadoProductosPopulares');
                        } 
                      ),
                      ListTile(
                        leading: Icon(Icons.category,color: Colors.purple,),
                        title: Text("Categorías"),
                        onTap: (){
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'ClienteCategorias');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.map,color: Colors.purple,),
                        title: Text("Regiones"),
                        onTap: (){
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'ListadoRegiones');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle,color: Colors.purple,),
                        title: Text("Cuenta"),
                        onTap: (){
                          clienteBloc.cargarCliente(prefs.idCliente);
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'ClienteCuenta');
                        },
                      ),
                    ],
                  ),
                )
              ),
              Container(
                color: Colors.purple,
                height: 20,
              ),
              AboutListTile(
                dense: true,
                icon: Icon(Icons.description,color: Colors.purple,),
                child: Text("Aviso Legal"),
                applicationIcon: Image(image: AssetImage('assets/img/propio/rostro.png'),width: 50,height: 50,),
                applicationName: 'Artensanos a la Mano',
                applicationVersion: '1.0',
                aboutBoxChildren: <Widget>[
                  Image(image: AssetImage('assets/img/propio/Letras.png')),
                ],
                applicationLegalese: 'AVISO LEGAL\n'+
                'En este espacio, el usuario, podrá encontrar toda la información relativa a los términos y condiciones legales que definen las relaciones entre los usuarios y nosotros como responsables de esta aplicación móvil. Como usuario, es importante que conozcas estos términos antes de continuar tu navegación. ValorArte Mexico. Como responsable de esta aplicación móvil, asume el compromiso de procesar la información de nuestros usuarios y clientes con plenas garantías y cumplir con los requisitos nacionales y europeos que regulan la recopilación y uso de los datos personales de nuestros usuarios. Esta aplicación móvil, por tanto, cumple rigurosamente con el RGPD (REGLAMENTO (UE) 2016/679 de protección de datos) y la LSSI-CE la Ley 34/2002, de 11 de julio, de servicios de la sociedad de la información y de comercio electrónico.'
                +'\n\nCOMPROMISOS Y OBLIGACIONES DE LOS USUARIOS\n'
                +'El Usuario queda informado, y se compromete a utilizar la aplicación móvil, sus servicios y contenidos sin contravenir la legislación vigente, la buena fe y el orden público.'
                +'\nQueda prohibido el uso de la aplicación móvil, con fines ilícitos o lesivos, o que, de cualquier forma, puedan causar perjuicio o impedir el normal funcionamiento de la aplicación móvil. Respecto de los contenidos de esta aplicación móvil, se prohíbe: Su reproducción, distribución o modificación, total o parcial, a menos que se cuente con la autorización de sus legítimos titulares; cualquier vulneración de los derechos del prestador o de los legítimos titulares.'
                +'\nEn la utilización de la aplicación móvil, el Usuario se compromete a no llevar a cabo ninguna conducta que pudiera dañar la imagen, los intereses y los derechos de o de terceros o que pudiera dañar, inutilizar o sobrecargar el portal, lo que impidiera, de cualquier forma, la normal utilización de la aplicación móvil. No obstante, debe ser consciente de que las medidas de seguridad de los sistemas informáticos en Internet no son enteramente fiables y que, por tanto el Titular no puede garantizar la inexistencia de virus u otros elementos que puedan producir alteraciones en los sistemas informáticos (software y hardware) del Usuario o en sus documentos electrónicos y ficheros contenidos en los mismos aunque el Titular pone todos los medios necesarios y toma las medidas de seguridad oportunas para evitar la presencia de estos elementos dañinos.'
                +'\nLos datos personales que facilite al Titular pueden ser almacenados en bases de datos automatizadas o no, cuya titularidad corresponde en exclusiva a el Titular, que asume todas las medidas de índole técnica, organizativa y de seguridad que garantizan la confidencialidad, integridad y calidad de la información contenida en las mismas de acuerdo con lo establecido en la normativa vigente en protección de datos.'

                +'\n\nRECLAMACIONES\n'
                +'Se informa que existen hojas de reclamación a disposición de usuarios y clientes. El Usuario podrá realizar reclamaciones solicitando su hoja de reclamación o remitiendo un correo electrónico a valorartemexicoo@gmail.com indicando su nombre y apellidos, el servicio y/o producto adquirido y exponiendo los motivos de su reclamación.'
                +'\nEl usuario/comprador podrá notificarnos la reclamación, bien a través de correo electrónico a: valorartemexicoo@gmail.com, si lo desea adjuntando el siguiente formulario de reclamación: El servicio/producto:'
                +'\nAdquirido el día:\n'
                +'Nombre del usuario:\n'
                +'Domicilio del usuario:\n'
                +'Firma del usuario (solo si se presenta en papel):\n'
                +'Fecha: Motivo de la reclamación:\n'

                +'\n\nLEY APLICABLE Y JURISDICCIÓN\n'
                +'Con carácter general las relaciones entre con los Usuarios de sus servicios telemáticos, presentes en esta aplicación móvil se encuentran sometidas a la legislación y jurisdicción mexicanas y a los tribunales.'

                +'\n\nCONTACTO\n'
                +'En caso de que cualquier Usuario tuviese alguna duda acerca de estas Condiciones legales o cualquier comentario sobre la aplicación móvil, por favor diríjase a valorartemexicoo@gmail.com.'
                +'\nDe parte del equipo que formamos ValorArte Mexico, te agradecemos el tiempo dedicado en leer este Aviso Legal. Esperamos que tengas una buena experiencia.'
              ),
              ListTile(
                leading: Icon(Icons.assignment_late,color: Colors.purple,),
                title: Text("Politica de Privacidad"),
                onTap: ()=>mostrarPoliticaPrivacidad(context)
              ),
              ListTile(
                leading: Icon(Icons.cancel,color: Colors.red,),
                title: Text("Cerrar Sesión"),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, 'Home');
                },
              ),
              Container(
                color: Colors.purple,
                height: 20,
              ),
            ],
          ),
        )
      ], 
      ),
    );
  }
}