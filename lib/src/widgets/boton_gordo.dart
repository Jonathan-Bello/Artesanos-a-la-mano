import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonGordo extends StatelessWidget {
  // const ButtonGordo({Key key}) : super(key: key);
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final Function onPress;

  const ButtonGordo(
      {@required this.icon,
      @required this.texto,
      this.color1 = Colors.blue,
      this.color2 = Colors.purple,
      @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Stack(
        children: <Widget>[
          _ButtonGordoBackground(
            color1: this.color1,
            color2: this.color2,
            icon: this.icon,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 140,
                width: 40,
              ),
              FaIcon(this.icon, size: 40, color: Colors.white),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                this.texto,
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
              FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
              SizedBox(
                width: 40,
              )
            ],
          )
        ],
      ),
    );
  }
}

class _ButtonGordoBackground extends StatelessWidget {
  final Color color1;
  final Color color2;
  final IconData icon;

  const _ButtonGordoBackground(
      {@required this.color1, @required this.color2, @required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: <Widget>[
            Positioned(
                right: -20,
                top: -20,
                child: FaIcon(this.icon,
                    size: 150, color: Colors.white.withOpacity(0.2)))
          ],
        ),
      ),
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(1),
                offset: Offset(4, 6),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: <Color>[
            // Color(0xff6989F5),
            // Color(0xff906EF5)
            color1,
            color2
          ])),
    );
  }
}
