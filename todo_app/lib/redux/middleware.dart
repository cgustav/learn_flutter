import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/model.dart';
import 'package:redux/redux.dart';
import 'package:todo_app/redux/actions.dart';

void saveToPrefs(AppState state) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(state.toJson());
  await preferences.setString('itemsState', string);
}

Future<AppState> loadFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = preferences.getString('itemsState');
  if (string != null) {
    Map map = json.decode(string);
    return AppState.fromJson(map);
  }
  return AppState.initialState();
}

void appStateMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  next(action);
  if (action is AddItemAction ||
      action is RemoveItemsAction ||
      action is RemoveItemsAction) saveToPrefs(store.state);

  if (action is GetItemsAction) {
    await loadFromPrefs()
        .then((state) => store.dispatch(LoadedItemsAction(state.items)));
  }
}
