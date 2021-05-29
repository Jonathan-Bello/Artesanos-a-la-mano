import 'dart:async';

class Validators{

  final validarPassWord= StreamTransformer<String,String>.fromHandlers(
    handleData: (password, sink){
      if(password.length>2){
        sink.add(password);
      }else{
        sink.addError('Deben ser mas de 3 caracteres');
      }
    }
  );
  
  final validarEmail= StreamTransformer<String,String>.fromHandlers(
    handleData: (email, sink){
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp= new RegExp(pattern);
      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError('El email no es valido');
      }
    }
  );

  final validarUsuario= StreamTransformer<String,String>.fromHandlers(
    handleData: (user, sink){
      if(user.length>2){
        sink.add(user);
      }else{
        sink.addError('Deben ser mas de 3 caracteres');
      }
    }
  );

  final validarPalabra = StreamTransformer<String, String>.fromHandlers(
    handleData: (string, sink){
      if(string.length>3){
        sink.add(string);
      }
      else{
        sink.addError('Debe tener más de 3 caracteres');
      }
    }
);

}