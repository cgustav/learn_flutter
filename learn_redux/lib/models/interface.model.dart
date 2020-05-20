/* Clase de interfaz con funciones y 
   herramientas de utilidad recomendados
   para todos los modelos de la App.
*/

abstract class ModelInterface {
  Map<String, dynamic> get toJson;
  String toString();
}
