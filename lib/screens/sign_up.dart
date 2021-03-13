import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop/blocs/user_bloc.dart';
import 'package:shop/constants/colors.dart';
import 'package:shop/util/toast.dart';
import 'package:shop/widgets/button_action.dart';
import 'package:shop/widgets/text_input_custom.dart';

class SignUp extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _imagePath = '';

  @override
  Widget build(BuildContext context) {
    final double _sizeHeight = MediaQuery.of(context).size.height;
    final UserBloc _userBloc = Provider.of<UserBloc>(context);

    Future handlePhoto() async {
      final ImagePicker picker = ImagePicker();

      try {
        var response = await picker.getImage(source: ImageSource.gallery);

        _imagePath = response.path;

        _userBloc.updatePhoto(_imagePath);
      } on PlatformException catch (_) {
        return;
      } catch (_) {
        return;
      }
    }

    void _register() async {
      bool response = await _userBloc.register(
        _nameController.value.text,
        _emailController.value.text,
        _passwordController.value.text,
        _imagePath,
      );

      if (response) {
        toastSuccess('Usuário criando com sucesso');

        Navigator.of(context).pushNamedAndRemoveUntil(
          '/signIn',
          (route) => false,
        );
      }
    }

    void _signInPage() {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/signIn',
        (route) => false,
      );
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
                    alignment: Alignment.center,
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
                      _userBloc.photoChanged.length != 0
                          ? Positioned(
                              top: 60.0,
                              child: GestureDetector(
                                onTap: handlePhoto,
                                child: Container(
                                  height: 200.0,
                                  width: 200.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      File(_userBloc.photoChanged),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Positioned(
                              top: 60.0,
                              child: GestureDetector(
                                onTap: handlePhoto,
                                child: Container(
                                  height: 200.0,
                                  width: 200.0,
                                  decoration: BoxDecoration(
                                    color: colorBrown.withAlpha(70),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(
                                    EvilIcons.camera,
                                    size: 80.0,
                                    color: colorWhite,
                                  ),
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
                        icon: AntDesign.user,
                        label: 'Nome',
                        controller: _nameController,
                      ),
                      SizedBox(height: 10.0),
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
                        onTap: _register,
                        child: ButtonAction(label: 'Criar conta'),
                      ),
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
                      GestureDetector(
                        onTap: _signInPage,
                        child: ButtonAction(
                          label: 'Fazer login',
                          redirectsToAnotherPage: true,
                        ),
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
