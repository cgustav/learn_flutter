import 'package:flutter/widgets.dart';
import 'package:learn_bloc_arch_implementation/flutter_bloc/bloc_listener.dart';
import 'bloc_provider.dart';

class BlocListenerTree extends StatelessWidget {
  final List<BlocListener> blocListeners;
  final Widget child;

  BlocListenerTree({
    Key key,
    @required this.blocListeners,
    @required this.child,
  })  : assert(blocListeners != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tree = child;

    for (var blocListener in blocListeners.reversed) {
      tree = blocListener.copyWith(tree);
    }

    return tree;
  }
}
