import 'package:flutter/material.dart';
import 'package:tratour/globalVar.dart';

class IntroPage3_Test extends StatefulWidget {
  const IntroPage3_Test({Key? key, required this.globalVar}) : super(key: key);
  final GlobalVar globalVar;

  @override
  State<IntroPage3_Test> createState() => _IntroPage3_TestState();
}

class _IntroPage3_TestState extends State<IntroPage3_Test> {
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.globalVar.selected_role_onboarding;
  }

  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () => setState(() => _value = 0),
              child: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _value == 0 ? Colors.black : Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.call),
              ),
            ),
            SizedBox(width: 4),
            GestureDetector(
              onTap: () => setState(() => _value = 1),
              child: Container(
                height: 56,
                width: 56,
                color: _value == 1 ? Colors.grey : Colors.transparent,
                child: Icon(Icons.message),
              ),
            ),
            SizedBox(width: 4),
            GestureDetector(
              onTap: () => setState(() => _value = 2),
              child: Container(
                height: 56,
                width: 56,
                color: _value == 2 ? Colors.grey : Colors.transparent,
                child: Icon(Icons.person),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
