import 'package:flutter/material.dart';

class StreamBuilderHelperWidget<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(T data) onSuccess;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;

  const StreamBuilderHelperWidget({
    Key? key,
    required this.stream,
    required this.onSuccess,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        // Handle the stream states
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child:
                  loadingWidget ?? Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(
              child: errorWidget ??
                  Center(child: Text('Error: ${snapshot.error}')));
        } else if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data == [] ||
            snapshot.data == '') {
          return Center(child: emptyWidget ?? Center(child: Text('No Data')));
        } else {
          return onSuccess(snapshot.data!);
        }
      },
    );
  }
}

/// A reusable StreamBuilder helper that you can use throughout your app.
///
/// - [stream] is the stream that you want to listen to.
/// - [onSuccess] is the callback for when the stream has data and is successful.
/// - [loadingWidget] is the widget to show when the stream is loading (optional).
/// - [errorWidget] is the widget to show when the stream has an error (optional).
/// - [emptyWidget] is the widget to show when the stream has no data (optional).
///
/// Example usage:
/// ```dart
/// StreamBuilderHelper(
///   stream: myStream,
///   onSuccess: (data) => MySuccessWidget(data: data),
///   loadingWidget: CircularProgressIndicator(),
///   errorWidget: Text("Error loading data"),
///   emptyWidget: Text("No data available"),
/// );
/// ```