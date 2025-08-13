import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo({
    required this.title,
    required this.caption,
    required this.imageUrl,
  });
}

final slides = <SlideInfo>[
  SlideInfo(
    title: 'Bienvenido a Widgets App',
    caption: 'Explora los widgets de Flutter',
    imageUrl: 'assets/images/1.png',
  ),
  SlideInfo(
    title: 'Botones y Controles',
    caption: 'Descubre los diferentes tipos de botones',
    imageUrl: 'assets/images/2.png',
  ),
  SlideInfo(
    title: 'Tarjetas y Contenedores',
    caption: 'Aprende a usar tarjetas para mostrar información',
    imageUrl: 'assets/images/3.png',
  ),
];

class AppTutorialScreen extends StatefulWidget {
  static const String name = 'app_tutorial_screen';
  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {
  final PageController pageViewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      final page = pageViewController.page ?? 0;
      if (!endReached && page >= (slides.length - 1.5)) {
        setState(() {
          endReached = true;
        });
      }
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            PageView(
              controller: pageViewController,
              physics: const BouncingScrollPhysics(),
              children: slides.map((slide) {
                return _Slide(
                  title: slide.title,
                  caption: slide.caption,
                  imageUrl: slide.imageUrl,
                );
              }).toList(),
            ),
            Positioned(
              right: 20,
              top: 50,
              child: TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Saltar tutorial'),
              ),
            ),
            endReached
                ? Positioned(
                    left: 30,
                    bottom: 30,
                    child: FadeInRight(
                      from: 15,
                      delay: Duration(seconds: 1),
                      child: FilledButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('Comenzar'),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;

  const _Slide({
    required this.title,
    required this.caption,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage(imageUrl)),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: titleStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              caption,
              style: captionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
