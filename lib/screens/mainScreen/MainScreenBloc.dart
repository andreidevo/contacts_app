

import 'package:contacts_app/storageModels/StorageModel.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:intl/intl.dart';
import 'package:contacts_app/vcard/vcard.dart';

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

  void loadContactsToFile(Iterable<Contact> contacts){

    final now = new DateTime.now();

    int lenContacts = contacts.length;
    String year = now.year.toString();
    String month = getMonth(now.month);
    String time = now.hour.toString() + ":" + now.minute.toString();
    String amPm = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(time+":00")).replaceAll(' ', '');
    print(amPm);
    time = amPm;




//    for (final contact in contacts) {
//      var vCard = VCard();
//      print(contact.displayName);
//      //vCard.firstName = contact.displayName.split(' ')[0];
//      vCard.middleName = 'MiddleName';
//      vCard.lastName = 'LastName';
//      vCard.organization = 'ActivSpaces Labs';
//      vCard.photo.attachFromUrl('/path/to/image/file.png', 'PNG');
//      vCard.workPhone = 'Work Phone Number';
//      vCard.birthday = DateTime.now();
//      //vCard.title = 'Software Developer';
//      vCard.url = 'https://github.com/valerycolong';
//      vCard.note = 'Notes on contact';
//
//      /// Save to file
//      //vCard.saveToFile('./contact.vcf');
//    }
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