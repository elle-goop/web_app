import 'package:flutter/material.dart';

@immutable
class Message {
  final String title;
  final String image;
  final Widget body;
  final String lastSentence;
  final String startDate;
  final String status;
  final String endDate;
  final Details details;
  const Message(
      {this.title,
      this.image,
      this.body,
      this.lastSentence,
      this.startDate,
      this.endDate,
      this.status,
      this.details});
}

@immutable
class Participant {
  final String image;
  final String name;
  final bool isHost;
  const Participant({this.image, this.name, this.isHost: false});
}

@immutable
class Details {
  final String title;
  final String confirmationCode;
  final String time;
  final String address;
  final List<Participant> participants;
  const Details(
      {this.title,
      this.confirmationCode,
      this.time,
      this.address,
      this.participants});
}

List<Participant> participantsForVirginia = [
  Participant(
      isHost: true, name: 'Virginia', image: 'assets/images/virginia.png'),
  Participant(name: 'Falon', image: 'assets/images/falon_2.png'),
  Participant(name: 'Maggie', image: 'assets/images/maggie.png'),
  Participant(name: 'Isabelle', image: 'assets/images/isabelle.png'),
  Participant(name: 'Katty', image: 'assets/images/lisa.png'),
];

List<Message> messages = [
  Message(
      title: 'Group message',
      image: 'assets/images/virginia.png',
      status: 'Completed',
      startDate: 'Jun 13, 2020',
      endDate: 'Jun 13, 2020',
      body: SizedBox(),
      lastSentence: 'Let me know if you have troubl...',
      details: Details(
          title: 'Hong Kong Egg Tarts with Netflix Guide',
          confirmationCode: 'TAK8WC3N',
          time: 'Sat, Jun 13, 7:30 PM - 9:00 PM(WIB)',
          address: 'Hong Kong',
          participants: participantsForVirginia)),
  Message(
      title: 'Virginia',
      image: 'assets/images/virginia.png',
      status: 'Completed',
      startDate: 'Jun 11, 2020',
      endDate: 'Jun 13, 2020',
      lastSentence: 'Hello hello & thanks so much f...'),
  Message(
      title: 'Adrian',
      image: 'assets/images/adrian.png',
      status: 'Not possible',
      startDate: 'Apr 8, 2019',
      endDate: 'Apr 26 - 27, 2019',
      lastSentence: 'Halo Akbar. Sementara belum...'),
];
