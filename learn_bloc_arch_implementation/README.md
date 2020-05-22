# learn_bloc_arch_implementation

Implementación del Patrón BloC con buenas prácticas de diseño.

## Notas

**Provider:** Es un patrón de diseño de los lenguajes orientados a objetos. En el caso de flutter, provider se puede aplicar sobre un widget cualquiera, asignándole propiedades o una funcionalidad específica para permitir que los widgets de cualquier nivel en el árbol de widgets pueden acceder a este objeto y sus propiedades, sin acudir directamente a la herencia y evitando así la repetición de código. Por lo tanto Provider ofrece una solución práctica de diseño en aquellos casos donde, debamos compartir información a través de múltiples widgets siguiendo los principios de Inyección de Dependencias (DI).


**Inherited Widget:** Es un Widget utilizado principalmente para propagar información de manera eficiente a través del árbol de widgets.

![](https://image.slidesharecdn.com/gdg-london-08-201843-180810072757/95/inheritedwidget-is-your-friend-gdg-london-20180808-24-638.jpg?cb=1533886195)

InheritedWidget es una herramienta sumamente útil, y puede llegar a mejorar significativamente el rendimiento de nuestra aplicación a medida que esta se hace más robusta.

Para ilustrar el punto anterior de mejor manera, podemos imaginar un caso dónde deseamos acceder a las propiedades de una clase ancestra **T** desde una clase hija **Y** haciendo uso únicamente de la herencia entre widgets (clases) del árbol; sucede que existen 100 widgets (de distancia) entre ancestro e hijo por lo que para lograr acceder a **T** nuestra aplicación deberá buscar entre los 100 widgets ancestros hasta encontrar la clase exacta "**T**". En términos de eficiencia, nuestra aplicación contaría con un comportamiento lineal **O(N)**, es decir a medida que aumenta el número de "**_clases hijo_**" (N), el costo total en recursos para acceder a un widget ancestro aumentará en proporción **O(N)** algo que siempre deberíamos evitar por distintos motivos.

Al utilizar InheritedWidget, nuestra aplicación registra automáticamente todos los **InheritedWidget** registrados en el árbol dentro del contexto (BuildContext) de la aplicación mediante un _**Hash Map**_. Esto provoca que, ahora en lugar de buscar entre 100 Widgets ancestros, **Y** rápidamente acceda a través del contexto a **T**, de entre otros 4 InheritedWidgets registrados, haciendo que la eficiencia de nuestra app siga siendo lineal O(N), pero esta vez sea constante, es decir, aumentar el número de "_**clases hijo**_" no significa aumentar el costo total en recursos.


Un claro ejemplo del uso de InheritedWidget son las funciones `Theme.of(context)` y `Navigator.of(context)`, (entre otros) donde `Theme` y `Navigator`, clases que extienden de `InheritedWidget` a los que podremos acceder a través de cualquier clase descendiente de `MaterialApp`.

```dart
context.inheritFromWidgetOfExactType(targetType)
```

```dart
context.ancestorInheritedElementForWidgetOfExactType(targetType)
```

Para implementar la clase `BlocProvider` con InheritedWidget en desde cualquier widget de nuestra app, se debe establecer como padre de `MaterialApp`:

![](https://i.imgur.com/2QQSWsl.png)

_**En la clase padre:**_
```dart
BlocProvider(
    bloc: myBloc,
    child: MyChild()
)
```

_**En las clases hijas:**_
```dart
//Obtener el BlocProvider de nuestro Bloc
BlocProvider.of<MyBloc>(context);
```

por lo tanto la implementación específica en el archivo main quedaría de la siguiente manera:

```dart
void main() {
  //... 
  final counterBloc = CounterBloc();

  runApp(BlocProvider(
    bloc: counterBloc,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    ),
  ));
  //...
}
```
