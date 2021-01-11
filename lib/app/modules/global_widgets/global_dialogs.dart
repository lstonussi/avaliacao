import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErroDialog(String msg, Function reTry) {
  Get.defaultDialog(
    title: 'Ops..',
    radius: 5,
    content: Center(child: Text(msg)),
    cancel: FlatButton(
      child: Text('Tentar novamente'),
      onPressed: reTry,
    ),
    confirm: FlatButton(
      child: Text('Confirmar'),
      onPressed: () {
        Get.back();
      },
    ),
  );
}
