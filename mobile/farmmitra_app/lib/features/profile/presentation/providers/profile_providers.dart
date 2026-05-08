import 'package:farmmitra_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:farmmitra_app/features/profile/presentation/controllers/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:farmmitra_app/features/profile/presentation/providers/profile_dependencies.dart';

final profileControllerProvider =
    NotifierProvider<ProfileController, ProfileState>(ProfileController.new);
