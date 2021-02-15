import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/constants/colors.dart';

void toastError(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: colorBlack.withAlpha(200),
    fontSize: 16.0,
    gravity: ToastGravity.SNACKBAR,
    textColor: colorWhite,
    timeInSecForIosWeb: 3,
    toastLength: Toast.LENGTH_LONG,
  );
}

void toastSuccess(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: colorBrown.withAlpha(200),
    fontSize: 16.0,
    gravity: ToastGravity.SNACKBAR,
    textColor: colorWhite,
    timeInSecForIosWeb: 3,
    toastLength: Toast.LENGTH_LONG,
  );
}
