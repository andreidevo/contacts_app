
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


class MainScreenBloc {

  BehaviorSubject<List<StorageModel>> _mainListStream = BehaviorSubject<List<StorageModel>>();
  BehaviorSubject<List<StorageModel>> get mainListStream => _mainListStream;


  //6465F9



  List<StorageModel> mainList = [];
  Box<StorageModel> listStorage;


  void updateMainListStream(StorageModel storageModels){
    mainList.add(storageModels);
    _mainListStream.sink.add(mainList);
  }

  void loadContactsToFile(Iterable<Contact> contacts) async {

    final now = new DateTime.now();

    int lenContacts = contacts.length;
    String year = now.year.toString();
    String month = getMonth(now.month);
    String time = now.hour.toString() + ":" + now.minute.toString();
    String amPm = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(time+":00")).replaceAll(' ', '');
    print(amPm);
    time = amPm;


    VCard globalCard = VCard();
    String globalFormattedString = "";

    for (final contact in contacts) {
      var vCard = VCard();
      //print(contact.androidAccountName + " displayName");

      vCard.formattedName = contact.displayName;
      for (var phone in contact.phones)
        if (phone.label == 'mobile')
          vCard.workPhone = phone.value;
        else if (phone.label == 'home')
          vCard.homePhone = phone.value;

      vCard.organization = 'ActivSpaces Labs';
      //vCard.photo.attachFromUrl(, 'PNG');
      //vCard.birthday = DateTime.now();
      //vCard.title = 'Software Developer';
      vCard.url = 'https://github.com/valerycolong';
      vCard.note = 'Notes on contact';
      String formattedString = vCard.getFormattedString();
      globalFormattedString += formattedString;
      /// Save to file
      //vCard.saveToFile('./contact.vcf');
    }
    //print(globalFormattedString);
    String fileName = amPm.replaceAll(":", '') + '.vcf';
    File file = await globalCard.saveMultiContactsToFile(fileName, globalFormattedString);
    final directory = await getApplicationDocumentsDirectory();
    print(file.path);
    print(await file.length());
    //FlutterShareFile.share('${directory.path}/', fileName, ShareFileType.file);
    Share.shareFiles(['${directory.path}/' + fileName], text: 'Great file');

  }

  void saveFile(){

  }

  String getMonth(int number){
    switch (number){
      case 1: return "Jan";
        break;
      case 2: return "Feb";
        break;
      case 3: return "Mar";
        break;
      case 4: return "Apr";
        break;
      case 5: return "May";
        break;
      case 6: return "Jun";
        break;
      case 7: return "Jul";
        break;
      case 8: return "Aug";
        break;
      case 9: return "Sep";
        break;
      case 10: return "Oct";
        break;
      case 11: return "Nov";
        break;
      case 12: return "Dec";
        break;
      default:
        return ""; break;

    }
  }

  void dispose(){
    _mainListStream?.close();
  }


}

final mainScreenBloc = MainScreenBloc();