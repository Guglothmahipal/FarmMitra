import 'package:farmmitra_app/features/home/domain/entities/architecture_status.dart';

abstract interface class HomeRepository {
  Future<ArchitectureStatus> loadArchitectureStatus();
}
