import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:test_ambar/app/data/models/repositoy_model.dart';

class RepoApi {
  final Dio _dio = Get.find<Dio>();
  Future<List<RepositoryModel>> getListRepositories() async {
    List<RepositoryModel> loadedRespositories = [];
    Response response = await _dio.get(
      '/repositories',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'accept': 'application/vnd.github.v3+json'
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> dados = response.data;

      for (var i = 0; i < dados.length; i++) {
        loadedRespositories.add(
          RepositoryModel.fromJson(dados[i]),
        );
      }
      return loadedRespositories;
    } else
      return [];
  }
}
