import 'package:cinemapedia/infraestructure/datasources/drift_datasource.dart';
import 'package:cinemapedia/infraestructure/repositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(DriftDatasource());
});
