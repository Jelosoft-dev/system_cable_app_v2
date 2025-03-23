

class Validaciones{

  
  static bool esFechaValida(int anho, int mes, int dia) {
    try {
      DateTime fecha = DateTime(anho, mes, dia);
      // Si llegamos aquí, la fecha es válida
      return true;
    } catch (e) {
      // Si hay una excepción, la fecha no es válida
      return false;
    }
  }
}