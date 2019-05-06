import 'package:flutter/material.dart';
import './route_handler.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static String root = '/';
  static String detailPage = '/detail';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ROUTE WAS NOT FOUNDED');
    });
    router.define(detailPage, handler: detailHandler);
  }
}
