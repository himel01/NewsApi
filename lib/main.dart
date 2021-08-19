import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/api_service/news_api_service.dart';
import 'package:news_api/models/model_news_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Api',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ModelNewsApi? modelNewsApi;

  getNews() {
    NewsApiService().fetchNews(http.Client()).then((value) {
      setState(() {
        modelNewsApi = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("News Api"),
      ),
      body: Container(
          height: height,
          width: width,
          child: modelNewsApi != null
              ? ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: modelNewsApi!.articles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                              modelNewsApi!.articles[index].urlToImage),
                          maxRadius: 30.0,
                        ),
                        title: Text(modelNewsApi!.articles[index].title),
                        isThreeLine: true,
                        subtitle:
                            Text(modelNewsApi!.articles[index].description),
                      ),
                    );
                  })
              : Center(child: CircularProgressIndicator())),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
