import 'dart:convert';

import 'package:places/data/model/category.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/dio.dart';

class PlaceRepository {
  Future<List<Place>> getFiltered({
    required GeoPosition center,
    required double radius,
    required Set<Category> categories,
    String? nameFilter,
  }) async {
    final response = await dio.post<List<dynamic>>(
      '/filtered_places',
      data: jsonEncode({
        'lat': center.lat,
        'lng': center.lng,
        'radius': radius,
        'typeFilter': categories.isEmpty
            ? Category.allIds
            : categories.map((c) => c.id).toList(),
        'nameFilter': nameFilter ?? '',
      }),
    );
    return response.data.toPlaceDtoList()..sort();
  }

  Future<Place> create(Place draft) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/place',
      data: jsonEncode({
        'lat': draft.geo.lat,
        'lng': draft.geo.lng,
        'name': draft.name,
        'urls': draft.urls,
        'placeType': draft.category.id,
        'description': draft.description,
      }),
    );
    print('DATA: ${response.data}');

    return _mapToPlace(response.data!);
  }

  Future<List<Place>> getAll() async {
    final response = await dio.get<List<dynamic>>('/place');
    return response.data.toPlaceList();
  }

  Future<Place> getById(int id) async {
    final response = await dio.get<Map<String, dynamic>>('/place/$id');
    return _mapToPlace(response.data!);
  }

  Future<void> deleteById(int id) async => dio.delete('/place/$id');

  Future<Place> update(Place place) async => throw UnimplementedError();
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

extension _ToPlaceList on List<dynamic>? {
  List<Place> toPlaceList() => toTypeList(_mapToPlace);
  List<PlaceDto> toPlaceDtoList() => toTypeList(_mapToPlaceDto);

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
