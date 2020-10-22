import 'package:flutter/material.dart';
import 'package:web_app/data/home_page_data.dart';
import 'dart:js';
import 'dart:html' as html;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Message currentMessage;

  bool isCurrentMessage(Message message) => message == currentMessage;
  TextEditingController controller;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    currentMessage = messages[0];
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(size.width, 70),
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 69,
                width: size.width * 0.25,
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.black12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'Messages',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.black87,
                        ),
                        onPressed: () {})
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: RichText(
                            text: TextSpan(
                                text: '${currentMessage.title}',
                                style: Theme.of(context).textTheme.bodyText2,
                                children: currentMessage.details == null
                                    ? []
                                    : [
                                        TextSpan(
                                            text: ' about ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2),
                                        TextSpan(
                                            text: currentMessage.details.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2)
                                      ]))),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_basket_outlined,
                          // Icons.details,
                          color: Colors.black,
                          size: 19,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        FlatButton(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: 40,
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.black, width: 1.6),
                                borderRadius: BorderRadius.circular(18)),
                            child: Text('Hide details',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Colors.black)))
                      ],
                    ),
                  ],
                ),
              )),
              Container(
                  height: 69,
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: Colors.black12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          'Details',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.black87,
                          ),
                          onPressed: () {})
                    ],
                  )),
            ],
          ),
        ),
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: size.width * 0.25,
            decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.black12))),
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  Message message = messages[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      color: isCurrentMessage(message)
                          ? Colors.black.withOpacity(0.05)
                          : Colors.transparent,
                      child: InkWell(
                        onTap: () => setState(() {
                          FocusScope.of(context).unfocus();
                          controller.clear();
                          currentMessage = message;
                        }),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                          // height: 200,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    image: DecorationImage(
                                        image: AssetImage(message.image))),
                              ),
                              Flexible(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        message.lastSentence,
                                        // softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        message.startDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${message.status} • ${message.endDate}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(fontWeight: FontWeight.w300),
                                  )
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Stack(
            children: [
              SizedBox.expand(
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: size.width * 0.4,
                        child: currentMessage.body == null
                            ? SizedBox()
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Jun 13, 2020',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          margin: EdgeInsets.only(right: 18),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      currentMessage.image))),
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('Virginia',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text('7:27 PM',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption)
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text('Link to share with guests',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w300)),
                                            FlatButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  html.window.open(
                                                      'https://www.airbnb.com',
                                                      'new tab');
                                                },
                                                child: Text(
                                                  'https://www.airbnb.com',
                                                  style: TextStyle(
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .solid,
                                                      decoration: TextDecoration
                                                          .underline),
                                                )),
                                            Text('Guest password: 737033',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w300)),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                                'let me know if you have trouble getting on!',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w300)),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                FlatButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      html.window.open(
                                                          'https://www.google.com',
                                                          'new tab');
                                                    },
                                                    child: Text(
                                                      'Translate this conversation to English',
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          decorationStyle:
                                                              TextDecorationStyle
                                                                  .solid,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  height: 80,
                  child: Container(
                    height: 60,
                    width: size.width * 0.4,
                    child: TextField(
                      focusNode: focusNode,
                      // style: Theme.of(context)
                      //     .textTheme
                      //     .bodyText1
                      //     .copyWith(fontSize: 16, height: 1.2),
                      controller: controller,
                      maxLines: 1,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                            ),
                          ),
                          labelText: 'Type a message',
                          hintText: 'Type a message',
                          icon: Icon(
                            Icons.image,
                            color: Colors.black,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          )),
          Container(
            width: size.width * 0.25,
            decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.black12))),
            child: SizedBox.expand(
              child: SingleChildScrollView(
                child: currentMessage.details == null
                    ? SizedBox()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(currentMessage.details.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(fontWeight: FontWeight.w300)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'View experience details',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: Color(0xff005C46)),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Text(
                              'Confirmation Code',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              currentMessage.details.confirmationCode,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: Colors.black54),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Text(
                              'Time',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              currentMessage.details.time,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: Colors.black54),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Text(
                              'Address',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              currentMessage.details.address,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: Colors.black54),
                            ),
                            SizedBox(
                              height: 38,
                            ),
                            Text(
                              'Participants',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            ...currentMessage.details.participants
                                .map(
                                  (e) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            margin: EdgeInsets.only(right: 8),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2),
                                                image: DecorationImage(
                                                    image: AssetImage(e.image),
                                                    fit: BoxFit.cover)),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${e.name} ${e.isHost ? "(Host)" : ""}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ],
                                      )),
                                )
                                .toList(),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
