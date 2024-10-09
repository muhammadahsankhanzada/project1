import 'package:flutter/material.dart';

class NetworkImageLoader extends StatefulWidget {
  final String imageUrl;
  final String alternativeImage;

  const NetworkImageLoader({
    Key? key,
    required this.imageUrl,
    required this.alternativeImage,
  }) : super(key: key);

  @override
  _NetworkImageLoaderState createState() => _NetworkImageLoaderState();
}

class _NetworkImageLoaderState extends State<NetworkImageLoader> {
  late ImageProvider _imageProvider;
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      // Attempt to load the network image
      _imageProvider = NetworkImage(widget.imageUrl);
      await precacheImage(_imageProvider, context);
    } catch (e) {
      // Handle the error
      setState(() {
        _error = true;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : _error
            ? Image.asset(widget.alternativeImage)
            : Image(image: _imageProvider);
  }
}
