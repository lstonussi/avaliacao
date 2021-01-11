import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_ambar/app/data/models/repositoy_model.dart';
import 'package:test_ambar/app/data/repositories/repo_repository.dart';
import 'package:test_ambar/app/modules/global_widgets/global_dialogs.dart';
import 'package:test_ambar/app/modules/home/views/widgets/search_delegate.dart';

class HomeController extends GetxController {
  RepoRepository repoRepository = Get.find<RepoRepository>();

  final RxBool isLoading = false.obs;
  final RxBool isVisible = false.obs;
  final RxList<RepositoryModel> lista = <RepositoryModel>[].obs;

  ScrollController scrollController;
  List<RepositoryModel> _listaApi;
  List<String> sugestion;
  List<String> sugestions = new List<String>();
  MySearchDelegate delegate;
  GlobalKey contentKey = GlobalKey();
  GlobalKey refresherKey = GlobalKey();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onReady() async {
    super.onReady();
    await loadRepo(false);
    scrollController = new ScrollController();
    scrollController.addListener(
      () {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          isVisible.value = false;
        }
        if (scrollController.position.userScrollDirection ==
                ScrollDirection.forward &&
            scrollController.position.pixels > 10) {
          isVisible.value = true;
        }
        if (scrollController.position.pixels < 10) {
          isVisible.value = false;
        }
      },
    );
  }

  Future loadRepo(bool autoLoad) async {
    if (!autoLoad) isLoading.value = true;
    try {
      _listaApi = await repoRepository.getListRepositories();
      if (_listaApi.length == 0) {
        isLoading.value = false;
        showErroDialog('Nenhum repositório encontrado.', reTry);
      } else
        lista.assignAll(_listaApi);
    } catch (e) {
      showErroDialog('Algo deu errado.\n${e.error}', reTry);
    }

    isLoading.value = false;
  }

  void reTry() async {
    Get.back();
    await loadRepo(false);
  }

  filter(String s) {
    final listaTmp = lista.where((f) => f.name.startsWith(s)).toList();
    lista.assignAll(listaTmp);
  }

  getSugestions() {
    if (sugestions.length == 0) {
      lista.forEach((element) {
        sugestions.add(element.name);
      });
      sugestion = sugestions;
    }
  }

  Future<void> share(
    String link,
  ) async {
    await FlutterShare.share(
        title: 'Repositório Github.',
        text: 'Olha esse repositório, muito interessante.',
        linkUrl: link,
        chooserTitle: 'Example Chooser Title');
  }

  void search(BuildContext ctx) async {
    await getSugestions();
    delegate = MySearchDelegate(sugestion);
    final String selected = await showSearch<String>(
      context: ctx,
      delegate: delegate,
    );
    if (selected != null) {
      filter(selected);
    }
  }

  void teste() {
    isVisible.value = true;
    final _hideButtonController = new ScrollController();
    _hideButtonController.addListener(
      () {
        print("listener");
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          isVisible.value = false;
        }
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          isVisible.value = true;
        }
      },
    );
  }
}
