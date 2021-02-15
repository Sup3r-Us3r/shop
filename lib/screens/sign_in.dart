import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop/blocs/user_bloc.dart';
import 'package:shop/screens/home_page.dart';
import 'package:shop/widgets/button_action.dart';
import 'package:shop/widgets/text_input_custom.dart';
import 'package:shop/constants/colors.dart';

class SignIn extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double _sizeHeight = MediaQuery.of(context).size.height;
    final UserBloc _userBloc = Provider.of<UserBloc>(context);

    void _login() async {
      bool response = await _userBloc.login(
        _emailController.value.text,
        _passwordController.value.text,
      );

      if (response) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => HomePage(),
          ),
        );
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: _sizeHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300.0,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                AssetImage('assets/images/authbackground.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 130.0,
                        left: 20.0,
                        child: Text(
                          'Bem-vindo\nNovamente',
                          style: TextStyle(
                            color: colorBlack,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30.0,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            MaterialIcons.keyboard_arrow_left,
                            color: colorWhite,
                            size: 40.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInputCustom(
                        icon: MaterialCommunityIcons.email_outline,
                        label: 'E-mail',
                        controller: _emailController,
                      ),
                      SizedBox(height: 10.0),
                      TextInputCustom(
                        icon: MaterialCommunityIcons.lock_outline,
                        label: 'Senha',
                        typePassword: true,
                        controller: _passwordController,
                      ),
                      SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: () => _login(),
                        child: ButtonAction(label: 'Entrar'),
                      ),
                      SizedBox(height: 10.0),
                      ButtonAction(label: 'Entrar com Google'),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1.0,
                                color: colorDarkGray,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'ou',
                                style: TextStyle(
                                  color: colorDarkGray,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1.0,
                                color: colorDarkGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ButtonAction(
                        label: 'Registrar',
                        redirectsToAnotherPage: true,
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: colorWhite,
    );
  }
}
