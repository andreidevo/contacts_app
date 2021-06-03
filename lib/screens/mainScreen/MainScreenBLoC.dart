

import 'package:contacts_app/screens/gerenalModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


@immutable
abstract class MainScreenState {
  const MainScreenState();
}

class MainScreenInitial extends MainScreenState {

  const MainScreenInitial();
}

class MainScreenChangeTab extends MainScreenState {
  const MainScreenChangeTab();
}

enum MainScreenBlocEvent {
  first,
  second,
  third,
}

class MainScreenBloc extends Bloc<MainScreenBlocEvent, List<Color>>{
  MainScreenBloc() : super([
          GeneralModel.noActiveTabColor,
          GeneralModel.activeTabColor,
          GeneralModel.noActiveTabColor
          ]);

  @override
  Stream<List<Color>> mapEventToState(MainScreenBlocEvent event) async* {
    switch (event) {
      case MainScreenBlocEvent.first:
        yield [
          GeneralModel.activeTabColor,
          GeneralModel.noActiveTabColor,
          GeneralModel.noActiveTabColor
        ];
        break;
      case MainScreenBlocEvent.second:
        yield [
          GeneralModel.noActiveTabColor,
          GeneralModel.activeTabColor,
          GeneralModel.noActiveTabColor
        ];
        break;
      case MainScreenBlocEvent.third:
        yield [
          GeneralModel.noActiveTabColor,
          GeneralModel.noActiveTabColor,
          GeneralModel.activeTabColor
        ];
    }
  }

}


//class MainScreenCubit extends Cubit<MainScreenState>{
//  MainScreenCubit() : super(MainScreenInitial());
//
//
//
//  void MapState(MainScreenState state){
//
//    switch(state.runtimeType){
//      case MainScreenInitial:
//
//        break;
//      case MainScreenChangeTab:
//        break;
//    }
//  }
//}



