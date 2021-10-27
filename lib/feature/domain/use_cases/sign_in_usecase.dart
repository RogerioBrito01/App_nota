



import 'package:mynote/feature/domain/entities/user_entity.dart';
import 'package:mynote/feature/domain/repositories/firebase_repository.dart';

class SignInUseCase {

  final FirebaseRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(UserEntity user)async{
    return repository.signIn(user);
  }
}