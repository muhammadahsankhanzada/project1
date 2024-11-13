import 'package:flutter/material.dart';

class FutureBuilderHelperWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T data) onSuccess;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;

  const FutureBuilderHelperWidget({
    Key? key,
    required this.future,
    required this.onSuccess,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        // Handle the future states
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: loadingWidget ?? CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: errorWidget ?? Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: emptyWidget ?? Text('No Data'),
          );
        } else {
          return onSuccess(snapshot.data!);
        }
      },
    );
  }
}
