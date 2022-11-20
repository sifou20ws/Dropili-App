import 'package:dropili/Presentation/authentification/comun_widgets/fields_decoration.dart';
import 'package:dropili/common/extensions/translation_extension.dart';
import 'package:dropili/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dropili/Presentation/authentification/bloc/auth_bloc.dart';
import 'package:dropili/Presentation/authentification/comun_widgets/message_widget.dart';
import 'package:dropili/Presentation/authentification/comun_widgets/progress_indicator.dart';

import 'package:dropili/di/get_it.dart' as getIt;

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  late AuthBloc _authBloc;
  @override
  void initState() {
    _authBloc = AuthBloc(getIt.getItInstace<AuthRepository>());
    super.initState();
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state.status == Status.success) {
            await Future.delayed(Duration(seconds: 3));
            Navigator.pushReplacementNamed(context, '/singin');
          }
        },
        child: Scaffold(
            body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.only(left: 100, right: 100),
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('assets/Background.png'),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 45, right: 45),
                        child: Column(
                          children: [
                            Text(
                              'Restore your password'.t(context),
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FormWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            state.status == Status.loading
                                ? LoadingIndicatorWidget(
                                    text: 'Soumission...',
                                  )
                                : ResetButton(),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 140, right: 140),
                        child: Image(image: AssetImage('assets/dropili.png')),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class ResetButton extends StatelessWidget {
  const ResetButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(RestoreSubmittingEvent());
        },
        child: Text(
          'Submit'.t(context),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.blue,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          context.read<AuthBloc>().state.status == Status.fail
              ? MessageWidget(
                  color: 'red',
                  text: context.read<AuthBloc>().state.errorMessage)
              : context.read<AuthBloc>().state.status == Status.success
                  ? MessageWidget(
                      color: 'green',
                      text: 'Recovery link sent to email',
                    )
                  : Container(),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            onChanged: (value) {
              BlocProvider.of<AuthBloc>(context)
                  .add(EmailTextChangeEvent(value));
            },
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            decoration: buildInputDecoration(text: 'Email'),
            validator: null,
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
