import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/farm_job.dart';
import 'package:farmmitra_app/features/jobs/presentation/providers/jobs_providers.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/profile_section_card.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/profile_text_form_field.dart';
import 'package:farmmitra_app/shared/widgets/app_error_message.dart';
import 'package:farmmitra_app/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JobFormPage extends ConsumerStatefulWidget {
  const JobFormPage({this.jobId, super.key});

  final String? jobId;

  @override
  ConsumerState<JobFormPage> createState() => _JobFormPageState();
}

class _JobFormPageState extends ConsumerState<JobFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _workTypeController = TextEditingController();
  final _notesController = TextEditingController();
  final _wageController = TextEditingController();
  final _workersController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime _workDate = DateTime.now().add(const Duration(days: 1));
  bool _hydrated = false;

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _workTypeController.dispose();
    _notesController.dispose();
    _wageController.dispose();
    _workersController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobsState = ref.watch(jobsControllerProvider);
    _hydrateOnce(jobsState.jobs);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jobId == null ? 'Create Job' : 'Edit Job'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ProfileSectionCard(
                title: 'Work details',
                icon: Icons.assignment_outlined,
                child: Column(
                  children: [
                    ProfileTextFormField(
                      controller: _titleController,
                      label: 'Job title',
                      hintText: 'Cotton harvesting workers needed',
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextFormField(
                      controller: _categoryController,
                      label: 'Category',
                      hintText: 'Harvesting, sowing, irrigation',
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextFormField(
                      controller: _descriptionController,
                      label: 'Description',
                      hintText: 'Describe timing, work, and any notes',
                      maxLines: 3,
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextFormField(
                      controller: _workTypeController,
                      label: 'Crop / work type',
                      hintText: 'Harvesting, sowing, irrigation',
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextFormField(
                      controller: _notesController,
                      label: 'Notes',
                      hintText: 'Tools, start time, food, transport',
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ProfileSectionCard(
                title: 'Wage and schedule',
                icon: Icons.currency_rupee,
                child: Column(
                  children: [
                    ProfileTextFormField(
                      controller: _wageController,
                      label: 'Daily wage',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: _positiveInt,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextFormField(
                      controller: _workersController,
                      label: 'Workers required',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: _positiveInt,
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.event),
                      title: Text(
                        'Work date: ${_workDate.day}/${_workDate.month}/${_workDate.year}',
                      ),
                      trailing: const Icon(Icons.edit_calendar),
                      onTap: _pickDate,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ProfileSectionCard(
                title: 'Location',
                icon: Icons.location_on_outlined,
                child: ProfileTextFormField(
                  controller: _locationController,
                  label: 'Village / work location',
                  validator: _required,
                ),
              ),
              if (jobsState.errorMessage != null) ...[
                const SizedBox(height: 12),
                AppErrorMessage(message: jobsState.errorMessage!),
              ],
              const SizedBox(height: 20),
              AppPrimaryButton(
                label: widget.jobId == null ? 'Post Job' : 'Save Job',
                icon: Icons.save_outlined,
                isLoading: jobsState.isSaving,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _hydrateOnce(List<FarmJob> jobs) {
    if (_hydrated || widget.jobId == null) {
      _hydrated = true;
      return;
    }

    FarmJob? job;
    for (final item in jobs) {
      if (item.id == widget.jobId) {
        job = item;
        break;
      }
    }
    if (job != null) {
      _titleController.text = job.title;
      _categoryController.text = job.category;
      _descriptionController.text = job.description;
      _workTypeController.text = job.workType;
      _notesController.text = job.notes ?? '';
      _wageController.text = job.wage.toString();
      _workersController.text = job.workersRequired.toString();
      _locationController.text = job.location;
      _workDate = job.workDate;
    }
    _hydrated = true;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _workDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() => _workDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final saved = await ref
        .read(jobsControllerProvider.notifier)
        .saveJob(
          existingJobId: widget.jobId,
          title: _titleController.text.trim(),
          category: _categoryController.text.trim(),
          description: _descriptionController.text.trim(),
          workType: _workTypeController.text.trim(),
          notes: _notesController.text.trim(),
          wage: int.parse(_wageController.text.trim()),
          workersRequired: int.parse(_workersController.text.trim()),
          workDate: _workDate,
          location: _locationController.text.trim(),
        );

    if (saved && mounted) {
      context.go(AppRoutes.jobs);
    }
  }
}

String? _required(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Required';
  }
  return null;
}

String? _positiveInt(String? value) {
  final number = int.tryParse(value?.trim() ?? '');
  if (number == null || number <= 0) {
    return 'Enter a valid number';
  }
  return null;
}
