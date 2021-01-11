import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_ambar/app/data/models/repositoy_model.dart';
import 'package:test_ambar/app/modules/home/controllers/home_controller.dart';
import 'package:test_ambar/app/modules/home/views/widgets/home_widgets.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: <Widget>[
            buildBackGround(),
            Stack(
              children: [
                SmartRefresher(
                  key: controller.refresherKey,
                  controller: controller.refreshController,
                  enablePullUp: false,
                  child: CustomScrollView(
                    controller: controller.scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        floating: true,
                        title: FittedBox(
                          child: Text('First 100 github repositories'),
                        ),
                        backgroundColor: Colors.transparent,
                        actions: <Widget>[
                          IconButton(
                            tooltip: 'Pesquisar',
                            icon: const Icon(Icons.search),
                            onPressed: () async {
                              controller.search(context);
                            },
                          ),
                          IconButton(
                            tooltip: 'Atualizar',
                            icon: const Icon(Icons.refresh),
                            onPressed: () async {
                              controller.loadRepo(false);
                            },
                          ),
                        ],
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int i) {
                            final RepositoryModel lista = controller.lista[i];
                            return Stack(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 24.0,
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      card(lista, controller.share),
                                      avatarName(lista),
                                      // avatarName(lista),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                          childCount: controller.lista.length,
                        ),
                      )
                    ],
                  ),
                  physics: BouncingScrollPhysics(),
                  onRefresh: () async {
                    await controller
                        .loadRepo(controller.refreshController.isRefresh);
                    controller.refreshController.refreshCompleted();
                  },
                ),
                if (controller.isLoading.value)
                  Center(child: CircularProgressIndicator()),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: controller.isVisible.value ? 50 : 0.0,
          child: BottomAppBar(
            elevation: 8,
            color: Color.fromARGB(255, 197, 202, 233),
            child: InkWell(
              child: Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Go to Top",
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () async {
                await controller.scrollController.animateTo(0.00,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut);
                controller.isVisible.value = false;
              },
            ),
          ),
        ),
      ),
    );
  }
}
