import 'package:places/data/redux/search/search_state.dart';

class MyState {
  final SearchState searchState;

  MyState._(this.searchState);

  MyState.initial() : searchState = SearchNoSearchState();

  MyState copyWith({
    SearchState? searchState,
  }) =>
      MyState._(
        searchState ?? this.searchState,
      );
}
