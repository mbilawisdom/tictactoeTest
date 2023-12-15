import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<String>>? board;

  String? player;

  initGame() {
    board = List.generate(3, (index) => List.filled(3, ''));
    player = '';
    setState(() {});
  }

  voidCheckGameWinner() {
    for (int i = 0; i < 3; i++) {
      if (board![i][0] == board![i][1] &&
          board![i][1] == board![i][2] &&
          board![i][0].isNotEmpty) {
        return board![i][0];
      }
      if (board![0][i] == board![1][i] &&
          board![1][i] == board![2][i] &&
          board![0][i].isNotEmpty) {
        return board![0][i];
      }
      if (board![0][0] == board![1][1] &&
          board![1][1] == board![2][2] &&
          board![0][0].isNotEmpty) {
        return board![0][0];
      }
      if (board![0][2] == board![1][1] &&
          board![1][1] == board![2][0] &&
          board![0][2].isNotEmpty) {
        return board![0][2];
      }
    }
    return "";
  }

  void showWinnerDialog(String? winner) {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          content: Text(winner!),
        ));
  }


  void onBoardCellClicked(int row, int col) {
    if (board![row][col].isEmpty) {
      setState(() {
        board![row][col] = player!;
        player = player == 'X' ? "O" : "X";
      });
    }


  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text(widget.title),
        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: 9,
            itemBuilder: (context, index) {
              final row = index ~/ 3;
              final column = index % 3;

              return InkWell(
                onTap: () => onBoardCellClicked(row, column),
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: Center(
                    child: Text(
                      board![row][column],
                      style: const TextStyle(color: Colors.black, fontSize: 40),
                    ),
                  ),
                ),
              );
            }));
  }
}
