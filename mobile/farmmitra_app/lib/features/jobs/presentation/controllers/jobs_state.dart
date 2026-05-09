import 'package:farmmitra_app/features/jobs/domain/entities/farm_job.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/job_application.dart';

final class JobsState {
  const JobsState({
    required this.isLoading,
    required this.isSaving,
    required this.jobs,
    required this.applications,
    this.searchQuery = '',
    this.locationFilter = '',
    this.categoryFilter = '',
    this.minimumWage,
    this.openOnly = false,
    this.farmerStatusFilter,
    this.errorMessage,
  });

  const JobsState.initial()
    : isLoading = true,
      isSaving = false,
      jobs = const [],
      applications = const [],
      searchQuery = '',
      locationFilter = '',
      categoryFilter = '',
      minimumWage = null,
      openOnly = false,
      farmerStatusFilter = null,
      errorMessage = null;

  final bool isLoading;
  final bool isSaving;
  final List<FarmJob> jobs;
  final List<JobApplication> applications;
  final String searchQuery;
  final String locationFilter;
  final String categoryFilter;
  final int? minimumWage;
  final bool openOnly;
  final JobStatus? farmerStatusFilter;
  final String? errorMessage;

  int get openJobsCount => jobs.where((job) => job.isOpen).length;

  List<FarmJob> get filteredJobs {
    return jobs
        .where((job) {
          final query = searchQuery.toLowerCase().trim();
          final matchesQuery =
              query.isEmpty ||
              job.title.toLowerCase().contains(query) ||
              job.workType.toLowerCase().contains(query) ||
              job.category.toLowerCase().contains(query);
          final matchesLocation =
              locationFilter.trim().isEmpty ||
              job.location.toLowerCase().contains(locationFilter.toLowerCase());
          final matchesCategory =
              categoryFilter.trim().isEmpty ||
              job.category.toLowerCase().contains(categoryFilter.toLowerCase());
          final matchesWage = minimumWage == null || job.wage >= minimumWage!;
          final matchesOpen = !openOnly || job.canApply;
          final matchesFarmerStatus =
              farmerStatusFilter == null || job.status == farmerStatusFilter;

          return matchesQuery &&
              matchesLocation &&
              matchesCategory &&
              matchesWage &&
              matchesOpen &&
              matchesFarmerStatus;
        })
        .toList(growable: false);
  }

  JobsState copyWith({
    bool? isLoading,
    bool? isSaving,
    List<FarmJob>? jobs,
    List<JobApplication>? applications,
    String? searchQuery,
    String? locationFilter,
    String? categoryFilter,
    int? minimumWage,
    bool clearMinimumWage = false,
    bool? openOnly,
    JobStatus? farmerStatusFilter,
    bool clearFarmerStatusFilter = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return JobsState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      jobs: jobs ?? this.jobs,
      applications: applications ?? this.applications,
      searchQuery: searchQuery ?? this.searchQuery,
      locationFilter: locationFilter ?? this.locationFilter,
      categoryFilter: categoryFilter ?? this.categoryFilter,
      minimumWage: clearMinimumWage ? null : minimumWage ?? this.minimumWage,
      openOnly: openOnly ?? this.openOnly,
      farmerStatusFilter: clearFarmerStatusFilter
          ? null
          : farmerStatusFilter ?? this.farmerStatusFilter,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
