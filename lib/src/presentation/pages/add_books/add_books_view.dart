import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repositories/data_books_repositories.dart';
import 'add_books_controller.dart';

class AddBooksView extends View {
  @override
  State<StatefulWidget> createState() {
    return _AddBooksViewState(AddBooksController(DataBookRepository()));
  }
}

class _AddBooksViewState extends ViewState<AddBooksView, AddBooksController> {
  _AddBooksViewState(AddBooksController controller) : super(controller);
  @override
  Widget get view {
    EdgeInsets padding = MediaQuery.of(context).padding;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: ControlledWidgetBuilder<AddBooksController>(
        builder: (context, controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                SizedBox(height: padding.top),
                TextFormField(
                  onChanged: (value) =>
                      controller.onTitleTextFieldChanged(value),
                  decoration: InputDecoration(
                    label: Text("Title"),
                  ),
                ),
                TextFormField(
                  onChanged: (value) =>
                      controller.onDescriptionTextFieldChanged(value),
                  decoration: InputDecoration(
                    label: Text("Description"),
                  ),
                ),
                TextFormField(
                  onChanged: (value) =>
                      controller.onImageUrlTextFieldChanged(value),
                  decoration: InputDecoration(
                    label: Text("ImageUrl"),
                  ),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () => controller.onAddButtonPressed(),
                  child: Container(
                    height: 50,
                    width: 100,
                    color: Colors.blue,
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
