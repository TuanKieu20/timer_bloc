import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/background.dart';
import 'package:todos_bloc/bloc/simple_bloc.dart';
import 'package:todos_bloc/bloc/timer_bloc/time_bloc.dart';
import 'package:todos_bloc/widget/custom_button.dart';
import 'bloc/timer_bloc/time_event.dart';
import 'bloc/timer_bloc/time_state.dart';

void main() {
  Bloc.observer = SimpleBlocObServer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[50],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer App"),
      ),
      body: BlocProvider<TimerBloc>(
        create: (context) => TimerBloc(),
        child: MyBodyPage(),
      ),
    );
  }
}

class MyBodyPage extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBodyPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
// because state is int type, so we must convert state to minute and second String
        final String minuteStr =
            ((state.timeDuration / 60) % 60).floor().toString().padLeft(2, '0');
        final String secondStr =
            (state.timeDuration % 60).floor().toString().padLeft(2, '0');

        return Scaffold(
          floatingActionButton: Container(
            decoration:
                BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            child: IconButton(
              tooltip: "Set Up Timer",
              icon: Icon(Icons.add),
              onPressed: () async {
                int timerSetUp = 60;
                await showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.ms,
                        backgroundColor: Colors.white,
                        onTimerDurationChanged: (value) {
                          print(int.parse(value.inSeconds.toString()));
                          timerSetUp = int.parse(value.inSeconds.toString());
                        },
                      ),
                    );
                  },
                );
                BlocProvider.of<TimerBloc>(context).add(SetUpTimer(timerSetUp));
              },
            ),
          ),
          body: Stack(
            children: [
              Background1(),
              Column(
                children: <Widget>[
                  Text(
                    "Application is remade by TuanKieu",
                    style: TextStyle(color: Colors.blue[120]),
                  ),
                  Spacer(flex: 2),
                  Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: (state is CompletedState)
                        ? Text(
                            "Timer is finished",
                            style: TextStyle(
                                fontSize: 34,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w700),
                          )
                        : Text(
                            "$minuteStr:$secondStr",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  Spacer(flex: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: mapStateToActionButtons(
                        timerBloc: BlocProvider.of<TimerBloc>(context)),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

/// class to todos app
///
/// void main() {
//   Bloc.observer = SimpleBlocObServer();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.grey,
//         primaryColor: Colors.grey[800],
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       appBar: AppBar(
//         title: (FlutterBlocLocalizations.of(context) != null)
//             ? Text(FlutterBlocLocalizations.of(context)!.appTitle)
//             : Text("data"),
//         actions: [
//           PopupMenuButton(
//             color: Colors.grey[800],
//             onSelected: (value) => print("On Click $value"),
//             icon: Icon(Icons.filter_list),
//             itemBuilder: (context) {
//               return [
//                 PopupMenuItem(
//                   value: "Show All",
//                   child: Text(
//                     "Show All",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 PopupMenuItem(
//                   value: "Show Active",
//                   child: Text(
//                     "Show Active",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 PopupMenuItem(
//                   value: "Show Active",
//                   child: Text(
//                     "Show Completed",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ];
//             },
//           ),
//           PopupMenuButton(
//             color: Colors.grey[800],
//             icon: Icon(Icons.more_horiz),
//             itemBuilder: (context) {
//               return [
//                 PopupMenuItem(
//                   value: "Mark all complete",
//                   child: Text(
//                     "Mark all complete",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 PopupMenuItem(
//                   value: "Clear completed",
//                   child: Text(
//                     "Clear completed",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//       body: BlocProvider<TimerBloc>(
//         create: (context) => TimerBloc(),
//         child: MyBodyPage(),
//       ),
//     );
//   }
// }

// class _MyBodyState extends State<MyBodyPage> {
//   bool isCheck = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <ListTile>[
//           ListTile(
//             leading: Checkbox(
//               splashRadius: 10.0,
//               checkColor: Colors.white,
//               fillColor: (isCheck == false)
//                   ? MaterialStateProperty.resolveWith(
//                       (states) => Colors.white54)
//                   : MaterialStateProperty.resolveWith(
//                       (states) => Colors.blue[100]),
//               value: isCheck,
//               onChanged: (bool? value) {
//                 setState(() {
//                   isCheck = value!;
//                 });
//               },
//             ),
//             title: Text(
//               "Go to Shopping with friend",
//               style: TextStyle(color: Colors.white),
//             ),
//             subtitle: Text("9:00 A.M", style: TextStyle(color: Colors.white)),
//           ),
//           ListTile(
//             leading: Checkbox(
//               splashRadius: 10.0,
//               checkColor: Colors.white,
//               fillColor: (isCheck == false)
//                   ? MaterialStateProperty.resolveWith(
//                       (states) => Colors.white54)
//                   : MaterialStateProperty.resolveWith(
//                       (states) => Colors.blue[100]),
//               value: isCheck,
//               onChanged: (bool? value) {
//                 setState(() {
//                   isCheck = value!;
//                 });
//               },
//             ),
//             title: Text(
//               "Go to Shopping with friend",
//               style: TextStyle(color: Colors.white),
//             ),
//             subtitle: Text("9:00 A.M", style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
// }

class FlutterBlocLocalizations {
  static FlutterBlocLocalizations? of(BuildContext context) {
    return Localizations.of<FlutterBlocLocalizations>(
      context,
      FlutterBlocLocalizations,
    );
  }

  String get appTitle => "Flutter Todos";
}
