import 'package:flutter/material.dart';
import 'dart:convert';
import 'SurfSpot.dart';
import 'package:flutter/services.dart' as rootBundle;

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
        primarySwatch: Colors.blue,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(
                child: Text("${data.error}"),
              );
            } else if (data.hasData) {
              return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  padding: const EdgeInsets.all(10),
                  itemCount: data.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 300,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "${data.data?[index].name}",
                            ),
                            Text(
                              "${data.data?[index].address}",
                            ),
                            Image(
                              image: NetworkImage(data.data?[index].url),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<List<dynamic>> ReadJsonData() async {
    final jsondata = await rootBundle.rootBundle.loadString('data/data.json');
    final list = json.decode(jsondata)['records'];
    print(list);
    return list.map((e) => SurfSpot.fromJson(e)).toList();
  }
}
