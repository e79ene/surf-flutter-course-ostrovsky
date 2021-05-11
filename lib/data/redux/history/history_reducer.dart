import 'package:places/data/redux/history/history_action.dart';
import 'package:places/data/redux/history/history_state.dart';
import 'package:redux/redux.dart';

final historyReducer = combineReducers<HistoryState>([
  TypedReducer<HistoryState, HistoryClearAction>(
    (state, action) => [],
  ),
  TypedReducer<HistoryState, HistoryRemoveAction>(
      (state, action) => List<String>.from(state)..remove(action.string)),
  TypedReducer<HistoryState, HistoryAddAction>(
    (state, action) => List<String>.from(state)
      ..remove(action.string)
      ..insert(0, action.string),
  ),
]);
