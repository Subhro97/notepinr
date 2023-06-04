import 'package:flutter/material.dart';
import 'package:share/share.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                _showShareSheet(context);
              },
              child: Text('Share'),
            ),
          );
        },
      ),
    );
  }

  void _showShareSheet(BuildContext context) {
    Share.share('Share this content', subject: 'Share');
  }
}
