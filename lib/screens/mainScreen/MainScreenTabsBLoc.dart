import 'package:contacts_app/screens/gerenalModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum MainScreenTapEvent {
  ChangeTapFirst,
  ChangeTapSecond,
  ChangeTapThird,
}

class MainScreenTapBloc extends Bloc<MainScreenTapEvent, dynamic>{
  MainScreenTapBloc() : super([
          GeneralModel.noActiveTabColor,
          GeneralModel.activeTabColor,
          GeneralModel.noActiveTabColor
          ]);

  @override
  Stream<dynamic> mapEventToState(MainScreenTapEvent event) async* {
    switch (event) {
      case MainScreenTapEvent.ChangeTapFirst:
        yield [
          GeneralModel.activeTabColor,
          GeneralModel.noActiveTabColor,
          GeneralModel.noActiveTabColor
        ];
        break;
      case MainScreenTapEvent.ChangeTapSecond:
        yield [
          GeneralModel.noActiveTabColor,
          GeneralModel.activeTabColor,
          GeneralModel.noActiveTabColor
        ];
        break;
      case MainScreenTapEvent.ChangeTapThird:
        yield [
          GeneralModel.noActiveTabColor,
          GeneralModel.noActiveTabColor,
          GeneralModel.activeTabColor
        ];
        break;
    }
  }


}


enum MainScreenBackEvent {
  click,
//  loading,
//  ChangeTapThird,

}

//class MainScreenBackBloc extends Bloc<MainScreenBackEvent, dynamic>{
//  MainScreenBackBloc() : super(1);
//
//
//  @override
//  Stream<dynamic> mapEventToState(MainScreenBackEvent event) async* {
//    switch (event) {
//      case MainScreenBackEvent.click:
//        someWorkFunction();
//        break;
//
//    }
//  }
//
//  void someWorkFunction(){
//
//  }
//
//}
//
//

