import 'dart:async';
import './mostrar_alerta.dart';

Future<void> alertException(Future<void> Function() func, {bool shouldRethrow = true}) async {
  try {
    await func();
  } catch (error) {
    // final message = error is dynamic && error.response != null ? error.response.data.toString() : error.toString();
    final message = error.toString();
    mostrarAlerta(message, 'ERROR');
    print(error);
    if (shouldRethrow) {
      throw error;
    }
  }
}
