import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/features/auth/auth.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final storageService = ref.watch(storageServiceProvider);
    return AuthRepositoryImpl(firebaseAuth, storageService);
  },
);

abstract class AuthRepository {
  ///[loginWithCreds] login user with provided creds
  Future<Either<UserModel, Failure>> loginWithCreds({
    required String email,
    required String password,
  });

  ///[signupWithCreds] register user with provided creds
  Future<Either<UserModel, Failure>> signupWithCreds({
    required String email,
    required String password,
  });

  /// [loginWithSocialAuth] login user with google account
  Future<Either<UserModel, Failure>> loginWithSocialAuth({
    required SocialAuthType socialAuthType,
  });

  /// [logout] login user with google account
  Future<Either<bool, Failure>> logout();
}
