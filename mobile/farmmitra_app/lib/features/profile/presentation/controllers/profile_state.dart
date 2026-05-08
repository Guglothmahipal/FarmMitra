import 'package:farmmitra_app/features/profile/domain/entities/profile_snapshot.dart';

enum ProfileStatus { checking, missing, ready }

final class ProfileState {
  const ProfileState({
    required this.status,
    required this.isSaving,
    this.profile,
    this.errorMessage,
  });

  const ProfileState.checking()
    : status = ProfileStatus.checking,
      isSaving = false,
      profile = null,
      errorMessage = null;

  final ProfileStatus status;
  final bool isSaving;
  final ProfileSnapshot? profile;
  final String? errorMessage;

  bool get hasCompletedProfile => status == ProfileStatus.ready;

  ProfileState copyWith({
    ProfileStatus? status,
    bool? isSaving,
    ProfileSnapshot? profile,
    String? errorMessage,
    bool clearProfile = false,
    bool clearError = false,
  }) {
    return ProfileState(
      status: status ?? this.status,
      isSaving: isSaving ?? this.isSaving,
      profile: clearProfile ? null : profile ?? this.profile,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
