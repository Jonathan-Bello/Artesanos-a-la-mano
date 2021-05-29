import 'package:artesanos_a_la_mano/src/models/municipio_model.dart';
import 'package:artesanos_a_la_mano/src/providers/municipio_provider.dart';
import 'package:rxdart/rxdart.dart';


class MunicipiosBloc{
  final _providerMunicipios = new MunicipiosProvider();

  //Stream Aleatorio
  final _municipiosRegionController = new BehaviorSubject<List<MunicipioModel>>();
  Stream<List<MunicipioModel>> get municipiosRegion => _municipiosRegionController.stream;
  Function(List<MunicipioModel>) get changeStreamMuncipiosRegion   => _municipiosRegionController.sink.add;

  final _cargandoController = new BehaviorSubject<bool>();
  Stream<bool> get cargando => _cargandoController.stream;


  void cargarMuncipiosRegion(int region) async {
    final municipios = await _providerMunicipios.getMunicipiosRegion(region);
    _municipiosRegionController.sink.add( municipios );
  }


  dispose(){
    _municipiosRegionController?.close();
    _cargandoController.close();
  }
}