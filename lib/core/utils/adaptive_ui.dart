import 'package:flutter/material.dart';

class AdaptiveUi extends StatelessWidget {
  const AdaptiveUi({
    super.key,
    required this.mobileBuilder,
    required this.tabletBuilder,
    required this.webBuilder,
  });
  final WidgetBuilder mobileBuilder, tabletBuilder, webBuilder;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return mobileBuilder(context);
        } else if (constraints.maxWidth < 1200) {
          return tabletBuilder(context);
        } else {
          return webBuilder(context);
        }
      },
    );
  }
}
