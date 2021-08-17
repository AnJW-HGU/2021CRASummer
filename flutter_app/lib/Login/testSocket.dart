import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';


class TestSocketPage extends StatefulWidget {
  @override
  _TestSocketPageState createState() => _TestSocketPageState();
}

class _TestSocketPageState extends State<TestSocketPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('test'),
            ],
          ),
      ),
    );
  }
}
//     // Dart client
//     IO.Socket socket = IO.io('http://128.199.139.159:3000');
//
//     socket.onConnect((_) {
//       print('connect');
//       socket.emit('connection', 'test');
//     });
//     socket.on('event', (data) => print(data));
//     socket.onDisconnect((_) => print('disconnect'));
//     socket.on('fromServer', (_) => print(_));
//
//     return SafeArea(
//       child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('test'),
//             ],
//           ),
//       ),
//     );
//   }
//
//   // 상태 클래스가 종료될 때 호출
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }


// STEP1:  Stream setup
class StreamSocket{
  final _socketResponse= StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}

StreamSocket streamSocket =StreamSocket();

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen(){
  IO.Socket socket = IO.io('http://128.199.139.159:3000',
      OptionBuilder()
          .setTransports(['websocket']).build());

  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });

  //When an event recieved from server, data is added to the stream
  socket.on('event', (data) => streamSocket.addResponse);
  socket.onDisconnect((_) => print('disconnect'));

}

//Step3: Build widgets with streambuilder
class BuildWithSocketStream extends StatelessWidget {
  const BuildWithSocketStream({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: streamSocket.getResponse ,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          return Container(
            child: Text('${snapshot.data}'),
          );
        },
      ),
    );
  }
}
