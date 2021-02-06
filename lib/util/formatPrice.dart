import 'package:intl/intl.dart';

String formatPrice(double priceValue) {
  NumberFormat _value = NumberFormat('###.00#', 'pt_BR');

  return 'R\$ ${_value.format(priceValue)}';
}
