import 'package:places/data/redux/my_state.dart';
import 'package:places/data/redux/search/search_action.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/store/place_store.dart';
import 'package:redux/redux.dart';

class SearchMiddleware implements MiddlewareClass<MyState> {
  final PlaceRepository repo;
  final PlaceStore mobxStore;

  SearchMiddleware(this.repo, this.mobxStore);

  @override
  call(Store<MyState> store, action, NextDispatcher next) {
    if (action is SearchStringAction) {
      if (action.searchString.isNotEmpty) _search(store, action.searchString);
    }

    next(action);
  }

  void _search(Store<MyState> store, String searchString) async {
    try {
      final places = await repo.getFiltered(
        center: mobxStore.myLocation,
        radius: mobxStore.radius,
        categories: mobxStore.categories,
        nameFilter: searchString,
      );

      store.dispatch(SearchResultAction(places));
    } catch (e) {
      store.dispatch(SearchErrorAction(e));
    }
  }
}
