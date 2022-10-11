import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:path/path.dart';

import 'package:sync_l2_l3/products_response.dart';

import 'objectbox.g.dart'; // created by `dart pub run build_runner build`

import 'package:objectbox/objectbox.dart';

/// return all entities matching the query
/// query.find();

/// return only the first result or null if none
///query.findFirst();

/// return the only result or null if none, throw if more than one result
///query.findUnique();

///To remove all objects matching a query, call query.remove() .

/// offset by 10, limit to at most 5 results
///   ..offset = 10
///   ..limit = 5;
///   List<String> emails = query.property(User_.email).find(); just to find list of particular variable

///flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
//rm -rf data.mdb lock.mdb
/*For empty directories, use rmdir [dirname] or rm -d [dirname]
For non-empty directories, use rm -r [dirname]*/
/*Run any one of the following command on Linux to see open ports:
sudo lsof -i -P -n | grep LISTEN
sudo netstat -tulpn | grep LISTEN
sudo ss -tulpn | grep LISTEN
sudo lsof -i:22 ## see a specific port such as 22 ##
sudo nmap -sTU -O IP-address-Here*/
/*docker run --rm -it \
--volume $(pwd):/data \
--publish 127.0.0.1:9999:9999 \
--publish 127.0.0.1:9980:9980 \
--user $UID \
objectboxio/sync:21.5.14-server \
--model ./data/objectbox-model.json \
--unsecured-no-authentication \
--browser-bind 0.0.0.0:9980*/
// ssh -i /Users/born/Desktop/privatekey.pem  savil@35.154.207.75
// ./sync-server --model=objectbox-model.json --unsecured-no-authentication --debug
//https://www.guru99.com/the-vi-editor.html
class ObjectBoxSyncClient {

  Box<Items>? productBox;
  Box<Items>? productBoxCLoud;
  late Stream<List<Items>?>? stream;
  late Stream<List<Items>?>? streamCLoud;


  Store? store;
  Store? storeCloud;
  SyncClient? syncClient;
  SyncClient? syncClientCloud;
  Future<SyncClient?> setupL2()
  async {
    store = openStore( );
    syncClient = Sync.client(
        store!,
        'ws://127.0.0.1:9999',
        SyncCredentials.none());
    productBox = store!.box<Items>();
    syncClient?.start();
    return syncClient;
  }


  Future<SyncClient?> setupL3()
  async {
    var path = Directory.current.absolute.path;
    storeCloud = openStore(directory: join(path, 'objectbox-cld'));

    syncClientCloud =  Sync.client(
        storeCloud!,
        'ws://35.154.207.75:9999',
        SyncCredentials.none());
    productBoxCLoud = storeCloud!.box<Items>();
    syncClientCloud?.start();
    return syncClientCloud;
  }

  void addListeners()
  {


    syncClient?.changeEvents.listen((event) {

    });
    syncClientCloud?.changeEvents.listen((event) {

    });
  }
}
