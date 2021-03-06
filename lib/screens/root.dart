import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/blocs/details_bloc.dart';
import 'package:shop/blocs/user_bloc.dart';
import 'package:shop/screens/home_page.dart';
import 'package:shop/screens/sign_in.dart';

enum AuthState {
  notLoggedIn,
  loggedIn,
}

class Root extends StatefulWidget {
  @override
  _Root createState() => _Root();
}

class _Root extends State<Root> {
  AuthState _authState = AuthState.notLoggedIn;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    UserBloc _userBloc = Provider.of<UserBloc>(context, listen: false);
    DetailsBloc _detailsBloc = Provider.of<DetailsBloc>(context, listen: false);

    bool userSigned = await _userBloc.getUserPrefs();
    await _detailsBloc.getDetailsBlocState();

    if (userSigned) {
      setState(() {
        _authState = AuthState.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget startPage;

    switch (_authState) {
      case AuthState.notLoggedIn:
        startPage = SignIn();
        break;
      case AuthState.loggedIn:
        startPage = HomePage();
        break;
      default:
    }

    return startPage;
  }
}
