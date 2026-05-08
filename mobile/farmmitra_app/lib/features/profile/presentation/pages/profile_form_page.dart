import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/profile/domain/entities/farmer_profile.dart';
import 'package:farmmitra_app/features/profile/domain/entities/worker_profile.dart';
import 'package:farmmitra_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/profile_section_card.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/profile_text_form_field.dart';
import 'package:farmmitra_app/shared/widgets/app_error_message.dart';
import 'package:farmmitra_app/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileFormPage extends ConsumerStatefulWidget {
  const ProfileFormPage({required this.isEdit, super.key});

  final bool isEdit;

  @override
  ConsumerState<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends ConsumerState<ProfileFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _villageController = TextEditingController();
  final _districtController = TextEditingController();
  final _stateController = TextEditingController();
  final _farmTypeController = TextEditingController();
  final _landSizeController = TextEditingController();
  final _cropsController = TextEditingController();
  final _skillsController = TextEditingController();
  final _experienceController = TextEditingController();
  final _wageController = TextEditingController();
  bool _isAvailable = true;
  bool _hydrated = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _villageController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _farmTypeController.dispose();
    _landSizeController.dispose();
    _cropsController.dispose();
    _skillsController.dispose();
    _experienceController.dispose();
    _wageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final profileState = ref.watch(profileControllerProvider);
    final role = authState.selectedRole;

    if (role == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    _hydrateOnce(role, authState.phoneNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit profile' : 'Complete profile'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                role == UserRole.farmer
                    ? 'Tell workers about your farm'
                    : 'Tell farmers about your work',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'These details stay available offline and will sync when backend profile APIs are connected.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ProfileSectionCard(
                title: 'Basic details',
                icon: Icons.person_outline,
                child: Column(
                  children: [
                    ProfileTextFormField(
                      controller: _fullNameController,
                      label: 'Full name',
                      prefixIcon: Icons.badge_outlined,
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextFormField(
                      controller: _phoneController,
                      label: 'Phone number',
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: _phoneValidator,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ProfileSectionCard(
                title: 'Location',
                icon: Icons.location_on_outlined,
                child: Column(
                  children: [
                    ProfileTextFormField(
                      controller: _villageController,
                      label: 'Village / town',
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextFormField(
                      controller: _districtController,
                      label: 'District',
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextFormField(
                      controller: _stateController,
                      label: 'State',
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.my_location),
                      label: const Text('GPS location placeholder'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              if (role == UserRole.farmer)
                _FarmerFields(
                  farmTypeController: _farmTypeController,
                  landSizeController: _landSizeController,
                  cropsController: _cropsController,
                )
              else
                _WorkerFields(
                  skillsController: _skillsController,
                  experienceController: _experienceController,
                  wageController: _wageController,
                  isAvailable: _isAvailable,
                  onAvailabilityChanged: (value) {
                    setState(() => _isAvailable = value);
                  },
                ),
              const SizedBox(height: 12),
              ProfileSectionCard(
                title: 'Profile photo',
                icon: Icons.photo_camera_outlined,
                child: OutlinedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.account_circle_outlined),
                  label: const Text('Photo placeholder'),
                ),
              ),
              if (profileState.errorMessage != null) ...[
                const SizedBox(height: 12),
                AppErrorMessage(message: profileState.errorMessage!),
              ],
              const SizedBox(height: 20),
              AppPrimaryButton(
                label: widget.isEdit ? 'Save changes' : 'Save profile',
                icon: Icons.save_outlined,
                isLoading: profileState.isSaving,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _hydrateOnce(UserRole role, String? phoneNumber) {
    if (_hydrated) {
      return;
    }

    final profile = ref.read(profileControllerProvider).profile;
    _phoneController.text = phoneNumber ?? '';

    if (role == UserRole.farmer) {
      final farmer = profile?.farmer;
      if (farmer != null) {
        _hydrateFarmer(farmer);
      }
    } else {
      final worker = profile?.worker;
      if (worker != null) {
        _hydrateWorker(worker);
      }
    }

    _hydrated = true;
  }

  void _hydrateFarmer(FarmerProfile profile) {
    _fullNameController.text = profile.fullName;
    _phoneController.text = profile.phoneNumber;
    _villageController.text = profile.village;
    _districtController.text = profile.district;
    _stateController.text = profile.stateName;
    _farmTypeController.text = profile.farmType;
    _landSizeController.text = profile.landSize.toString();
    _cropsController.text = profile.preferredCrops.join(', ');
  }

  void _hydrateWorker(WorkerProfile profile) {
    _fullNameController.text = profile.fullName;
    _phoneController.text = profile.phoneNumber;
    _villageController.text = profile.village;
    _districtController.text = profile.district;
    _stateController.text = profile.stateName;
    _skillsController.text = profile.skills.join(', ');
    _experienceController.text = profile.yearsOfExperience.toString();
    _wageController.text = profile.dailyWageExpectation.toString();
    _isAvailable = profile.isAvailable;
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final role = ref.read(authControllerProvider).selectedRole;
    if (role == null) {
      return;
    }

    final controller = ref.read(profileControllerProvider.notifier);
    final saved = role == UserRole.farmer
        ? await controller.saveFarmerProfile(
            fullName: _fullNameController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            village: _villageController.text.trim(),
            district: _districtController.text.trim(),
            stateName: _stateController.text.trim(),
            farmType: _farmTypeController.text.trim(),
            landSize: double.parse(_landSizeController.text.trim()),
            preferredCrops: _splitTags(_cropsController.text),
          )
        : await controller.saveWorkerProfile(
            fullName: _fullNameController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            village: _villageController.text.trim(),
            district: _districtController.text.trim(),
            stateName: _stateController.text.trim(),
            skills: _splitTags(_skillsController.text),
            yearsOfExperience: int.parse(_experienceController.text.trim()),
            dailyWageExpectation: int.parse(_wageController.text.trim()),
            isAvailable: _isAvailable,
          );

    if (saved && mounted) {
      context.go(AppRoutes.home);
    }
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.length != 10) {
      return 'Enter a 10-digit mobile number';
    }
    return null;
  }

  List<String> _splitTags(String value) {
    return value
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }
}

class _FarmerFields extends StatelessWidget {
  const _FarmerFields({
    required this.farmTypeController,
    required this.landSizeController,
    required this.cropsController,
  });

  final TextEditingController farmTypeController;
  final TextEditingController landSizeController;
  final TextEditingController cropsController;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Farm details',
      icon: Icons.grass_outlined,
      child: Column(
        children: [
          ProfileTextFormField(
            controller: farmTypeController,
            label: 'Farm type',
            hintText: 'Irrigated, dryland, mixed',
            validator: _required,
          ),
          const SizedBox(height: 12),
          ProfileTextFormField(
            controller: landSizeController,
            label: 'Land size',
            hintText: 'Acres',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            validator: _positiveNumber,
          ),
          const SizedBox(height: 12),
          ProfileTextFormField(
            controller: cropsController,
            label: 'Preferred crops',
            hintText: 'Cotton, wheat, soybean',
            validator: _required,
          ),
        ],
      ),
    );
  }
}

class _WorkerFields extends StatelessWidget {
  const _WorkerFields({
    required this.skillsController,
    required this.experienceController,
    required this.wageController,
    required this.isAvailable,
    required this.onAvailabilityChanged,
  });

  final TextEditingController skillsController;
  final TextEditingController experienceController;
  final TextEditingController wageController;
  final bool isAvailable;
  final ValueChanged<bool> onAvailabilityChanged;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Work details',
      icon: Icons.handyman_outlined,
      child: Column(
        children: [
          ProfileTextFormField(
            controller: skillsController,
            label: 'Skills',
            hintText: 'Harvesting, sowing, irrigation',
            validator: _required,
          ),
          const SizedBox(height: 12),
          ProfileTextFormField(
            controller: experienceController,
            label: 'Years of experience',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: _wholeNumber,
          ),
          const SizedBox(height: 12),
          ProfileTextFormField(
            controller: wageController,
            label: 'Daily wage expectation',
            hintText: 'Rupees per day',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: _wholeNumber,
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Available for work'),
            value: isAvailable,
            onChanged: onAvailabilityChanged,
          ),
        ],
      ),
    );
  }
}

String? _required(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Required';
  }
  return null;
}

String? _positiveNumber(String? value) {
  final number = double.tryParse(value?.trim() ?? '');
  if (number == null || number <= 0) {
    return 'Enter a valid number';
  }
  return null;
}

String? _wholeNumber(String? value) {
  final number = int.tryParse(value?.trim() ?? '');
  if (number == null || number < 0) {
    return 'Enter a valid number';
  }
  return null;
}
