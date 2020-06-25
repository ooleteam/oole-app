import 'package:flutter/material.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class PlanoDePagamento extends StatefulWidget {
  @override
  _PlanoDePagamentoState createState() => _PlanoDePagamentoState();
}

class _PlanoDePagamentoState extends State<PlanoDePagamento> {
  final _form = GlobalKey<FormState>();
  var _formData = Map<String, Object>();

  @override
  void didChangeDependencies() {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    if (userProvider.hasCartao) {
      setState(() {
        _formData = userProvider.cartao;
      });
    }
    super.didChangeDependencies();
  }

  _save() async {
    _form.currentState.save();
    String nome = Provider.of<UserProvider>(context, listen: false)
        .createCartao(_formData);
    return await showDialog<Null>(
      context: context,
      builder: (ctx) => AlertDialog(
        title:
            Text("Cadastro concluido! \n O cartão de $nome, já pode ser usado"),
        content: Icon(Icons.check_circle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                "Número do cartão",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                child: TextFormField(
                  initialValue: _formData['numeroDoCartao'],
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Colors.green[200],
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  cursorColor: Colors.black,
                  onSaved: (value) => _formData['numeroDoCartao'] = value,
                  validator: (value) {
                    if (value.trim().length != 16) {
                      return 'Informe um cartão válido';
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Data de Expiração",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                child: TextFormField(
                  initialValue: _formData['dataDeExpiracao'],
                  keyboardType: TextInputType.datetime,
                  maxLength: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Colors.green[200],
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  cursorColor: Colors.black,
                  onSaved: (value) => _formData['dataDeExpiracao'] = value,
                  validator: (value) {
                    if (value.length != 5) {
                      return 'Informe um uma data válida';
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Código de Segurança",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  initialValue: _formData['codigoDeSeguranca'],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Colors.green[200],
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  cursorColor: Colors.black,
                  onSaved: (value) => _formData['codigoDeSeguranca'] = value,
                  validator: (value) {
                    if (value.length != 3) {
                      return 'Informe um titulo válido';
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Nome do titular",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                child: TextFormField(
                  initialValue: _formData['nomeDoTitular'],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Colors.green[200],
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  cursorColor: Colors.black,
                  onSaved: (value) => _formData['nomeDoTitular'] = value,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Informe um titulo válido';
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Plano de pagamento",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 2,
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Mensal",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "R\$ 28",
                              style: TextStyle(fontSize: 22),
                            ),
                            Radio(
                              value: "mensal",
                              autofocus: true,
                              activeColor: Colors.green[400],
                              groupValue: _formData['planoDePagamento'],
                              onChanged: (value) {
                                setState(() {
                                  _formData['planoDePagamento'] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Semestral",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "R\$ 60",
                              style: TextStyle(fontSize: 22),
                            ),
                            Radio(
                              value: "semestral",
                              groupValue: _formData['planoDePagamento'],
                              activeColor: Colors.green[400],
                              onChanged: (value) {
                                setState(() {
                                  _formData['planoDePagamento'] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Anual",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "R\$ 110",
                              style: TextStyle(fontSize: 22),
                            ),
                            Radio(
                              value: "anual",
                              groupValue: _formData['planoDePagamento'],
                              activeColor: Colors.green[400],
                              onChanged: (value) {
                                setState(() {
                                  _formData['planoDePagamento'] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              RaisedButton(
                child: Text("Save"),
                onPressed: () async {
                  _save();
                  await showDialog<Null>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Cadastro concluido!"),
                      content: Icon(Icons.check_circle),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
