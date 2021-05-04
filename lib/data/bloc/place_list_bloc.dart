import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/bloc/place_list_event.dart';
import 'package:places/data/bloc/place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  PlaceListBloc(PlaceListState initialState) : super(initialState);

  @override
  Stream<PlaceListState> mapEventToState(PlaceListEvent event) async* {
    if (event is TogglePlaceListEvent) {
      final place = event.place;

      if (state.list.contains(place))
        yield PlaceListState(state.list.toList()..remove(place));
      else
        yield PlaceListState(state.list.toList()..insert(0, place));
    } else {
      throw UnsupportedError('Unsupported event: $event');
    }
  }
}
