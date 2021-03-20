import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_hospital_desktop_app/change_notifier/doctor_provider.dart';
import 'package:side_hospital_desktop_app/change_notifier/test_provider.dart';
import 'package:side_hospital_desktop_app/constraints/custom_colors.dart';
import 'package:side_hospital_desktop_app/dashboard/doctors_tab/edit_doctor.dart';
import 'package:side_hospital_desktop_app/dashboard/settings_tab/settings_card.dart';
import 'package:side_hospital_desktop_app/dashboard/tests_tab/edit_test.dart';
import 'package:side_hospital_desktop_app/models/doctor.dart';
import 'package:side_hospital_desktop_app/models/test.dart';
import 'package:side_hospital_desktop_app/screens/create_patient.dart';
import 'package:side_hospital_desktop_app/screens/loader.dart';
import 'package:side_hospital_desktop_app/services/doctor_service.dart';
import 'package:side_hospital_desktop_app/services/test_service.dart';
import 'package:side_hospital_desktop_app/widgets/custom_text_dark.dart';

class SettingsTab extends StatelessWidget {
  final DoctorService doctorService = DoctorService();
  final TestService testService = TestService();
  CustomColors _colors = CustomColors();
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              SettingsCard(
                name: "Add Doctor",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return EditDoctor(
                          isAdd: true,
                        );
                      });
                },
              ),
              SizedBox(
                width: 30,
              ),
              SettingsCard(
                name: "Add Test",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return EditTest(
                          isAdd: true,
                        );
                      });
                },
              )
            ],
          ),
          Row(
            children: [
              Consumer<DoctorProvider>(
                  builder: (context, doctorProvider, child) {
                if (doctorProvider.doctor.isNotEmpty) {
                  return SettingsCard(
                    name: "Book Appointment",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CreatePatient(
                              isTest: false,
                            );
                          });
                    },
                  );
                } else {
                  return SettingsCard(
                    name: "No Doctors available",
                    onPressed: () {},
                  );
                }
              }),
              SizedBox(
                width: 30,
              ),
              Consumer<TestProvider>(builder: (context, testProvider, child) {
                if (testProvider.test.isNotEmpty) {
                  return SettingsCard(
                    name: "Book Test",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CreatePatient(
                              isTest: true,
                            );
                          });
                    },
                  );
                } else {
                  return SettingsCard(
                    name: "No Tests available",
                    onPressed: () {},
                  );
                }
              }),
            ],
          )
        ],
      ),
    );
  }
}
