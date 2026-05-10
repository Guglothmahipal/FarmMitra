final class FarmerWorkerProfile {
  const FarmerWorkerProfile({
    required this.id,
    required this.name,
    required this.village,
    required this.distance,
    required this.primarySkill,
    required this.skills,
    required this.rating,
    required this.isVerified,
    required this.isAvailable,
    required this.experience,
    required this.joinedDate,
    required this.completedJobs,
    required this.trustScore,
    required this.languages,
  });

  final String id;
  final String name;
  final String village;
  final String distance;
  final String primarySkill;
  final List<String> skills;
  final double rating;
  final bool isVerified;
  final bool isAvailable;
  final String experience;
  final String joinedDate;
  final int completedJobs;
  final int trustScore;
  final List<String> languages;
}
