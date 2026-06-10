import 'package:flutter/material.dart';
import 'package:frontend2/main.dart';
import 'package:frontend2/tools/pdf/pdf2word.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child){
        return Scaffold(
          appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 0.5,
          centerTitle: true,
          title: Text("FileTools", style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: child,
        );
      },
      routes: [
        GoRoute(path: '/', builder:(context, state) => const MyHomePage(title: "FileTools")),
        //GoRoute(path: 'data', builder(context, state) =>),
        GoRoute(path: '/pdf', builder:(context, state) => const PdfToWord()),
      ]
    )

  ]

);