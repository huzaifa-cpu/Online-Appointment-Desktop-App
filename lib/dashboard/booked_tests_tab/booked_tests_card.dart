import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_hospital_desktop_app/change_notifier/patient_test_provider.dart';
import 'package:side_hospital_desktop_app/constraints/custom_colors.dart';
import 'package:side_hospital_desktop_app/models/booked_test.dart';
import 'package:side_hospital_desktop_app/screens/book_test.dart';
import 'package:side_hospital_desktop_app/screens/loader.dart';
import 'package:side_hospital_desktop_app/services/book_test_service.dart';
import 'package:side_hospital_desktop_app/widgets/custom_dialog.dart';
import 'package:side_hospital_desktop_app/widgets/custom_medium_button.dart';
import 'package:side_hospital_desktop_app/widgets/custom_text_light.dart';

class BookedTestsCard extends StatelessWidget {
  CustomColors _colors = new CustomColors();
  final PatientTestService patientTestService = PatientTestService();

  PatientTest app;
  int index;
  BookedTestsCard({this.app, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: CustomTextLight(
              name: "${(index + 1).toString()}",
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomTextLight(
              name: "${app.test.name}",
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomTextLight(
              name: "${app.patient.name}",
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomTextLight(
              name: "${app.date}",
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomTextLight(
              name: "${app.time}",
            ),
          ),
          Expanded(
              flex: 2,
              child: CustomTextLight(
                name: app.state ? "In Progress" : "Completed",
              )),
          Consumer<PatientTestProvider>(
            builder: (context, patientTestProvider, child) => Expanded(
              flex: 2,
              child: CustomMediumButton(
                name: app.state ? "Mark as done" : "Reschedule",
                icon: app.state ? Icons.check : Icons.mark_chat_read,
                color: app.state ? _colors.purple : _colors.green,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlertDialog(
                          title: app.state
                              ? "Mark booked test as done?"
                              : "Reschedule test",
                          btn1Text: "Yes",
                          btn2Text: "No",
                          onPressed1: () async {
                            if (app.state) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Loader("Please wait...")));
                              PatientTest patientTest = PatientTest(
                                  patientTestId: app.patientTestId,
                                  patient: app.patient,
                                  test: app.test,
                                  date: app.date,
                                  time: app.time,
                                  state: false);
                              await patientTestService.cancelPatientTest(
                                  patientTest,
                                  app.patientTestId.patientId,
                                  app.patientTestId.testId);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Booked Test has been marked as done")));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return BookTest(
                                      isAdd: false,
                                      app: app,
                                    );
                                  });
                            }
                            List<PatientTest> patientTestList =
                                await patientTestService.getPatientTestList();
                            patientTestProvider.test = patientTestList;
                          },
                          onPressed2: () {
                            Navigator.pop(context);
                          },
                        );
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
