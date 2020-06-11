class Formaters {
  static String telefoneFormmater(String telefone){
    var telefoneFormatado = telefone.split('').toList();
    telefoneFormatado.insert(0, '(');
    telefoneFormatado.insert(3, ')');
    telefoneFormatado.insert(4, ' ');
    telefoneFormatado.insert(10, '-');
    return telefoneFormatado.join();
  }

  static String nomeFormmater(String nome){
    var nomeSeparado = nome.split(' ');
    return "${nomeSeparado[0]} ${nomeSeparado[1]}";
  }
}