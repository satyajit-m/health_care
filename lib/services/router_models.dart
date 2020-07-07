import 'package:health_care/const/route_constants.dart';

class Destination {
  String route;
  String popUntilRoute;
  Destination([this.route = AgentHomeRoute, this.popUntilRoute = AuthRoute]);
}

class OtpPageData {
  String number;
  Destination next;
  OtpPageData(this.number, this.next);
}

class AgentHomeData {
  String email;
  AgentHomeData(this.email);
}
