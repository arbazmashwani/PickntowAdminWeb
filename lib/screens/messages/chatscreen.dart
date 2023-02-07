import 'package:adminweb/helpers/constants.dart';
import 'package:adminweb/helpers/notifications.dart';

import 'package:adminweb/screens/messages/colors.dart';


import 'package:adminweb/screens/messages/my_message_card.dart';
import 'package:adminweb/screens/messages/sender_message_card.dart';

import 'package:adminweb/screens/messages/web_search_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WebLayoutScreen extends StatefulWidget {
  const WebLayoutScreen({Key? key}) : super(key: key);

  @override
  State<WebLayoutScreen> createState() => _WebLayoutScreenState();
}

class _WebLayoutScreenState extends State<WebLayoutScreen> {
  final AssetImage _assetImage = (kDebugMode)
      ? const AssetImage(
          "backgroundImage.png",
        )
      : const AssetImage(
          "assets/backgroundImage.png",
        );
  final ridesRefrence = FirebaseDatabase.instance.ref("drivers");
  final chatroom = FirebaseDatabase.instance.ref("chatroom");
  final chatroomstream = FirebaseDatabase.instance.ref("chatroom");
  TextEditingController messagecontroller = TextEditingController();

  String name = '';
  String phone = "";
  String driverid = "";
  String drivertoken = "";
  String chatroomids = "";
  bool messagescreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: kPrimaryColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const WebSearchBar(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        height: 1000,
                        child: FirebaseAnimatedList(
                            query: ridesRefrence,
                            itemBuilder:
                                ((context, snapshot, animation, index) {
                              String chatroomid = "";
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        chatroomids = "";
                                      });
                                      drivertoken = snapshot
                                          .child("token")
                                          .value
                                          .toString();

                                      await chatroom
                                          .orderByChild("driverid")
                                          .equalTo(snapshot.key.toString())
                                          .once()
                                          .then((DatabaseEvent
                                              databaseEvent) async {
                                        if (databaseEvent.snapshot.value ==
                                            null) {
                                          String randomid = const Uuid().v1();
                                          Map chatroomMap = {
                                            "chatroomid": randomid,
                                            "lastmessage": "",
                                            "driverid": snapshot.key.toString(),
                                            "adminid": "1"
                                          };

                                          chatroom
                                              .child(randomid)
                                              .set(chatroomMap);

                                          setState(() {
                                            chatroomids = randomid;
                                            name = snapshot
                                                .child("fullname")
                                                .value
                                                .toString();
                                            phone = snapshot
                                                .child("phone")
                                                .value
                                                .toString();
                                          });
                                        } else {
                                          await chatroom
                                              .orderByChild("driverid")
                                              .equalTo(snapshot.key.toString())
                                              .once()
                                              .then((DatabaseEvent
                                                  databaseEvent) {
                                            if (databaseEvent.snapshot.value !=
                                                null) {
                                              Map<dynamic, dynamic> values =
                                                  databaseEvent.snapshot.value
                                                      as Map;
                                              values.forEach((key, values) {
                                                setState(() {
                                                  chatroomid = key.toString();
                                                });
                                              });
                                            } else {}
                                          });
                                          setState(() {
                                            chatroomids = chatroomid;
                                            name = snapshot
                                                .child("fullname")
                                                .value
                                                .toString();
                                            phone = snapshot
                                                .child("phone")
                                                .value
                                                .toString();
                                          });
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: ListTile(
                                        title: Text(
                                          snapshot
                                              .child("fullname")
                                              .value
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Text(
                                            snapshot
                                                .child("phone")
                                                .value
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            snapshot
                                                .child("profilePicture")
                                                .value
                                                .toString(),
                                          ),
                                          radius: 30,
                                        ),
                                        trailing: Text(
                                         "9:30",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                      color: dividerColor, indent: 85),
                                ],
                              );
                            })),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.50,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              border: const Border(
                left: BorderSide(color: dividerColor),
              ),
              image: DecorationImage(image: _assetImage, fit: BoxFit.fill),
            ),
            child: chatroomids.isEmpty
                ? Container(
                    color: Colors.transparent,
                  )
                : Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.077,
                        width: MediaQuery.of(context).size.width * 0.75,
                        padding: const EdgeInsets.all(10.0),
                        color: webAppBarColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "",
                                  ),
                                  radius: 20,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        messagescreen = false;
                                        chatroomids = "";
                                        name = '';
                                        phone = "";
                                        driverid = "";
                                        drivertoken = "";
                                        chatroomids = "";
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.minimize,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Container(
                            child: chatroomids.isEmpty
                                ? Container(
                                    color: Colors.transparent,
                                  )
                                : Container(
                                    color: Colors.transparent,
                                    child: FirebaseAnimatedList(
                                        query: chatroomstream
                                            .child(chatroomids)
                                            .child("Messages")
                                            .orderByChild("createdon"),
                                        itemBuilder: ((context, snapshot,
                                            animation, index) {
                                          if (snapshot
                                                  .child('sender')
                                                  .value
                                                  .toString() ==
                                              "1") {
                                            return MyMessageCard(
                                              message: snapshot
                                                  .child('text')
                                                  .value
                                                  .toString(),
                                              date: "",
                                            );
                                          }
                                          return SenderMessageCard(
                                            message: snapshot
                                                .child('text')
                                                .value
                                                .toString(),
                                            date: "",
                                          );
                                        })),
                                  )),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: dividerColor),
                          ),
                          color: chatBarMessage,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 15,
                                ),
                                child: TextField(
                                  controller: messagecontroller,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: searchBarColor,
                                    hintText: 'Type a message',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(left: 20),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                String msg = messagecontroller.text.trim();
                                String randommessageid =
                                    const Uuid().v1().toString();
                                String adminid = "1";
                                Map chatroomMessageMap = {
                                  "messageid": randommessageid,
                                  "sender": adminid,
                                  "createdon": DateTime.now().toString(),
                                  "text": msg,
                                  "seen": false,
                                };
                                await chatroom
                                    .child(chatroomids)
                                    .child("Messages")
                                    .child(randommessageid)
                                    .set(chatroomMessageMap)
                                    .catchError((error) {
                                  return error.toString();
                                });

                                sendPushMessage("You got a New Message",
                                    "New Message", drivertoken);
                                setState(() {
                                  messagecontroller.clear();
                                });
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
