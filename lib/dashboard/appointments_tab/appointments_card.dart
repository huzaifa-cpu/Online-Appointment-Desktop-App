import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_hospital_desktop_app/change_notifier/appointment_provider.dart';
import 'package:side_hospital_desktop_app/constraints/custom_colors.dart';
import 'package:side_hospital_desktop_app/models/appointment.dart';
import 'package:side_hospital_desktop_app/screens/book_appointment.dart';
import 'package:side_hospital_desktop_app/screens/loader.dart';
import 'package:side_hospital_desktop_app/services/appointment_service.dart';
import 'package:side_hospital_desktop_app/widgets/custom_dialog.dart';
import 'package:side_hospital_desktop_app/widgets/custom_medium_button.dart';
import 'package:side_hospital_desktop_app/widgets/custom_text_light.dart';

class AppointmentsCard extends StatelessWidget {
  Appointment app;
  int index;
  AppointmentsCard({this.app, this.index});

  final AppointmentService appointmentService = AppointmentService();

  @override
  Widget build(BuildContext context) {
    CustomColors _colors = new CustomColors();

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
              name: "${app.doctor.name}",
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
            ),
          ),
          Consumer<AppointmentProvider>(
            builder: (context, appointmentProvider, child) => Expanded(
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
                              ? "Mark appointment as done?"
                              : "Reschedule appointment",
                          btn1Text: "Yes",
                          btn2Text: "No",
                          onPressed1: () async {
                            if (app.state) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Loader("Please wait...")));
                              Appointment appointment = Appointment(
                                  appointmentId: app.appointmentId,
                                  patient: app.patient,
                                  doctor: app.doctor,
                                  date: app.date,
                                  time: app.time,
                                  state: false);

                              await appointmentService.cancelAppointment(
                                  appointment,
                                  app.appointmentId.patientId,
                                  app.appointmentId.doctorId);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Appointment has been marked as done")));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return BookAppointment(
                                      isAdd: false,
                                      app: app,
                                    );
                                  });
                            }
                            List<Appointment> appointmentList =
                                await appointmentService.getAppointmentList();
                            appointmentProvider.appoint = appointmentList;
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
