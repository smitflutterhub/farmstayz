import 'package:flutter/material.dart';
import 'package:flutter_onboarding/flutter_onboarding.dart';
import 'package:flutter_onboarding/onboarding_model.dart';
import 'choice.dart';

class Description extends StatefulWidget {
  const Description({Key? key}) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      IntroModel(
        title: 'Book Farm house for 24/7',
        description:
        'Farm house with luxurious facility\n\nAvailable for 12 and 24 hours',
        titleColor: Colors.black,
        descriptionColor: Colors.black,
        imagePath: 'assets/_SPJ5184-Edited.jpg',
      ),
      IntroModel(
        title: 'Book Farm house for 24/7',
        description:
        'Farm house with swimming pools\n\nAnd A.C. halls',
        titleColor: Colors.black,
        descriptionColor: Colors.black,
        imagePath: 'assets/delhi farmhouse.png',
      ),
      IntroModel(
        title: 'Book Farm house for 24/7',
        description:
        'Celebrate with us in unique way\n\nAvailable for any events',
        titleColor: Colors.black,
        descriptionColor: Colors.black,
        imagePath: 'assets/experience-e1584015247492.jpg',
      ),
    ];
    return SafeArea(
      child: Scaffold(
        body: FlutterOnBoarding(
          imageHeight: 400,
          imageWidth: 400,
          activeIndicatorColor: Colors.black,
          nextButtonColor: Colors.black,
          skipButtonTextStyle: const TextStyle(color: Colors.black,fontSize: 20),
          getStartedButtonSize: const Size(200, 80),
          getStartedButtonTextStyle: const TextStyle(
              fontSize: 25,
              color: Colors.white
          ),
          inactiveIndicatorColor: Colors.grey,
          getStartedButtonDecoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(80)
          ),
          pages: pages,
          backgroundColor: Colors.white,
          onGetStartedRoute: MaterialPageRoute(
            builder: (context) => const Choices(),
          ),
        ),
      ),
    );
  }
}
