

import '../../data/model/contact.dart';

abstract class ContactService{
  Future<void> sendMessage(Contact contact);
}