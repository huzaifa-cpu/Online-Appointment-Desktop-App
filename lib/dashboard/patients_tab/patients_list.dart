import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_hospital_desktop_app/change_notifier/patient_provider.dart';
import 'package:side_hospital_desktop_app/dashboard/patients_tab/patients_card.dart';
import 'package:side_hospital_desktop_app/models/patient.dart';
import 'package:side_hospital_desktop_app/screens/loader.dart';
import 'package:side_hospital_desktop_app/services/patient_service.dart';
import 'package:side_hospital_desktop_app/widgets/custom_text_dark.dart';

class PatientsTab extends StatefulWidget {
  @override
  _DoctorsTabState createState() => _DoctorsTabState();
}

class _DoctorsTabState extends State<PatientsTab> {
  final PatientService patientService = PatientService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "No",
                )),
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "Name",
                )),
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "Age",
                )),
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "Gender",
                )),
            Expanded(
                flex: 1,
                child: CustomTextDark(
                  name: "Phone no",
                )),
            Expanded(
              flex: 2,
              child: Text(
                "",
              ),
            ),
          ],
        ),
        Divider(),
        Expanded(child: Consumer<PatientProvider>(
            builder: (context, patientProvider, child) {
          List<Patient> patient = patientProvider.patient;
          return patient.length == 0
              ? Center(
                  child: CustomTextDark(
                    name: "No Patients",
                  ),
                )
              : ListView.builder(
                  itemCount: patient.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: PatientsCard(patient: patient[i], index: i),
                    );
                  },
                );
        })),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
