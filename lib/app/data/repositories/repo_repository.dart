import 'package:get/get.dart';
import 'package:test_ambar/app/data/models/repositoy_model.dart';
import 'package:test_ambar/app/data/providers/repo_api.dart';

class RepoRepository {
  final RepoApi _api = Get.find<RepoApi>();
  Future<List<RepositoryModel>> getListRepositories() {
    return _api.getListRepositories();
  }
}
