import 'package:places/data/bloc/place_list_bloc.dart';
import 'package:places/data/bloc/place_list_state.dart';

class FavoriteListBloc extends PlaceListBloc {
  FavoriteListBloc() : super(PlaceListState([]));
}
