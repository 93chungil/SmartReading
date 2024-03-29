import 'dart:async';
import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dash_chat/dash_chat.dart';

import 'package:smart_reading/models/message_room.dart';
import 'package:smart_reading/models/user.dart';
import 'package:smart_reading/constants.dart' as Constants;


class MessagePage extends StatefulWidget {
  final int chatID;
  MessageRoom currentRoom;
  MessagePage(this.chatID) {
    currentRoom = currentUser.rooms[this.chatID];
  }
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();
  ChatUser user;
  _MessagePageState() {
    user = ChatUser(
      name: currentUser.name,
      uid: currentUser.id.toString(),
      avatar: currentUser.imageUrl,
    );
  }

  List<ChatMessage> messages = List<ChatMessage>();
  var m = List<ChatMessage>();

  var i = 0;

  @override
  void initState() {
    super.initState();
    widget.currentRoom.loadMessages();
  }

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  void onSend(ChatMessage message) async {
    print(message.toJson());
    // var documentReference = Firestore.instance
    //     .collection('messages')
    //     .document(DateTime.now().millisecondsSinceEpoch.toString());

    // await Firestore.instance.runTransaction((transaction) async {
    //   await transaction.set(
    //     documentReference,
    //     message.toJson(),
    //   );
    // });
    /* setState(() {
      messages = [...messages, message];
      print(messages.length);
    });

    if (i == 0) {
      systemMessage();
      Timer(Duration(milliseconds: 600), () {
        systemMessage();
      });
    } else {
      systemMessage();
    } */
  }

