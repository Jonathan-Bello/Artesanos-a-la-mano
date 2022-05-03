// import 'dart:convert';

// ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

// String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

// class ProductoModel {
//     int idProducto;
//     String nombre;
//     String descripcion;
//     double precio;
//     String categoria;
//     bool disponible;
//     String fotoUrl;
//     int idTienda;

//     ProductoModel({
//         this.idProducto,
//         this.nombre='',
//         this.descripcion ='',
//         this.precio=0.0,
//         this.categoria='',
//         this.disponible=true,
//         this.fotoUrl,
//         this.idTienda,
//     });

//     factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
//         //idProducto: json["id_producto"],
//         nombre: json["nombre"],
//         descripcion: json["descripcion"],
//         precio: json["precio"].toDouble(),
//         categoria: json["categoria"],
//         disponible: json["disponible"],
//         fotoUrl: json["fotoUrl"],
//         idTienda: json["idTienda"],
        
//     );

//     Map<String, dynamic> toJson() => {
//         //"id_producto": idProducto,
//         "nombre": nombre,
//         "descripcion": descripcion,
//         "precio": precio,
//         "categoria": categoria,
//         "disponible": disponible,
//         "fotoUrl": fotoUrl,
//         "idTienda": idTienda,
//     };
//  getImagen(){
//     if(foto==null){
//       //return 'https://previews.123rf.com/images/freshwater/freshwater1711/freshwater171100021/89104479-p%C3%ADxel-404-p%C3%A1gina-de-error-p%C3%A1gina-no-encontrada.jpg';
//     }else{
//       //return 'https://image.tmdb.org/t/p/w500/$';
//     }
//   }



import 'dart:convert';

ProductoModel productoFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    ProductoModel({
        this.idProducto,
        this.producto="",
        this.descripcion="",
        this.precio=1,
        this.categoria="",
        this.disponibilidad=0,
        this.foto,
        this.idArtesano=1,
        this.tieneLike=0,
    });

    String idProducto;
    String producto;
    String descripcion;
    double precio;
    String categoria;
    int disponibilidad;
    String foto;
    int idArtesano;
    int tieneLike;

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        idProducto: json["id"].toString(),
        producto: json["producto"].toString(),
        descripcion: json["descripcion"].toString(),
        precio: json["precio"].toDouble(),
        categoria: json["categoria"],
        disponibilidad: json["disponibilidad"],
        foto: json["foto"],
        idArtesano: json["idArtesano"],
        tieneLike: json["tieneLike"]
    );

    Map<String, dynamic> toJson() => {
        "id": idProducto,
        "producto": producto,
        "descripcion": descripcion,
        "precio": precio,
        "categoria": categoria,
        "disponibilidad": disponibilidad,
        "foto": foto,
        "idArtesano": idArtesano,
        "tieneLike" : tieneLike
    };
    
     getImagen(){
    if(foto==null){
      return 'https://previews.123rf.com/images/freshwater/freshwater1711/freshwater171100021/89104479-p%C3%ADxel-404-p%C3%A1gina-de-error-p%C3%A1gina-no-encontrada.jpg';
    }else{
      return '$foto';
    }
  }
}

