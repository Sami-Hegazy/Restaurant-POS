import 'package:flutter/material.dart';

class TopMenu extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget action;

  const TopMenu({
    super.key,
    required this.title,
    required this.subTitle,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth > 1200;
        final bool isTablet =
            constraints.maxWidth <= 1200 && constraints.maxWidth > 600;

        if (isDesktop || isTablet) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subTitle,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: isDesktop ? 400 : 300,
                child: action,
              ),
            ],
          );
        } else {
          // Mobile layout
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subTitle,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 12),
              action,
            ],
          );
        }
      },
    );
  }
}
