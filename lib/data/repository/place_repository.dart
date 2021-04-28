import 'package:places/data/model/category.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/back_end.dart';
import 'package:places/data/repository/endpoint.dart';

class PlaceRepository {
  Future<List<Place>> getFiltered({
    required GeoPosition center,
    required double radius,
    required Set<Category> categories,
    String? nameFilter,
  }) async {
    final response = await requestBackend(
      EndPoint.filtered_places,
      {
        'lat': center.lat,
        'lng': center.lng,
        'radius': radius,
        'typeFilter': categories.isEmpty
            ? Category.allIds
            : categories.map((c) => c.id).toList(),
        'nameFilter': nameFilter ?? '',
      },
    );

    return _toPlaceDtoList(response.data)..sort();
  }

  Future<Place> create(Place draft) async {
    final response = await requestBackend(
      EndPoint.POST_place,
      {
        'lat': draft.geo.lat,
        'lng': draft.geo.lng,
        'name': draft.name,
        'urls': draft.urls,
        'placeType': draft.category.id,
        'description': draft.description,
      },
    );
    print('DATA: ${response.data}');

    return _mapToPlace(response.data!);
  }

  Future<Place> getById(int id) async {
    final response = await requestBackend(EndPoint.getPlaceById(id));
    return _mapToPlace(response.data!);
  }

  Future<void> deleteById(int id) =>
      requestBackend(EndPoint.deletePlaceById(id));
}

Place _mapToPlace(Map<String, dynamic> map) => Place(
      id: map['id'],
      name: map['name'],
      geo: GeoPosition(map['lat'], map['lng']),
      urls: [for (final url in map['urls']) url as String],
      description: map['description'],
      category: Category.byId[map['placeType']]!,
    );

PlaceDto _mapToPlaceDto(Map<String, dynamic> map) => PlaceDto(
      id: map['id'],
      name: map['name'],
      geo: GeoPosition(map['lat'], map['lng']),
      urls: [for (final url in map['urls']) url as String],
      description: map['description'],
      category: Category.byId[map['placeType']]!,
      distance: map['distance'],
    );

List<PlaceDto> _toPlaceDtoList(dynamic data) =>
    (data as List<dynamic>).toTypeList(_mapToPlaceDto);

extension _ToPlaceList on List<dynamic>? {
  List<T> toTypeList<T>(T Function(Map<String, dynamic>) builder) => this!
      .cast<Map<String, dynamic>>()
      .map((map) {
        try {
          return builder(map);
        } catch (e) {
          return null;
        }
      })
      .whereType<T>()
      .toList();
}
