import 'package:flutter/material.dart';

import 'examples/basic_example.dart';
import 'examples/country_only_example.dart';
import 'examples/filtered_example.dart';
import 'examples/pre_selected_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CountryStatePicker Examples',
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('CountryStatePicker Examples'),
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Basic'),
                Tab(text: 'Pre-selected'),
                Tab(text: 'Country Only'),
                Tab(text: 'Filtered'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              BasicExample(),
              PreSelectedExample(),
              CountryOnlyExample(),
              FilteredExample(),
            ],
          ),
        ),
      ),
    );
  }
}
