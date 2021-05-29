import 'package:artesanos_a_la_mano/src/models/municipio_model.dart';
import 'package:artesanos_a_la_mano/src/providers/artesano_provider.dart';
import 'package:flutter/material.dart';

class ListaMunicipio extends StatefulWidget {

  @override
  _ListaMunicipioState createState() => _ListaMunicipioState();
}

class _ListaMunicipioState extends State<ListaMunicipio> {
  final artesanoProvider= new ArtesanoProvider();

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: artesanoProvider.todosLosMunicipios(),
      builder: (BuildContext context, AsyncSnapshot<List<MunicipioModel>> snapshot) {
        if(snapshot.data!=null){

        final municipios = snapshot.data;
        List<DropdownMenuItem<String>> getOpcionesDropDown(){
          List<DropdownMenuItem<String>> lista= new List();
          municipios.forEach((municipio){
              lista.add(DropdownMenuItem(
                child: Text(municipio.nombre),
                value: municipio.idMunicipio.toString(),
              )
            );
          }
          );
          print(lista.elementAt(0));
          return lista;
        }

        //return municipios;
        //return Container();
        return  Row(
            children: <Widget>[
              Text('Municipios: '),
              SizedBox(width: 0.0,),
              DropdownButton(
                //value: "Acateno",
                items: getOpcionesDropDown(),
                onChanged: (opt){
                  return opt;
                }
              )
            ],
        );
        

        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        //print(snapshot.data.apellidos);
      },
    );
  }
}



