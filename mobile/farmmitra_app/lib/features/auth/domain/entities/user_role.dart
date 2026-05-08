enum UserRole {
  farmer,
  worker;

  String get label {
    return switch (this) {
      UserRole.farmer => 'Farmer',
      UserRole.worker => 'Worker',
    };
  }

  String get description {
    return switch (this) {
      UserRole.farmer => 'Post farm work and find nearby agricultural labour.',
      UserRole.worker => 'Find local farm jobs and manage your availability.',
    };
  }

  static UserRole? fromStorageValue(String? value) {
    if (value == null) {
      return null;
    }

    for (final role in UserRole.values) {
      if (role.name == value) {
        return role;
      }
    }

    return null;
  }
}
