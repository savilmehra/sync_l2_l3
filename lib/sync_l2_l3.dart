import 'dart:async';

import 'package:sync_l2_l3/products_response.dart';
import 'package:sync_l2_l3/sync_client_outbox.dart';

import 'objectbox.g.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

void startApplication() async {

  ObjectBoxSyncClient objectBoxSyncClient=ObjectBoxSyncClient();

  Box<Items>? productBox;
  Box<Items>? productBoxCLoud;
  SyncClient? syncClient=await  objectBoxSyncClient.setupL2();
  SyncClient? syncClient2=await  objectBoxSyncClient.setupL3();
  productBox = objectBoxSyncClient.productBox;
  productBoxCLoud = objectBoxSyncClient.productBoxCLoud;

  const oneSec = Duration(seconds: 5);
  Timer.periodic(oneSec, (Timer t) {
  print('${productBox?.getAll().length}---------------------------Item at L2 at ${DateTime.now().hour}: ${DateTime.now().minute}: ${DateTime.now().second}');
  print('${productBoxCLoud?.getAll().length}---------------------------Item at L3 at ${DateTime.now().hour}: ${DateTime.now().minute}: ${DateTime.now().second}');
  });




}

