import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const channel = const MethodChannel('playground');

void main() => runApp(PlaygroundApp());

class PlaygroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plugin Playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Playground(title: 'Plugin Playground'),
    );
  }
}

class Playground extends StatefulWidget {
  Playground({Key key, this.title}) : super(key: key);

  final String title;

  @override
  PlaygroundState createState() => PlaygroundState();
}

class PlaygroundState extends State<Playground> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Press button to run playground"),
            Text("-"),
            Text(logs)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: runPlayground,
        tooltip: 'Run Playground',
        child: Icon(Icons.play_arrow),
      )
    );
  }

  /////////////// Playground ///////////////////////////////////////////////////
  String logs = "";

  // Call inside a setState({ }) block to be able to reflect changes on screen
  void log(String logString) {
    logs += logString.toString() + "\n";
  }

  // Main function called when playground is run
  void runPlayground() async {
    var testResult = await channel.invokeMethod("test");

    setState(() {
      log(testResult);
    });
  }
}
