import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.0,
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.headphones_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mic_none,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const RotatedBox(
                quarterTurns: 1,
                child: SizedBox(
                  height: 32.0,
                  child: Icon(
                    Icons.compare_arrows_outlined,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.0,
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.headphones_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mic_none,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
