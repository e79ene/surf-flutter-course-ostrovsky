import 'package:places/data/redux/history/history_action.dart';
import 'package:places/data/redux/my_state.dart';
import 'package:places/data/redux/search/search_action.dart';
import 'package:redux/redux.dart';

class HistoryMiddleware implements MiddlewareClass<MyState> {
  @override
  call(Store<MyState> store, action, NextDispatcher next) {
    if (action is SearchStringAction) {
      if (action.searchString.isNotEmpty)
        store.dispatch(HistoryAddAction(action.searchString));
    }

    next(action);
  }
}
