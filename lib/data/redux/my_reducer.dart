import 'package:places/data/redux/my_state.dart';
import 'package:places/data/redux/search/search_action.dart';
import 'package:places/data/redux/search/search_reducer.dart';
import 'package:redux/redux.dart';

final myReducer = combineReducers<MyState>([
  TypedReducer<MyState, SearchAction>(
    (state, action) =>
        state.copyWith(searchState: searchReducer(state.searchState, action)),
  ),
]);
