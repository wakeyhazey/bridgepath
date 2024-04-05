import 'package:bridgepath/blocs/access_bloc.dart';
import 'package:bridgepath/pages/home_pages.dart';
import 'package:bridgepath/ui/access/login_widget.dart';
import 'package:bridgepath/ui/access/register_widget.dart';
import 'package:bridgepath/ui/logo_woidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(),
            BlocConsumer<AccessBloc, AccessStates>(listener: (context, state) {
              if (state is Authenticated) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const HomePage())).then((value) =>
                    context.read<AccessBloc>().add(ShowNotAuthenticated()));
              }
            }, builder: (context, state) {
              if (state is NotAuthenticated) {
                return LoginWidget();
              } else if (state is RegisterView) {
                return RegisterWidget();
              } else if (state is AccessError) {
                return Column(
                  children: [
                    Text(state.errorMessage),
                    IconButton(
                      onPressed: () {
                        context.read<AccessBloc>().add(ShowNotAuthenticated());
                      },
                      icon: const Icon(Icons.arrow_back),
                    )
                  ],
                );
              }

              return const CircularProgressIndicator(
                color: Colors.black,
              );
            }),
          ],
        ),
      ),
    );
  }
}
