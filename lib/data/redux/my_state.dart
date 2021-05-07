import 'package:places/data/redux/history/history_state.dart';
import 'package:places/data/redux/search/search_state.dart';

class MyState {
  final SearchState searchState;
  final HistoryState history;

  MyState(this.searchState, this.history);

  MyState.initial()
      : searchState = SearchNoSearchState(),
        history = [];
}
