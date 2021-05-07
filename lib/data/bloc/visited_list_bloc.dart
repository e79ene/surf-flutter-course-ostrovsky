import 'package:places/data/bloc/place_list_bloc.dart';
import 'package:places/data/bloc/place_list_state.dart';

class VisitedListBloc extends PlaceListBloc {
  VisitedListBloc() : super(PlaceListState([]));
}
