import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'toolcard.dart';
import 'routes.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'File Tools'),
     routerConfig: router, //from routes.dart
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
  void _dummyButton() {
    print("click");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      //   title: Row(
      //     children: [
      //       Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold),),
      //       SizedBox(width: width * 0.05),
      //       IconButton(
      //         onPressed: _dummyButton,
      //         icon: Icon(Icons.home)), //go home/scroll up
      //     TextButton.icon(
      //         onPressed: _dummyButton,
      //         label: Text("FileTools")) //go home/scroll up
      //     ],
      //   ),
      // ),
      body: Container(
          color: Color(0xfff5f5fa),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.12),
              Text('handy dandy tools',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: height * 0.02),
              Text('A collection of my frequently used tools, all compiled into one place',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 38,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: height * 0.02),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: const Color(0xff2e54d1),
                  //     foregroundColor: Colors.white,
                  //     padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  //     elevation: 5,
                  //     textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
                  //   ),
                  //   onPressed: _dummyButton,
                  //   child: Text("PDF to Word"),
                  //   ),
                  //   featureBlock("PDF to Word", "Convert your PDF document to an editable Word document"),
                  ToolCard(
                      image: Icon(Icons.picture_as_pdf),
                      onTap: () => context.go('/pdf'),
                      title: "PDF to Word",
                      subtitle:
                          "Convert your PDF document to an editable Word document"),
                  SizedBox(
                    width: width * 0.08,
                  ),
                  ToolCard(
                      image: Icon(Icons.table_rows),
                      onTap: () => context.go('/structure'),
                      title: "Structured Data",
                      iconBackgroundColor:
                          const Color.fromARGB(255, 125, 196, 66),
                      subtitle:
                          "Convert between structured formats (JSON, Excel, CSV)",
                  ),
                  SizedBox(
                    width: width * 0.08,
                  ),
                  ToolCard(
                      image: Icon(Icons.edit_document),
                      onTap: _dummyButton,
                      title: "Writing Analysis",
                      iconBackgroundColor:
                          const Color.fromARGB(255, 65, 245, 236),
                      subtitle:
                          "Breakdown writing into word, sentence, and paragraph counters, density, and more"),
                ],
              )
            ],
          )),
    );
  }

  Widget featureBlock(String title, String subtitle) {
    return Container(
      child: Column(
        children: [
          Icon(Icons.picture_as_pdf),
          Text(title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black))
        ],
      ),
    );
  }
}
