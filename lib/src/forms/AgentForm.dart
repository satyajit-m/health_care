import 'package:flutter/material.dart';
import 'blocs/bloc.dart';
import 'blocs/provider.dart';

class AgentForm extends StatefulWidget {
  @override
  _AgentFormState createState() => _AgentFormState();
}

class _AgentFormState extends State<AgentForm> {
  int currentStep = 0;
  bool complete = false;
  int length = 0;

  List<Step> getSteps(Bloc bloc) {
    List<Step> steps = [
      Step(
        title: const Text('Personal Details'),
        isActive: true,
        state: StepState.complete,
        content: Column(
          children: <Widget>[
            StreamBuilder(
              stream: bloc.name,
              builder: (context, snapshot) {
                return TextField(
                    onChanged: bloc.changeName,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      hintText: 'John Doe',
                      labelText: 'Name',
                      errorText: snapshot.error,
                    ));
              },
            ),
            StreamBuilder(
              stream: bloc.email,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: bloc.changeEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'ypu@example.com',
                    labelText: 'Email Address',
                    errorText: snapshot.error,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // Step(
      //   title: const Text('Personal Details'),
      //   isActive: false,
      //   state: StepState.editing,
      //   //content:
      // ),
    ];
    length = steps.length;
    return steps;
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  next() {
    currentStep + 1 != length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create an account'),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(bloc),
            currentStep: currentStep,
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(children: <Widget>[
                StreamBuilder(
                    stream: bloc.submitValid,
                    builder: (context, snapshot) {
                      return RaisedButton(
                        child: Text('Complete'),
                        color: Colors.green,
                        onPressed: snapshot.hasData ? next : null,
                      );
                    }),
                SizedBox(
                  width: 30,
                ),
                RaisedButton(
                  child: Text('Back'),
                  color: Colors.red,
                  onPressed: onStepCancel,
                )
              ]);
            },
            onStepContinue: next,
            onStepCancel: cancel,
          ),
        ),
      ]),
    );
  }
}
