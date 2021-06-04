

import 'package:contacts_app/storageModels/StorageModel.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class MainScreenBloc {

  BehaviorSubject<List<StorageModel>> _mainListStream = BehaviorSubject<List<StorageModel>>();
  BehaviorSubject<List<StorageModel>> get mainListStream => _mainListStream;

  List<StorageModel> mainList = [];
  Box<StorageModel> listStorage;


  void updateMainListStream(StorageModel storageModels){
    mainList.add(storageModels);
    _mainListStream.sink.add(mainList);
  }

  void dispose(){
    _mainListStream?.close();
  }
}

final mainScreenBloc = MainScreenBloc();