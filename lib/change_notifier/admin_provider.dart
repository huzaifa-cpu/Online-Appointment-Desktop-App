import 'package:flutter/cupertino.dart';
import 'package:side_hospital_desktop_app/models/admin.dart';

class AdminProvider extends ChangeNotifier {
  List<Admin> _admin = [
    Admin(
      id: null,
      email: null,
      password: null,
    )
  ];

  List<Admin> get admin => _admin;

  set admin(List<Admin> value) {
    _admin = value;
    notifyListeners();
  }

  void addAdmin(Admin value) {
    _admin.add(value);
    notifyListeners();
  }
}
