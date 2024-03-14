import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';

class StepperPickUp extends StatefulWidget {
  const StepperPickUp({super.key});

  @override
  State<StepperPickUp> createState() => _StepperPickUp();
}

class _StepperPickUp extends State<StepperPickUp> {
  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Lokasi Jemput",
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: StepperText("Jl. Jalanin aja dulu",
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Color(0xff6FD73E),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.location_on_outlined, color: Colors.white),
        )),
    StepperData(
        title: StepperText(
          "Lokasi Driver",
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: StepperText("Jalan Sampai di sini",
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Color(0xff0185FF),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child:
              const Icon(Icons.circle_outlined, size: 14, color: Colors.white),
        )),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Perjalanan',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: AnotherStepper(
              stepperList: stepperData,
              stepperDirection: Axis.vertical,
              iconWidth: 40,
              iconHeight: 40,
              activeBarColor: Color(0xffC3C3C3),
              inActiveBarColor: Colors.grey,
              inverted: false,
              verticalGap: 40,
              activeIndex: 1,
              barThickness: 8,
            ),
          ),
        ],
      ),
    );
  }
}
