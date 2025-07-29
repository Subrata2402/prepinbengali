import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.scale(
          scale: 0.9,
          child: Image.asset('assets/images/app_logo.png')),
        Positioned(
          bottom: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    'Prep',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontFamily: 'Peace',
                      fontSize: 35
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.red, width: 5),
                      ),
                    ),
                    child: Text(
                      'i',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(
                        color: Colors.red,
                        fontFamily: 'Peace',
                        height: 0.8,
                        fontSize: 35
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.yellow, width: 5),
                      ),
                    ),
                    child: Text(
                      'n',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(
                        color: Colors.yellow,
                        fontFamily: 'Peace',
                        height: 0.8,
                        fontSize: 35
                      ),
                    ),
                  ),
                  Text(
                    'Bengali',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontFamily: 'Peace',
                      fontSize: 35
                    ),
                  ),
                ],
              ),
              Text(
                '“এবার প্রস্তুতি হোক মাতৃভাষায়”',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Bengali',
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
