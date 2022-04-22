import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repositories/data_books_repositories.dart';
import 'home_controller.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState(HomeController(DataBookRepository()));
  }
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);

  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
      body: Column(
        children: [
          Expanded(
            child: ControlledWidgetBuilder<HomeController>(
              builder: (context, controller) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.books != null && controller.books!.isNotEmpty
                          ? Text(
                              controller.books!.first.kitap,
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      controller.books != null && controller.books!.isNotEmpty
                          ? Text(
                              controller.books!.first.year,
                              style:
                                  TextStyle(fontSize: 25, color: Colors.green),
                            )
                          : Center(
                              child: Text(controller.books!.first.id),
                            )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
