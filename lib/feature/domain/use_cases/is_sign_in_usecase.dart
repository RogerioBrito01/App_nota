
import 'package:mynote/feature/domain/repositories/firebase_repository.dart';

class IsSignInUseCase {

  final FirebaseRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call()async{
    return repository.isSignIn();
  }
}