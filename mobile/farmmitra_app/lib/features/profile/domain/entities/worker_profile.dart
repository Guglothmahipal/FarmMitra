final class WorkerProfile {
  const WorkerProfile({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.village,
    required this.district,
    required this.stateName,
    required this.skills,
    required this.yearsOfExperience,
    required this.dailyWageExpectation,
    required this.isAvailable,
    required this.needsSync,
    required this.createdAt,
    required this.updatedAt,
    this.photoPath,
    this.latitude,
    this.longitude,
  });

  final String id;
  final String fullName;
  final String phoneNumber;
  final String village;
  final String district;
  final String stateName;
  final List<String> skills;
  final int yearsOfExperience;
  final int dailyWageExpectation;
  final bool isAvailable;
  final String? photoPath;
  final double? latitude;
  final double? longitude;
  final bool needsSync;
  final DateTime createdAt;
  final DateTime updatedAt;

  WorkerProfile copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? village,
    String? district,
    String? stateName,
    List<String>? skills,
    int? yearsOfExperience,
    int? dailyWageExpectation,
    bool? isAvailable,
    String? photoPath,
    double? latitude,
    double? longitude,
    bool? needsSync,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkerProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      village: village ?? this.village,
      district: district ?? this.district,
      stateName: stateName ?? this.stateName,
      skills: skills ?? this.skills,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      dailyWageExpectation: dailyWageExpectation ?? this.dailyWageExpectation,
      isAvailable: isAvailable ?? this.isAvailable,
      photoPath: photoPath ?? this.photoPath,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      needsSync: needsSync ?? this.needsSync,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
