import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  int currentPage = 0;

  void setPage(int index) {
    currentPage = index;
  }

    Future<void> logout() async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove("user");
  }
}
//a