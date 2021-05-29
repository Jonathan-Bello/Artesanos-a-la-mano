import 'package:rxdart/rxdart.dart';

import 'package:artesanos_a_la_mano/src/models/artesano_model.dart';
import 'package:artesanos_a_la_mano/src/models/municipio_model.dart';
import 'package:artesanos_a_la_mano/src/providers/artesano_provider.dart';

class ArtesanoBloc{
  final _artesanoProvider = new ArtesanoProvider();

  final _artesanoController = new BehaviorSubject<ArtesanosModel>();
  Stream<ArtesanosModel> get artesanoStream => _artesanoController.stream;
  Function(ArtesanosModel) get changeStreamArtesano   => _artesanoController.sink.add;
  ArtesanosModel get artesano    => _artesanoController.value;

  final _artesanosRegionController = new BehaviorSubject<List<ArtesanosModel>>();
  Stream<List<ArtesanosModel>> get artesanosRegionStream => _artesanosRegionController.stream;
  Function(List<ArtesanosModel>) get changeStreamArtesanosRegion   => _artesanosRegionController.sink.add;
  
  final _artesanosMunicipioController = new BehaviorSubject<List<ArtesanosModel>>();
  Stream<List<ArtesanosModel>> get artesanosMunicipioStream => _artesanosMunicipioController.stream;
  Function(List<ArtesanosModel>) get changeStreamArtesanosMunicipio   => _artesanosMunicipioController.sink.add;

  final _cargandoController = new BehaviorSubject<bool>();
  Stream<bool> get cargando => _cargandoController.stream;

  final _municipioController = new BehaviorSubject<MunicipioModel>();
  Stream<MunicipioModel> get municipioStream => _municipioController.stream;

  Future<ArtesanosModel> cargarArtesano(int id) async {
    //_cargandoController.sink.add(true);
    final artesano = await _artesanoProvider.obtenerArtesano(id);
    //_cargandoController.sink.add(false);
    _artesanoController.sink.add( artesano );
    return artesano;
  }

  Future editarArtesano( ArtesanosModel artesano ) async {
    _cargandoController.sink.add(true); 
    await _artesanoProvider.editarArtesano(artesano);
    _cargandoController.sink.add(false);
  }

  void cargarArtesanoRegion(int region) async {
    final artesanos = await _artesanoProvider.getArtesanoRegion(region);
    _artesanosRegionController.sink.add( artesanos );
  }

  void cargarArtesanoMunicipio(int municipio) async {
    final artesanos = await _artesanoProvider.getArtesanoMunicipio(municipio);
    _artesanosMunicipioController.sink.add( artesanos );
  }

  Future<MunicipioModel> cargarMunicipio(int id) async {
    final municipio=await _artesanoProvider.consultarMunicipio(id);
    _municipioController.sink.add( municipio );
    return municipio;
  }



  dispose(){
    _artesanoController?.close();
    _artesanosRegionController?.close();
    _artesanosMunicipioController?.close();
    _municipioController?.close();
    _cargandoController.close();
  }

}