  @override
  Widget build(BuildContext context) {
    var messages = widget.currentRoom.messages;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.currentRoom.name),
        backgroundColor: Constants.MAIN_COLOR,
      ),
       body: DashChat(
                key: _chatViewKey,
                inverted: false,
                onSend: onSend,
                sendOnEnter: true,
                textInputAction: TextInputAction.send,
                user: user,
                inputDecoration:
                    InputDecoration.collapsed(hintText: "Add message here..."),
                dateFormat: DateFormat('yyyy-MMM-dd'),
                timeFormat: DateFormat('HH:mm'),
                messages: messages,
                showUserAvatar: false,
                showAvatarForEveryMessage: false,
                scrollToBottom: true,
                onPressAvatar: (ChatUser user) {
                  print("OnPressAvatar: ${user.name}");
                },
                onLongPressAvatar: (ChatUser user) {
                  print("OnLongPressAvatar: ${user.name}");
                },
                inputMaxLines: 5,
                messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                alwaysShowSend: true,
                inputTextStyle: TextStyle(fontSize: 16.0),
                inputContainerStyle: BoxDecoration(
                  border: Border.all(width: 0.0),
                  color: Colors.white,
                ),
                onQuickReply: (Reply reply) {
                  setState(() {
                    messages.add(ChatMessage(
                        text: reply.value,
                        createdAt: DateTime.now(),
                        user: user));

                    messages = [...messages];
                  });

                  Timer(Duration(milliseconds: 300), () {
                    _chatViewKey.currentState.scrollController
                      ..animateTo(
                        _chatViewKey.currentState.scrollController.position
                            .maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );

                    if (i == 0) {
                      systemMessage();
                      Timer(Duration(milliseconds: 600), () {
                        systemMessage();
                      });
                    } else {
                      systemMessage();
                    }
                  });
                },
                onLoadEarlier: () {
                  print("laoding...");
                },
                shouldShowLoadEarlier: false,
                showTraillingBeforeSend: true,
                trailing: <Widget>[
                  IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () async {
                      File result = await ImagePicker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 80,
                        maxHeight: 400,
                        maxWidth: 400,
                      );

                      // TODO Register Photo to Server


                      // if (result != null) {
                      //   final StorageReference storageRef =
                      //       FirebaseStorage.instance.ref().child("chat_images");

                      //   StorageUploadTask uploadTask = storageRef.putFile(
                      //     result,
                      //     StorageMetadata(
                      //       contentType: 'image/jpg',
                      //     ),
                      //   );
                      //   StorageTaskSnapshot download =
                      //       await uploadTask.onComplete;

                      //   String url = await download.ref.getDownloadURL();

                      //   ChatMessage message =
                      //       ChatMessage(text: "", user: user, image: url);

                      //   var documentReference = Firestore.instance
                      //       .collection('messages')
                      //       .document(DateTime.now()
                      //           .millisecondsSinceEpoch
                      //           .toString());

                      //   Firestore.instance.runTransaction((transaction) async {
                      //     await transaction.set(
                      //       documentReference,
                      //       message.toJson(),
                      //     );
                      //   });
                      // }
                    },
                  )
                ],
              )
      // body: StreamBuilder(
      //     //stream: Firestore.instance.collection('messages').snapshots(),
      //     builder: (context, snapshot) {
      //       if (!snapshot.hasData) {
      //         return Center(
      //           child: CircularProgressIndicator(
      //             valueColor: AlwaysStoppedAnimation<Color>(
      //               Theme.of(context).primaryColor,
      //             ),
      //           ),
      //         );
      //       } else {
      //         //List<DocumentSnapshot> items = snapshot.data.documents;
      //         var messages = widget.currentRoom.messages;
      //             //items.map((i) => ChatMessage.fromJson(i.data)).toList();
      //         return DashChat(
      //           key: _chatViewKey,
      //           inverted: false,
      //           onSend: onSend,
      //           sendOnEnter: true,
      //           textInputAction: TextInputAction.send,
      //           user: user,
      //           inputDecoration:
      //               InputDecoration.collapsed(hintText: "Add message here..."),
      //           dateFormat: DateFormat('yyyy-MMM-dd'),
      //           timeFormat: DateFormat('HH:mm'),
      //           messages: messages,
      //           showUserAvatar: false,
      //           showAvatarForEveryMessage: false,
      //           scrollToBottom: true,
      //           onPressAvatar: (ChatUser user) {
      //             print("OnPressAvatar: ${user.name}");
      //           },
      //           onLongPressAvatar: (ChatUser user) {
      //             print("OnLongPressAvatar: ${user.name}");
      //           },
      //           inputMaxLines: 5,
      //           messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
      //           alwaysShowSend: true,
      //           inputTextStyle: TextStyle(fontSize: 16.0),
      //           inputContainerStyle: BoxDecoration(
      //             border: Border.all(width: 0.0),
      //             color: Colors.white,
      //           ),
      //           onQuickReply: (Reply reply) {
      //             setState(() {
      //               messages.add(ChatMessage(
      //                   text: reply.value,
      //                   createdAt: DateTime.now(),
      //                   user: user));

      //               messages = [...messages];
      //             });

      //             Timer(Duration(milliseconds: 300), () {
      //               _chatViewKey.currentState.scrollController
      //                 ..animateTo(
      //                   _chatViewKey.currentState.scrollController.position
      //                       .maxScrollExtent,
      //                   curve: Curves.easeOut,
      //                   duration: const Duration(milliseconds: 300),
      //                 );

      //               if (i == 0) {
      //                 systemMessage();
      //                 Timer(Duration(milliseconds: 600), () {
      //                   systemMessage();
      //                 });
      //               } else {
      //                 systemMessage();
      //               }
      //             });
      //           },
      //           onLoadEarlier: () {
      //             print("laoding...");
      //           },
      //           shouldShowLoadEarlier: false,
      //           showTraillingBeforeSend: true,
      //           trailing: <Widget>[
      //             IconButton(
      //               icon: Icon(Icons.photo),
      //               onPressed: () async {
      //                 File result = await ImagePicker.pickImage(
      //                   source: ImageSource.gallery,
      //                   imageQuality: 80,
      //                   maxHeight: 400,
      //                   maxWidth: 400,
      //                 );

      //                 // TODO Register Photo to Server


      //                 // if (result != null) {
      //                 //   final StorageReference storageRef =
      //                 //       FirebaseStorage.instance.ref().child("chat_images");

      //                 //   StorageUploadTask uploadTask = storageRef.putFile(
      //                 //     result,
      //                 //     StorageMetadata(
      //                 //       contentType: 'image/jpg',
      //                 //     ),
      //                 //   );
      //                 //   StorageTaskSnapshot download =
      //                 //       await uploadTask.onComplete;

      //                 //   String url = await download.ref.getDownloadURL();

      //                 //   ChatMessage message =
      //                 //       ChatMessage(text: "", user: user, image: url);

      //                 //   var documentReference = Firestore.instance
      //                 //       .collection('messages')
      //                 //       .document(DateTime.now()
      //                 //           .millisecondsSinceEpoch
      //                 //           .toString());

      //                 //   Firestore.instance.runTransaction((transaction) async {
      //                 //     await transaction.set(
      //                 //       documentReference,
      //                 //       message.toJson(),
      //                 //     );
      //                 //   });
      //                 // }
      //               },
      //             )
      //           ],
      //         );
      //       }
      //     }),
    );
  }
}