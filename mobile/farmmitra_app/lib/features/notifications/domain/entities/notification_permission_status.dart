enum NotificationPermissionStatus {
  checking,
  notAsked,
  granted,
  denied;

  String get label => switch (this) {
    NotificationPermissionStatus.checking => 'Checking',
    NotificationPermissionStatus.notAsked => 'Not enabled',
    NotificationPermissionStatus.granted => 'Enabled',
    NotificationPermissionStatus.denied => 'Disabled',
  };

  static NotificationPermissionStatus fromValue(String? value) {
    return NotificationPermissionStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => NotificationPermissionStatus.notAsked,
    );
  }
}
