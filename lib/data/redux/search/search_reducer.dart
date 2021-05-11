import 'package:places/data/redux/search/search_action.dart';
import 'package:places/data/redux/search/search_state.dart';
import 'package:redux/redux.dart';

final searchReducer = combineReducers<SearchState>([
  TypedReducer<SearchState, SearchStringAction>(
    (state, action) => action.searchString.isEmpty
        ? SearchNoSearchState()
        : SearchLoadingState(),
  ),
  TypedReducer<SearchState, SearchErrorAction>(
    (state, action) => SearchErrorState(),
  ),
  TypedReducer<SearchState, SearchResultAction>(
    (state, action) => action.places.length > 0
        ? SearchResultState(action.places)
        : SearchNotFoundState(),
  ),
]);
