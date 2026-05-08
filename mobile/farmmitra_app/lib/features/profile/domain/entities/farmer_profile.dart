final class FarmerProfile {
  const FarmerProfile({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.village,
    required this.district,
    required this.stateName,
    required this.farmType,
    required this.landSize,
    required this.preferredCrops,
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
  final String farmType;
  final double landSize;
  final List<String> preferredCrops;
  final String? photoPath;
  final double? latitude;
  final double? longitude;
  final bool needsSync;
  final DateTime createdAt;
  final DateTime updatedAt;

  FarmerProfile copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? village,
    String? district,
    String? stateName,
    String? farmType,
    double? landSize,
    List<String>? preferredCrops,
    String? photoPath,
    double? latitude,
    double? longitude,
    bool? needsSync,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FarmerProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      village: village ?? this.village,
      district: district ?? this.district,
      stateName: stateName ?? this.stateName,
      farmType: farmType ?? this.farmType,
      landSize: landSize ?? this.landSize,
      preferredCrops: preferredCrops ?? this.preferredCrops,
      photoPath: photoPath ?? this.photoPath,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      needsSync: needsSync ?? this.needsSync,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
