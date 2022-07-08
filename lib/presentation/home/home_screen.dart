import 'dart:async';
import 'dart:convert';

import 'package:clean_architecture/presentation/home/home_view_model.dart';
import 'package:clean_architecture/presentation/home/components/photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();

    Future.microtask(() => {
      _streamSubscription = context.read<HomeViewModel>().eventStream.listen((event) {
        event.when(showSnackbar: (msg) {
          final snackBar = SnackBar(content: Text(msg),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      })
    });


  }

  @override
  void dispose() {
    _controller.dispose();
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // old style
    // final viewModel = Provider.of<HomeViewModel>(context);
    // new style
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          '이미지 검색 앱',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  suffix: IconButton(
                    onPressed: () async {
                      viewModel.fetch(_controller.text);
                    },
                    icon: Icon(Icons.search),
                  )),
            ),
          ),
          state.isLoading ? const CircularProgressIndicator() :
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.photos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return PhotoWidget(
                  photo: state.photos[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
