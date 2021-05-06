import 'package:places/data/redux/my_reducer.dart';
import 'package:places/data/redux/my_state.dart';
import 'package:places/data/redux/search/search_middleware.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/store/place_store.dart';
import 'package:redux/redux.dart';

class MyReduxStore extends Store<MyState> {
  MyReduxStore(PlaceRepository repo, PlaceStore mobxStore)
      : super(
          myReducer,
          initialState: MyState.initial(),
          middleware: [
            SearchMiddleware(repo, mobxStore),
          ],
        );
}
