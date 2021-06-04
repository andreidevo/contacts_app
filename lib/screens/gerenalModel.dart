import 'dart:io';
import 'package:contacts_app/storageModels/Prefs.dart';
import 'package:contacts_app/storageModels/StorageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'mainScreen/MainScreenBloc.dart';

class GeneralModel{

  static Color activeTabColor = Color(0xFF6465F9);
  static Color noActiveTabColor = Color(0xFFC5C4FE);


  Box<StorageModel> listStorage;

  void initHiveFunction() async {

    String path = await Prefs.path;
    if (path == ""){
      Directory directory = await pathProvider.getApplicationDocumentsDirectory();
      path = directory.path;
      Prefs.setPath(path);
    }

    Hive.init(path);

    Hive.registerAdapter(StorageModelAdapter());
    listStorage = await Hive.openBox<StorageModel>("list_model");

    List<StorageModel> list = listStorage.values.toList();

    StorageModel storageModel = StorageModel();
    mainScreenBloc.updateMainListStream(storageModel);
    for (var j in list){
      mainScreenBloc.updateMainListStream(j);
    }

  }
}

final generalModel = GeneralModel();