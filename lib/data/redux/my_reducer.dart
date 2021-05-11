import 'package:places/data/redux/history/history_reducer.dart';
import 'package:places/data/redux/my_state.dart';
import 'package:places/data/redux/search/search_reducer.dart';

MyState myReducer(MyState state, action) => MyState(
      searchReducer(state.searchState, action),
      historyReducer(state.history, action),
    );
