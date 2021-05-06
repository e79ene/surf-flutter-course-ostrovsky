import 'package:places/data/redux/search/search_middleware.dart';
import 'package:places/data/redux/search/search_reducer.dart';
import 'package:places/data/redux/search/search_state.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/store/place_store.dart';
import 'package:redux/redux.dart';

typedef MyState = SearchState;

class MyReduxStore extends Store<MyState> {
  MyReduxStore(PlaceRepository repo, PlaceStore mobxStore)
      : super(
          searchReducer,
          initialState: SearchNoSearchState(),
          middleware: [
            SearchMiddleware(repo, mobxStore),
          ],
        );
}
