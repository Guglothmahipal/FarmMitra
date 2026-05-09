import 'package:farmmitra_app/features/jobs/presentation/controllers/jobs_controller.dart';
import 'package:farmmitra_app/features/jobs/presentation/controllers/jobs_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:farmmitra_app/features/jobs/presentation/providers/jobs_dependencies.dart';

final jobsControllerProvider = NotifierProvider<JobsController, JobsState>(
  JobsController.new,
);
