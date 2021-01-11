import 'package:get/get.dart';
import 'package:test_ambar/app/data/providers/repo_api.dart';
import 'package:test_ambar/app/data/repositories/repo_repository.dart';
import 'package:test_ambar/app/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(RepoApi(), permanent: true);
    Get.put(RepoRepository(), permanent: true);
  }
}
