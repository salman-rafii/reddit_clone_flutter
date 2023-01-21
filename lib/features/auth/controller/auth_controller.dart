import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/core/utils.dart';
import 'package:reddit_clone_flutter/features/auth/repository/auth_repository.dart';
import 'package:reddit_clone_flutter/models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = Provider(
  (ref) => AuthController(
      authRepository: ref.read(authRepositoryProvider), ref: ref),
);

class AuthController {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref;

  void signInWithGoogle(BuildContext context) async {
    final user = await _authRepository.signInWithGoogle();
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) => _ref.read(userProvider.notifier).update(
            (state) => userModel,
          ),
    );
  }
}
