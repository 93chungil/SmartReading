// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'package:smart_reading/models/user.dart';
// import 'package:smart_reading/models/message.dart';
// import 'package:smart_reading/models/message_room.dart';
// import 'package:smart_reading/constants.dart' as Constants;

// class MessagePage extends StatefulWidget {
//   final int chatID;
//   MessageRoom currentRoom;
//   MessagePage(this.chatID) {
//     currentRoom = currentUser.rooms[this.chatID];
//   }

//   @override
//   _MessagePageState createState() => _MessagePageState();
// }

// class _MessagePageState extends State<MessagePage> {
//   var formatter = DateFormat.jm();
     
//   _buildMessage(Message message, bool isMe) {
//     final Container msg = Container(
//       margin: isMe
//           ? EdgeInsets.only(
//               top: 8.0,
//               bottom: 8.0,
//               left: 80.0,
//             )
//           : EdgeInsets.only(
//               top: 8.0,
//               bottom: 8.0,
//             ),
//       padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
//       width: MediaQuery.of(context).size.width * 0.75,
//       decoration: BoxDecoration(
//         color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
//         borderRadius: isMe
//             ? BorderRadius.only(
//                 topLeft: Radius.circular(15.0),
//                 bottomLeft: Radius.circular(15.0),
//               )
//             : BorderRadius.only(
//                 topRight: Radius.circular(15.0),
//                 bottomRight: Radius.circular(15.0),
//               ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             formatter.format(message.time),
//             style: TextStyle(
//               color: Colors.blueGrey,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Text(
//             message.text,
//             style: TextStyle(
//               color: Colors.blueGrey,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//     if (isMe) {
//       return msg;
//     }
//     return Row(
//       children: <Widget>[
//         msg,
//         IconButton(
//           icon: message.isLiked
//               ? Icon(Icons.favorite)
//               : Icon(Icons.favorite_border),
//           iconSize: 30.0,
//           color: message.isLiked
//               ? Theme.of(context).primaryColor
//               : Colors.blueGrey,
//           onPressed: () {},
//         )
//       ],
//     );
//   }

//   _buildMessageComposer() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.0),
//       height: 70.0,
//       color: Colors.white,
//       child: Row(
//         children: <Widget>[
//           IconButton(
//             icon: Icon(Icons.photo),
//             iconSize: 25.0,
//             color: Theme.of(context).primaryColor,
//             onPressed: () {},
//           ),
//           Expanded(
//             child: TextField(
//               textCapitalization: TextCapitalization.sentences,
//               onChanged: (value) {},
//               decoration: InputDecoration.collapsed(
//                 hintText: 'Send a message...',
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             iconSize: 25.0,
//             color: Theme.of(context).primaryColor,
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       appBar: AppBar(
//         title: Text(
//           widget.currentRoom.name,
//           style: TextStyle(
//             fontSize: Constants.APPBAR_FONTSIZE,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         elevation: 0.0,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.more_horiz),
//             iconSize: 30.0,
//             color: Colors.white,
//             onPressed: () {},
//           ),
//         ],
//         backgroundColor: Constants.MAIN_COLOR,
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Constants.MAIN_BACKGROUND,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30.0),
//                     topRight: Radius.circular(30.0),
//                   ),
//                   child: ListView.builder(
//                     reverse: true,
//                     padding: EdgeInsets.only(top: 15.0),
//                     itemCount: widget.currentRoom.loadedMessages.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final Message message = widget.currentRoom.loadedMessages[index];
//                       final bool isMe = message.sender.id == currentUser.id;
//                       return _buildMessage(message, isMe);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             _buildMessageComposer(),
//           ],
//         ),
//       ),
//     );
//   }
// }