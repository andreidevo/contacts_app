
import 'dart:io';
import 'package:contacts_app/storageModels/StorageModel.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:intl/intl.dart';
import 'package:contacts_app/vcard/vcard.dart';
import 'package:flutter_share_file/flutter_share_file.dart';
import 'package:share/share.dart';
import 'package:contacts_app/screens/gerenalModel.dart';


enum StateScreen{
  INIT,
  LOADING,
  END
}
class MainScreenBloc {

  BehaviorSubject<List<StorageModel>> _mainListStream = BehaviorSubject<List<StorageModel>>();
  BehaviorSubject<List<StorageModel>> get mainListStream => _mainListStream;


  BehaviorSubject<double> _updateProgressNumber = BehaviorSubject<double>();
  BehaviorSubject<double> _updateProgressSize = BehaviorSubject<double>();
  BehaviorSubject<StateScreen> _isLoadingNow = BehaviorSubject<StateScreen>();

  BehaviorSubject<double> get updateProgressSizeStream => _updateProgressSize;
  BehaviorSubject<double> get updateProgressNumberStream => _updateProgressNumber;
  BehaviorSubject<StateScreen> get isLoadingNowStream => _isLoadingNow;

  double numberProgress = 0;
  double circleSize = 0;

  List<StorageModel> mainList = [];


  void updateMainListStream(StorageModel storageModel){
    mainList.add(storageModel);
    _mainListStream.sink.add(mainList);
  }
  void createNewCard(StorageModel storageModel){
    generalModel.addNewCard(storageModel);
    mainList.add(storageModel);
    _mainListStream.sink.add(mainList);
  }

  void startLoading(){
    _isLoadingNow.sink.add(StateScreen.LOADING);
  }
  void loadContactsToFile(Iterable<Contact> contacts) async {
    changeProgressNumberAndSize(100);

    final now = new DateTime.now();
    String lenContacts = contacts.length.toString();
    String year = now.year.toString();
    String month = getMonth(now.month);
    String day = now.day.toString();
    String time = now.hour.toString() + ":" + now.minute.toString();
    String amPm = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(time+":00")).replaceAll(' ', '');
    time = amPm;


    VCard globalCard = VCard();
    String globalFormattedString = "";

    for (final contact in contacts) {
      var vCard = VCard();

      vCard.formattedName = contact.displayName;
      for (var phone in contact.emails)
        print(phone.label);
      print(contact.avatar);
      vCard.birthday = contact.birthday;
      vCard.organization = contact.company;
      vCard.jobTitle = contact.jobTitle;

      String formattedString = vCard.getFormattedString();
      globalFormattedString += formattedString;
      //changeProgressNumberAndSize(contacts.length);
    }


    String fileName = amPm.replaceAll(":", '') + '.vcf';
    File file = await globalCard.saveMultiContactsToFile(fileName, globalFormattedString);

    //_isLoadingNow.sink.add(StateScreen);



    int bytesFile = await file.length();
    StorageModel storageModels = StorageModel(
      countContacts: lenContacts,
      fileMemory: (bytesFile / 1024).toStringAsFixed(3),
      pathFileVcf: file.path,
      time: time,
      data: month + " " + day + ", " + year
    );

    createNewCard(storageModels);
  }
  void shareFunction(String path){
    Share.shareFiles([path], text: 'Share contacts');
  }

  void redirectToHistory(double number){
    numberProgress = 0;
    circleSize = number;
    _isLoadingNow.sink.add(StateScreen.INIT);
  }


  /// делаем классную симуляцию загрузки.
  /// если контактов не много, то это идеально
  /// если же контактов много, то 99% будут немного висеть
  void changeProgressNumberAndSize(int countFiles) async {
    double step = 99 / countFiles;
    double circleStep = 100 / countFiles;


    for (int i = 0; i < countFiles; i++){
      numberProgress += step;
      circleSize += circleStep;
      await Future.delayed(const Duration(milliseconds: 10), (){});
      _updateProgressNumber.sink.add(numberProgress);
      _updateProgressSize.sink.add(circleSize);


    }

    _isLoadingNow.sink.add(StateScreen.END);
  }



  String getMonth(int number){
    switch (number){
      case 1: return "January";
        break;
      case 2: return "February";
        break;
      case 3: return "March";
        break;
      case 4: return "April";
        break;
      case 5: return "May";
        break;
      case 6: return "June";
        break;
      case 7: return "July";
        break;
      case 8: return "August";
        break;
      case 9: return "September";
        break;
      case 10: return "October";
        break;
      case 11: return "November";
        break;
      case 12: return "December";
        break;
      default:
        return ""; break;

    }
  }

  void dispose(){
    _mainListStream?.close();
    _updateProgressNumber?.close();
    _updateProgressSize?.close();
    _isLoadingNow?.close();
  }




}

final mainScreenBloc = MainScreenBloc();