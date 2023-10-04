import 'dart:developer';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late ConfettiController confettiController;

  @override
  void initState() {
    confettiController = ConfettiController(duration: Duration(seconds: 1));
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      if ((_counter % 5 == 0)) {
        confettiController.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                color: Colors.purple,
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        log('Button Pressed');
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.orange),
                        child: const Icon(Icons.person_2_rounded),
                      ),
                    ),
                    const Text('email@gmai..com'),
                    const Text('name'),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ...[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
                      .map(
                        (e) => ListTile(
                          title: Text('Item $e'),
                          onTap: () {
                            // Update the state of the app.
                            // ...
                          },
                        ),
                      )
                      .toList(),
                ],
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                children: [
                  AnimatedFlipCounter(
                    duration: const Duration(milliseconds: 500),
                    textStyle: const TextStyle(
                      fontSize: 48,
                    ),
                    value: _counter, // pass in a value like 2014
                    curve: Curves.easeIn,
                  ),
                  AnimatedContainer(
                    color: Colors.red,
                    duration: Duration(milliseconds: 300),
                    width: _counter % 2 == 0 ? 100 : 50,
                    height: _counter % 2 == 0 ? 100 : 50,
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirection: 60,
                  gravity: 0.9,
                  numberOfParticles: 100,
                  blastDirectionality: BlastDirectionality.explosive,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
