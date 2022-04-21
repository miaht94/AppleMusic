
import 'package:apple_music/models/UserModel.dart';

class CurrentUserManager{

  late UserModel _currentUser;

  CurrentUserManager(){
  }

  UserModel getCurrentUser() {
    return _currentUser;
  }

  void setCurrentUser(UserModel userModel) {
    _currentUser = userModel;
  }


}