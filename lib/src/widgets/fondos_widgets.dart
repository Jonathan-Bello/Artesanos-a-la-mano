import 'package:flutter/material.dart';

class FondoArtesano extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/img/propio/fondoA.jpg"),
        fit: BoxFit.cover
        ),
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
        image: AssetImage('assets/img/propio/barraA.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }
}

class FondoCliente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/img/propio/fondoU.jpg"),
        fit: BoxFit.cover
        ),
      ),
    );
  }
}

class FondoClienteBar extends StatelessWidget {
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