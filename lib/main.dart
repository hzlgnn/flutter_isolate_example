import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: IsolateExample(),
      ),
    );
  }
}

class IsolateExample extends StatelessWidget {
  const IsolateExample({super.key});

  final int largeNumber = 1000000000;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('Start with Isolate'),
                  onPressed: () async {
                    final receivePort = ReceivePort();
                    await Isolate.spawn(
                        computeProductWithIsolate, receivePort.sendPort);

                    receivePort.listen((sum) {
                      print('Sum using Isolate: $sum');
                    });
                  },
                ),
                const Spacer(),
                const CircularProgressIndicator(),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('Start with compute'),
                  onPressed: () {
                    final sum = compute(computeProductWithCompute, largeNumber);
                    print('Sum using compute: $sum');
                  },
                ),
                const Spacer(),
                const CircularProgressIndicator(),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('Start without Isolate'),
                  onPressed: () async {
                    final sum = await computeProductWithoutIsolate(largeNumber);
                    print('Sum without Isolate: $sum');
                  },
                ),
                const Spacer(),
                const CircularProgressIndicator(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void computeProductWithIsolate(SendPort sendPort) {
    print('Heavy work started in isolate');
    BigInt product = BigInt.one;
    for (var i = 1; i <= largeNumber; i++) {
      product *= BigInt.from(i);
    }
    print('Heavy work finished in isolate');
    sendPort.send(product); // Send the result back to the main isolate
  }

// Function that runs on the main thread without an isolate
  Future<BigInt> computeProductWithoutIsolate(int value) async {
    BigInt product = BigInt.one;
    for (var i = 1; i <= value; i++) {
      product *= BigInt.from(i);
    }
    print('Finished task on main thread');
    return product;
  }

// Function that runs using Flutter's compute function
  BigInt computeProductWithCompute(int value) {
    BigInt product = BigInt.one;
    for (var i = 1; i <= value; i++) {
      product *= BigInt.from(i);
    }
    print('Finished task using compute');
    return product;
  }
}
