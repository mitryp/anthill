import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/page_title.dart';
import '../../../../shared/widgets.dart';
import '../../../auth/auth_module.dart';
import '../../application/providers/user_controller_provider.dart';
import '../../domain/constraints/user_role.dart';
import '../../domain/dtos/user_create_dto.dart';
import '../../domain/dtos/user_read_dto.dart';

class UserEditor extends ConsumerStatefulWidget {
  final UserReadDto? _readDto;

  const UserEditor({UserReadDto? userToEdit, super.key}) : _readDto = userToEdit;

  static Widget pageBuilder(BuildContext context, GoRouterState state) {
    final extra = state.extra;
    final toEdit = extra is UserReadDto ? extra : null;

    return PageTitle(
      title: toEdit != null ? 'Edit user' : 'Create user',
      child: VisibleFor(
        roles: const {UserRole.admin},
        unauthorizedPlaceholder: Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text('You are not authorized to see this page'),
          ),
        ),
        child: UserEditor(userToEdit: toEdit),
      ),
    );
  }

  @override
  ConsumerState<UserEditor> createState() => _UserEditorState();
}

class _UserEditorState extends ConsumerState<UserEditor> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool get _isEditing => widget._readDto != null;

  late bool _isEditingPassword = false;

  late UserCreateDto _dto = widget._readDto?.toCreateDto() ??
      const UserCreateDto(
        name: '',
        email: '',
        role: UserRole.volunteer,
        password: '',
      );

  void _onNameChanged(String name) => setState(() => _dto = _dto.copyWith(name: name));

  void _onEmailChanged(String email) => setState(() => _dto = _dto.copyWith(email: email));

  void _onRoleChanged(UserRole? role) {
    if (role == null) return;
    setState(() => _dto = _dto.copyWith(role: role));
  }

  void _onPasswordChanged(String password) =>
      setState(() => _dto = _dto.copyWith(password: password));

  Future<void> _saveUser() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final existingUser = widget._readDto;
    final isEditing = existingUser != null;

    final controller = ref.read(userControllerProvider.notifier);

    if (isEditing) {
      final dto = !_isEditingPassword ? _dto.copyWith(password: null) : _dto;
      await controller.updateResource(existingUser.id, dto, context);
    } else {
      await controller.createResource(_dto, context);
    }

    if (mounted && context.canPop()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final UserCreateDto(:name, :email, :role, :password) = _dto;

    final roleItems = UserRole.values
        .map(
          (role) => DropdownMenuItem<UserRole>(
            value: role,
            child: Text(role.name),
          ),
        )
        .toList(growable: false);

    final passwordField = TextFormField(
      validator: _isEditingPassword
          ? isPassword(
              context,
              minLength: 8,
              minLowercase: 1,
              minUppercase: 1,
              minNumbers: 1,
            )
          : null,
      initialValue: password,
      obscureText: true,
      enabled: _isEditingPassword || !_isEditing,
      onChanged: _onPasswordChanged,
      decoration: InputDecoration(
        labelText: 'Password',
        border: _isEditing && _isEditingPassword ? const OutlineInputBorder() : null,
      ),
    );

    final formFields = [
      TextFormField(
        autofocus: name.isEmpty,
        validator: isRequired(context),
        initialValue: name,
        onChanged: _onNameChanged,
        decoration: const InputDecoration(labelText: 'Name'),
      ),
      TextFormField(
        validator: ValidationBuilder(localeName: 'en').email().build(),
        initialValue: email,
        onChanged: _onEmailChanged,
        decoration: const InputDecoration(labelText: 'Email'),
      ),
      DropdownButtonFormField(
        value: role,
        items: roleItems,
        onChanged: _onRoleChanged,
        decoration: const InputDecoration(labelText: 'Role'),
      ),
      if (!_isEditing)
        passwordField
      else ...[
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Change password'),
            Checkbox(
              value: _isEditingPassword,
              onChanged: (value) =>
                  setState(() => _isEditingPassword = value ?? _isEditingPassword),
            ),
          ],
        ),
        passwordField,
      ],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing user'),
      ),
      floatingActionButton: ProgressIndicatorButton.icon(
        iconButtonBuilder: ElevatedButton.icon,
        onPressed: _saveUser,
        icon: const Icon(Icons.save),
        label: const Text('Save'),
      ),
      body: PageBody(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Padding(
              padding: defaultFormPadding,
              child: SizedBox(
                height: size.height * formHeightFraction,
                child: Column(
                  children: formFields,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension _ToCreateDto on UserReadDto {
  UserCreateDto toCreateDto() => UserCreateDto(
        name: name,
        email: email,
        role: role,
        password: '',
      );
}
