import 'package:flutter/material.dart';

class FondoArtesano extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/img/propio/fondoA.jpg"),
            fit: BoxFit.cover),
      ),
    );
  }
}

class FondoArtesanoBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/img/propio/barraU.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }
}

class HeaderCuadrado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Color(0xff615AAB),
    );
  }
}

class HeaderBordesRedondeados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: Color(0xff615AAB),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70),
            bottomRight: Radius.circular(70),
          )),
    );
  }
}

class HeaderDiagonalRect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // FondoCliente(),
        Container(
          height: double.infinity,
          width: double.infinity,
          alignment: AlignmentDirectional.topCenter,
          child: Image(
            height: height *.4,
            image: AssetImage('assets/img/propio/fondoU.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _HeaderDiagonalRectPainter(),
          ),
        )
      ],
    );
  }
}

class _HeaderDiagonalRectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    // lapiz.color = Color(0xFF0E0853);
    lapiz.color = Color(0xFFF4F4F5);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();
    // Dibujar con el path y el lapiz
    path.moveTo(0, size.height * 0.35);
    path.lineTo(size.width, size.height * 0.20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, lapiz);
    // canvas.drawImage(myBackground, Offset.zero, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderDiagonal extends StatelessWidget {
  final IconData icon;
  final String titulo;
  // final IconData buttonicon;
  // // final String buttonLabel;
  // // final Color colorButtonLabel;
  // // final Color colorButton;
  // // final Function onPress;

  final Color color1;
  final Color color2;
  const HeaderDiagonal({
    @required this.icon,
    @required this.titulo,
    // @required this.buttonicon,
    // @required this.buttonLabel,
    // @required this.onPress,
    this.color1 = Colors.orange,
    this.color2 = Colors.yellow,
    // this.colorButtonLabel,
    // this.colorButton,
  });

  @override
  Widget build(BuildContext context) {
    final colorNegro = Colors.black.withOpacity(0.70);
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          child: CustomPaint(
            painter: _HeaderDiagonalPainter(
                color1: this.color1, color2: this.color2),
          ),
        ),
        Positioned(
          top: -20,
          left: -50,
          child: Icon(
            this.icon,
            size: 250,
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 100,
              width: double.infinity,
            ),
            Text(
              this.titulo,
              style: TextStyle(
                fontSize: 35,
                color: colorNegro,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(
              this.icon,
              size: 100,
              color: colorNegro,
            ),
          ],
        ),
        // Positioned(
        //   top: 270,
        //   right: 10,
        //   child: Transform.rotate(
        //     angle: 0.2,
        //     child: RaisedButton.icon(
        //       label: Text('Editar',
        //         style: TextStyle(
        //           color: this.colorButtonLabel
        //         ),
        //       ),
        //       color: colorButton,
        //       icon: Icon (Icons.edit,color: this.colorButtonLabel,),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20.0)
        //       ),
        //       onPressed: this.onPress
        //     ),
        //   ),
        // )
      ],
    );
  }
}

class _HeaderDiagonalPainter extends CustomPainter {
  final Color color1;
  final Color color2;

  const _HeaderDiagonalPainter({@required this.color1, @required this.color2});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect =
        new Rect.fromCircle(center: Offset(0.0, 120.0), radius: 180);

    final Gradient gradiente = new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          color1,
          color2,
          color2,
          color2,
          color1
        ],
        stops: [
          0.2,
          0.4,
          0.5,
          0.7,
          1.0,
        ]);

    final lapiz = new Paint()..shader = gradiente.createShader(rect);

    // Propiedades
    lapiz.color = Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();

    // Dibujar con el path y el lapiz
    path.moveTo(0, size.height * 0.30);
    path.lineTo(size.width, size.height * 0.40);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderTriangular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderTriangularPainter(),
      ),
    );
  }
}

class _HeaderTriangularPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    lapiz.color = Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();

    // Dibujar con el path y el lapiz
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderPico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderPicoPainter(),
      ),
    );
  }
}

class _HeaderPicoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    lapiz.color = Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();

    // Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.25);
    path.lineTo(size.width * 0.5, size.height * 0.30);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderCurvo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderCurvoPainter(),
      ),
    );
  }
}

class _HeaderCurvoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    lapiz.color = Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();

    // Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.40, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderWave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderWavePainter(),
      ),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    lapiz.color = Color.fromRGBO(232, 217, 56, 1);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();

    // Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.30,
        size.width * 0.5, size.height * 0.25);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.20, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderWaveGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderWaveGradientPainter(),
      ),
    );
  }
}

class _HeaderWaveGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect =
        new Rect.fromCircle(center: Offset(0.0, 55.0), radius: 180);

    final Gradient gradiente = new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          // Color(0xff6D05E8),
          // Color(0xffC012FF),
          // Color(0xff6D05FA),
        ],
        stops: [
          0.2,
          0.5,
          1.0,
        ]);

    final lapiz = new Paint()..shader = gradiente.createShader(rect);

    // Propiedades
    // lapiz.color = Color(0xff615AAB);
    // lapiz.color = Colors.red;
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();

    // Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.30,
        size.width * 0.5, size.height * 0.25);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.20, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class IconHeader extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final Color color1;
  final Color color2;

  const IconHeader({
    @required this.icon,
    @required this.titulo,
    this.color1 = Colors.orange,
    this.color2 = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    final colorNegro = Colors.black.withOpacity(0.70);
    return Stack(
      children: <Widget>[
        _IconHeaderBackground(
          color1: this.color1,
          color2: this.color2,
        ),
        Positioned(
          top: -20,
          left: -50,
          child: Icon(
            this.icon,
            size: 250,
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 100,
              width: double.infinity,
            ),
            Text(
              this.titulo,
              style: TextStyle(
                fontSize: 40,
                color: colorNegro,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(
              this.icon,
              size: 100,
              color: colorNegro,
            ),
          ],
        )
      ],
    );
  }
}

class _IconHeaderBackground extends StatelessWidget {
  final Color color1;
  final Color color2;

  const _IconHeaderBackground(
      {Key key, @required this.color1, @required this.color2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          //color:Color.fromRGBO(232, 217, 56, 1),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
          // image: DecorationImage(
          //   image: AssetImage('assets/img/propio/barraU.jpg'),
          //   fit: BoxFit.cover,
          // ),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                color1,
                color2,
                color2,
                color2,
                color1
                // Colors.orange,
                // Color.fromRGBO(232, 217, 56, 1),
                // Color.fromRGBO(232, 217, 56, 1),
                // Color.fromRGBO(232, 217, 56, 1),
                // Colors.orange
              ])),
    );
  }
}
