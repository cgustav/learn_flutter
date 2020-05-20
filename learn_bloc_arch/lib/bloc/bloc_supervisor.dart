import 'bloc_delegate.dart';

///Clase Singleton destinada a exponer a BlocDelegate
///como unica instancia para monitorear los eventos
///BLOC de toda nuestra aplicación
class BlocSupervisor {
  ///Instancia privada de BlocDelegate
  BlocDelegate _delegate = BlocDelegate();

  ///Nota: El constructor underscore
  ///(o constructor privado)
  ///no permite que [BlocSupervisor]
  ///pueda ser instanciado fuera de
  ///la misma clase.
  BlocSupervisor._();

  ///Instancia singleton de la clase BlocSupervisor
  static final BlocSupervisor _instance = BlocSupervisor._();

  ///Instancia singleton de [BlocDelegate]
  ///como propiedad de [BlocSupervisor]
  ///a la que accederemos en nuestra aplicación
  static BlocDelegate get delegate => _instance._delegate;

  ///Metodo destinado a reemplazar la instancia
  ///[BlocDelegate] de [BlocSupervisor] por una
  ///instancia personalizada.
  static set delegate(BlocDelegate d) {
    _instance._delegate = d ?? BlocDelegate();
  }
}
