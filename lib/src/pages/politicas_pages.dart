import 'package:flutter/material.dart';

class PoliticasPages extends StatelessWidget {
  //const PoliticasPages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Politicas de Privacidad'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 35,),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    'Artesanos a la Mano',
                    style: TextStyle(
                      fontSize: 25,
                      height: 0
                    )
                  ),
                  Image(image: AssetImage('assets/img/propio/rostro.png'),width: 65,height: 65,),
                  Text(
                    '1.0',
                    style: TextStyle(
                      height: 0.5
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'AVISO DE PRIVACIDAD VALORARTE MÉXICO\n'
                +'ValorArte México, es la empresa responsable del tratamiento de los datos personales que nos proporcione, los cuales serán protegidos conforme a lo dispuesto por la Ley de Protección de Datos Personales en Posesión de Sujetos Obligados para el Estado de Puebla, y demás normatividad que resulte aplicable.'
                ,textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Finalidades del tratamiento'
                +'\nSus datos personales, serán utilizados para las siguientes finalidades: 1'
                +'\na) recuperar la contraseña en caso de perderla'
                +'\nb) fines estadísticos'
                +'\nc) acuerdos en la comunicación',
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '\nDe manera adicional, utilizaremos su información personal para las siguientes finalidades que no son necesarias, pero que nos permiten y facilitan brindarle una mejor atención:'
                '• envío de información'
                '• invitaciones a futuros eventos'
                '\n\nDATOS PERSONALES RECABADOS'
                '\nPara las finalidades antes señaladas se solicitarán los siguientes datos personales: nombre completo, lugar de procedencia, sexo, teléfono o correo electrónico y firma. Se informa que se recaban datos personales sensibles. Fundamento legal El fundamento para el tratamiento de datos personales son los artículos 29 y 30 Transmisión de datos personales.'
                '\nSe informa que no realizarán transferencias que requieran su consentimiento, salvo aquellas que sean necesarias para atender requerimientos de información de una autoridad competente, debidamente fundados y motivados.'
                '\n\nDERECHOS ARCO'
                '\nUsted tiene derecho a conocer qué datos personales se tienen de usted, para qué se utilizan y las condiciones del uso que les damos (Acceso). Asimismo, es su derecho solicitar la corrección de su información personal en caso de que esté desactualizada, sea inexacta o incompleta (Rectificación); que la eliminemos de nuestros registros o bases de datos cuando considere que la misma no está siendo utilizada conforme a los principios, deberes y obligaciones previstas en la ley (Cancelación); así como oponerse'
                'al uso de sus datos personales para fines específicos (Oposición). Estos derechos se conocen como derechos ARCO. Para el ejercicio de cualquiera de los derechos ARCO, usted podrá presentar solicitud por escrito al correo de la empresa. Los requisitos que debe cumplir son: • El nombre del titular y su domicilio o cualquier otro medio para recibir notificaciones; • Los documentos que acrediten la identidad del titular, y en su caso, la personalidad e identidad de su representante; • La descripción clara y precisa de los datos personales respecto de los que se busca ejercer alguno de los derechos ARCO, salvo que se trate del derecho de acceso; • La descripción del derecho ARCO que se pretende ejercer, o bien, lo que solicita el titular; y • Cualquier otro elemento o documento que facilite la localización de los datos personales, en su caso. En caso de solicitar la rectificación, adicionalmente deberá indicar las modificaciones a realizarse. En el derecho de cancelación debe expresar las causas que motivan la eliminación. Y en el derecho de oposición debe señalar los motivos que justifican se finalice el tratamiento de los datos personales y el daño o perjuicio que le causaría, o bien, si la oposición es parcial, debe indicar las finalidades específicas con las que se no está de acuerdo, siempre que no sea un requisito obligatorio.'
                '\nLa respuesta indicará si la solicitud de acceso, rectificación, cancelación u oposición es procedente y, en su caso, hará efectivo dentro de los 8 días hábiles siguientes a la fecha en que comunique la respuesta.'
                '\n\nDATOS'
                '\nCorreo electrónico de la empresa: valorartemexico2020@gmail.com Cambios a la Política de Privacidad'
                'En caso de realizar alguna modificación al Aviso de Privacidad, se le hará de su conocimiento vía correo electrónico.'
                '\n\nPolíticas de Privacidad.\n'
                'Esta política de privacidad rige para todas las aplicaciones móviles para Android creadas por ValorArte México y publicadas en la cuenta de desarrollador conel nombre antes mencionado.'
                '\n¿Qué tipo de información recolectamos?'
                '\nPara el correcto funcionamiento de las aplicaciones que construimos o desarrollamos, estos son algunos de los datos que recolectamos:'
                '\n\nUbicación\n'
                'Para el caso de las aplicaciones que sea necesario accedemos a los datos proporcionados por el GPS. Estos datos no los manejamos nosotros, son directamente manejado por Google Maps.'
                '\n\nCookies\n'
                'Las cookies son archivos con una pequeña cantidad de datos que se usan comúnmente como identificadores únicos anónimos. Estos se envían a su navegador desde los sitios web que visita y se almacenan en la memoria interna de su dispositivo.'
                '\nEste servicio no utiliza estas «cookies» explícitamente. Sin embargo, la aplicación puede usar código de terceros y bibliotecas que usan «cookies» para recopilar información y mejorar sus servicios.'
                '\n\nDato de registro\n'
                'Quiero informarle que cada vez que utiliza mi Servicio, en caso de un error en la aplicación, recopilo datos e información (a través de productos de terceros) en su teléfono llamados Datos de registro. Estos datos de registro pueden incluir información como la dirección del Protocolo de Internet («IP») de su dispositivo, el nombre del dispositivo, la versión del sistema operativo, la configuración de la aplicación cuando utiliza mi Servicio, la hora y la fecha de uso del Servicio y otras estadísticas.'
                '\n\nProveedores de servicio\n'
                'Puedo emplear a empresas e individuos de terceros debido a las siguientes razones:'
                '\n• Para facilitar nuestro servicio;'
                '\n• Para proporcionar el Servicio en nuestro nombre;'
                '\n• Para realizar servicios relacionados con el Servicio; o'
                '\n• Para ayudarnos a analizar cómo se utiliza nuestro Servicio.'
                '\nDeseo informar a los usuarios de este Servicio que estos terceros tienen acceso a su Información personal. La razón es realizar las tareas que se les asignaron en nuestro nombre. Sin embargo, están obligados a no divulgar ni utilizar la información para ningún otro propósito.'
                '\n\nSeguridad\n'
                'Valoro su confianza en proporcionarnos su información personal, por lo tanto, nos esforzamos por utilizar medios comercialmente aceptables para protegerla. Pero recuerde que ningún método de transmisión por Internet o método de almacenamiento electrónico es 100% seguro y confiable, y no puedo garantizar su seguridad absoluta.'
                '\n\nSeguridad\n'
                'Valoro su confianza en proporcionarnos su información personal, por lo tanto, nos esforzamos por utilizar medios comercialmente aceptables para protegerla. Pero recuerde que ningún método de transmisión por Internet o método de almacenamiento electrónico es 100% seguro y confiable, y no puedo garantizar su seguridad absoluta.'
                '\n\nEnlaces a otros sitios\n'
                'Este servicio puede contener enlaces a otros sitios. Si hace clic en un enlace de un tercero, será dirigido a ese sitio. Tenga en cuenta que estos sitios externos no son operados por mí. Por lo tanto, le recomiendo que revise la Política de privacidad de estos sitios web. No tengo control ni asumo ninguna responsabilidad por el contenido, las políticas de privacidad o las prácticas de sitios o servicios de terceros.'
                '\n\nPrivacidad de los niños\n'
                'Estos Servicios no se dirigen a ninguna persona menor de 13 años. No recopilo a sabiendas información de identificación personal de niños menores de 13 años. En el caso de que descubra que un niño menor de 13 años me ha proporcionado información personal, la borro inmediatamente de nuestros servidores. Si usted es padre o tutor y sabe que su hijo nos ha proporcionado información personal, comuníquese conmigo para que pueda realizar las acciones necesarias.'
                '\n\n¿Qué hacemos con los datos que recolectamos?\n'
                'Los datos recolectados son de dos tipos:'
                '\n• Datos recolectados por nosotros.'
                '\n• Datos recolectados por terceros.'
                '\n\nDatos recolectados por nosotros\n'
                'Estos datos se recolectan para obtener un feedback de que es lo que quieren nuestros usuarios y así poder mejorar brindando las correctas mejoras en cada actualización.'
                '\nLos datos son manipulados a nivel de código, luego procesados en grandes cantidades, pero en ningún momento accedemos a datos de un usuario en particular, pues están encriptados y solo el usuario dueño de la información puede acceder a ellos.'
                '\n\nDatos recolectados por terceros\n'
                'En los datos recolectados por terceros están:'
                '\n• Google Play'
                '\n• Google Analytics'
                '\n• 000webhost'
                '\n• Cloudinary'
                ,textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                )
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}