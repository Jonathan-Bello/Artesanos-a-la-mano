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
                        title: Text("Categor??as"),
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
                'En este espacio, el usuario, podr?? encontrar toda la informaci??n relativa a los t??rminos y condiciones legales que definen las relaciones entre los usuarios y nosotros como responsables de esta aplicaci??n m??vil. Como usuario, es importante que conozcas estos t??rminos antes de continuar tu navegaci??n. ValorArte Mexico. Como responsable de esta aplicaci??n m??vil, asume el compromiso de procesar la informaci??n de nuestros usuarios y clientes con plenas garant??as y cumplir con los requisitos nacionales y europeos que regulan la recopilaci??n y uso de los datos personales de nuestros usuarios. Esta aplicaci??n m??vil, por tanto, cumple rigurosamente con el RGPD (REGLAMENTO (UE) 2016/679 de protecci??n de datos) y la LSSI-CE la Ley 34/2002, de 11 de julio, de servicios de la sociedad de la informaci??n y de comercio electr??nico.'
                +'\n\nCOMPROMISOS Y OBLIGACIONES DE LOS USUARIOS\n'
                +'El Usuario queda informado, y se compromete a utilizar la aplicaci??n m??vil, sus servicios y contenidos sin contravenir la legislaci??n vigente, la buena fe y el orden p??blico.'
                +'\nQueda prohibido el uso de la aplicaci??n m??vil, con fines il??citos o lesivos, o que, de cualquier forma, puedan causar perjuicio o impedir el normal funcionamiento de la aplicaci??n m??vil. Respecto de los contenidos de esta aplicaci??n m??vil, se proh??be: Su reproducci??n, distribuci??n o modificaci??n, total o parcial, a menos que se cuente con la autorizaci??n de sus leg??timos titulares; cualquier vulneraci??n de los derechos del prestador o de los leg??timos titulares.'
                +'\nEn la utilizaci??n de la aplicaci??n m??vil, el Usuario se compromete a no llevar a cabo ninguna conducta que pudiera da??ar la imagen, los intereses y los derechos de o de terceros o que pudiera da??ar, inutilizar o sobrecargar el portal, lo que impidiera, de cualquier forma, la normal utilizaci??n de la aplicaci??n m??vil. No obstante, debe ser consciente de que las medidas de seguridad de los sistemas inform??ticos en Internet no son enteramente fiables y que, por tanto el Titular no puede garantizar la inexistencia de virus u otros elementos que puedan producir alteraciones en los sistemas inform??ticos (software y hardware) del Usuario o en sus documentos electr??nicos y ficheros contenidos en los mismos aunque el Titular pone todos los medios necesarios y toma las medidas de seguridad oportunas para evitar la presencia de estos elementos da??inos.'
                +'\nLos datos personales que facilite al Titular pueden ser almacenados en bases de datos automatizadas o no, cuya titularidad corresponde en exclusiva a el Titular, que asume todas las medidas de ??ndole t??cnica, organizativa y de seguridad que garantizan la confidencialidad, integridad y calidad de la informaci??n contenida en las mismas de acuerdo con lo establecido en la normativa vigente en protecci??n de datos.'

                +'\n\nRECLAMACIONES\n'
                +'Se informa que existen hojas de reclamaci??n a disposici??n de usuarios y clientes. El Usuario podr?? realizar reclamaciones solicitando su hoja de reclamaci??n o remitiendo un correo electr??nico a valorartemexicoo@gmail.com indicando su nombre y apellidos, el servicio y/o producto adquirido y exponiendo los motivos de su reclamaci??n.'
                +'\nEl usuario/comprador podr?? notificarnos la reclamaci??n, bien a trav??s de correo electr??nico a: valorartemexicoo@gmail.com, si lo desea adjuntando el siguiente formulario de reclamaci??n: El servicio/producto:'
                +'\nAdquirido el d??a:\n'
                +'Nombre del usuario:\n'
                +'Domicilio del usuario:\n'
                +'Firma del usuario (solo si se presenta en papel):\n'
                +'Fecha: Motivo de la reclamaci??n:\n'

                +'\n\nLEY APLICABLE Y JURISDICCI??N\n'
                +'Con car??cter general las relaciones entre con los Usuarios de sus servicios telem??ticos, presentes en esta aplicaci??n m??vil se encuentran sometidas a la legislaci??n y jurisdicci??n mexicanas y a los tribunales.'

                +'\n\nCONTACTO\n'
                +'En caso de que cualquier Usuario tuviese alguna duda acerca de estas Condiciones legales o cualquier comentario sobre la aplicaci??n m??vil, por favor dir??jase a valorartemexicoo@gmail.com.'
                +'\nDe parte del equipo que formamos ValorArte Mexico, te agradecemos el tiempo dedicado en leer este Aviso Legal. Esperamos que tengas una buena experiencia.'
              ),
              ListTile(
                leading: Icon(Icons.assignment_late,color: Colors.purple,),
                title: Text("Politica de Privacidad"),
                onTap: ()=>mostrarPoliticaPrivacidad(context)
              ),
              ListTile(
                leading: Icon(Icons.cancel,color: Colors.red,),
                title: Text("Cerrar Sesi??n"),
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