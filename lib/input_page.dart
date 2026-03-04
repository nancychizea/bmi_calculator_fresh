import 'package:bmi_fresh/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'results_page.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  const InputPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color maleCardColor = inactiveCardColor;
  Color femaleCardColor = inactiveCardColor;
  int height = 180;
  int weight = 60;
  int age = 20;

  Gender? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        title: Center(
          child: const Text(
            'BMI CALCULATOR',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.male;
                        });
                      },
                      colour: selectedGender == Gender.male
                          ? activeColor
                          : inactiveCardColor,
                      cardChild: Center(
                        child: IconContent(
                          icon: FontAwesomeIcons.mars,
                          label: "MALE",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.female;
                        });
                      },
                      colour: selectedGender == Gender.female
                          ? activeColor
                          : inactiveCardColor,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.venus,
                        label: "FEMALE",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                onPress: () {},
                colour: inactiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("HEIGHT", style: labelTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(height.toString(), style: numberTextStyle),
                        const Text(
                          'cm',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF8D8E98),
                          ),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 15,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 30,
                        ),
                        thumbColor: const Color(0xffEB1555),
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: const Color(0xFF8D8E98),
                        overlayColor: const Color(0x29EB1555),
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120,
                        max: 220,

                        // activeColor: const Color(0xffEB1555),
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                      onPress: () {},
                      colour: inactiveCardColor, cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("WEIGHT", style: labelTextStyle),
                          Text(weight.toString(), style: numberTextStyle),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(icon: Icons.add, onPressed: () { setState(() { weight++; }); }),
                              const SizedBox(width: 10),
                              RoundIconButton(icon: Icons.remove, onPressed: () { setState(() { weight--; }); }),
                            ],
                          ),
                        ],
                    ),
                  ),),
                  // ignore: prefer_const_constructors
                  Expanded(
                    child: ReusableCard(
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("AGE", style: labelTextStyle),
                          Text(age.toString(), style: numberTextStyle),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(icon: FontAwesomeIcons.plus, onPressed: () { setState(() { age++; }); }),
                              const SizedBox(width: 10),
                              RoundIconButton(icon: FontAwesomeIcons.minus, onPressed: () { setState(() { age--; }); }),
                            ],
                          ),
                        ],
                      ),
                      onPress: () {},
                      colour: inactiveCardColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResultsPage()),
                );
              },
              child: Container(
                color: const Color(0xffEB1555),
                width: bottomContainerWidth,
                height: 80,
                margin: const EdgeInsets.only(top: 10),
                child: const Center(
                  child: Text(
                    'CALCULATE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}



class RoundIconButton extends StatelessWidget {
  const RoundIconButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
      fillColor: Theme.of(context).colorScheme.primaryContainer,
      constraints: const BoxConstraints.tightFor(width: 40, height: 48),
      onPressed: onPressed,
      child: Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
    );
  }
}