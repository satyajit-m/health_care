import 'package:flutter/material.dart';
import 'package:health_care/auth/LoginPage.dart';

import 'package:health_care/auth/patient/auth.dart';
import 'package:health_care/auth/patient/phone/otp_page.dart';
import 'package:health_care/auth/patient/phone/phone_auth.dart';
import 'package:health_care/services/router_models.dart';
import 'package:health_care/src/agents/agent_app.dart';
import 'package:health_care/src/agents/exist_patient/exist_search.dart';
import 'package:health_care/src/agents/exist_patient/patient_view.dart';
import 'package:health_care/src/agents/new_agent/AgentCall.dart';
import 'package:health_care/src/agents/new_patient/new_patcall.dart';
import 'package:health_care/src/patients/pat_app.dart';

import '../OnBoard.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/onboard':
        return MaterialPageRoute(builder: (_) => OnBoard());

      case '/auth':
        return MaterialPageRoute(
          builder: (_) {
            if (settings.arguments == null) {
              return Auth(next: Destination());
            }
            return Auth(next: settings.arguments);
          },
        );

      case '/agentform':
        return MaterialPageRoute(builder: (_) => AgentCall());

      case '/':
        return MaterialPageRoute(
          builder: (_) {
            if (settings.arguments == null) {
              return LoginPage(next: Destination());
            }
            return LoginPage(next: settings.arguments);
          },
        );

      case '/auth/phone':
        return MaterialPageRoute(
          builder: (_) {
            assert(settings.arguments != null);
            return PhoneLogin(data: settings.arguments);
          },
        );

      case '/auth/phone/otp':
        return MaterialPageRoute(
          builder: (_) {
            assert(settings.arguments != null);
            return OtpPage(settings.arguments);
          },
        );

      //Agents

      case '/agenthome':
        return MaterialPageRoute(builder: (_) => AgentApp());

      case '/newpat':
        return MaterialPageRoute(builder: (_) => NewPatCall());

      case '/existpat':
        return MaterialPageRoute(builder: (_) => ExistSearch());

      case '/patview':
        return MaterialPageRoute(
            builder: (_) => PatientView(
                  prof: settings.arguments,
                ));

      //Patients
      case '/pathome':
        return MaterialPageRoute(builder: (_) => PatApp());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
