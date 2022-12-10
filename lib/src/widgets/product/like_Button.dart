import 'package:dalili_app/src/utils/http_request.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool initLike;
  final String productId;

  LikeButton(this.initLike, this.productId);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  // States
  bool _likeProduct = false;

  //Http requests
  HttpRequest likeProduct = HttpRequest(
      url: '/api/Likes',
      method: Methods.post,
      auth: true,
      behavior: Behavior.one);

  Future<void> _toggleLikeHandler() async {
    var result =
        await likeProduct.sendRequest(query: {'productId': widget.productId});

    if (result != null) {
      setState(() {
        _likeProduct = !_likeProduct;
      });
      _likeController.forward().then((_) => _likeController.reverse());
    }
  }

  late AnimationController _likeController;
  late Animation<double> _likeAnimi;

  @override
  void initState() {
    _likeProduct = widget.initLike;
    _likeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    _likeAnimi = Tween<double>(begin: 1, end: 2).animate(
        CurvedAnimation(parent: _likeController, curve: Curves.linear));

    _likeAnimi.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _likeAnimi.value,
      child: IconButton(
        onPressed: () => _toggleLikeHandler(),
        icon: Icon(
          _likeProduct ? Icons.favorite : Icons.favorite_border,
          color: _likeProduct ? Colors.red : null,
        ),
      ),
    );
  }
}
