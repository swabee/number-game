import 'package:flutter/material.dart';

class ShakeNumberWidget extends StatefulWidget {
  final Widget child;
  final bool shake;

  
  const ShakeNumberWidget({super.key, required this.child, required this.shake});

  @override
  State<ShakeNumberWidget> createState() => _ShakeNumberWidgetState();
}

class _ShakeNumberWidgetState extends State<ShakeNumberWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    // Left-right-left wiggle that ends at 0
    _offset = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -6), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -6, end: 6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6, end: -6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant ShakeNumberWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shake) {
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offset,
      builder: (context, child) =>
          Transform.translate(offset: Offset(_offset.value, 0), child: child),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
