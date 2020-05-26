import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oole_app/models/NewUser.dart';
import 'package:oole_app/utils/app-routes.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _posicoes = ['Centroavante','Atacante','Ponta Direita','Ponta Esquerda',
                    'Meia-Atacantes','Meia Direita','Meia Esquerda', 'Meia Central', 'Volante', 
                    'Lateral Direito','Lateral Esquerdo','Zagueiro Direito','Zagueiro Esquerdo','Zagueiro Central',
                    'Goleiro'];
  final _sexos = ['Masculino', 'Feminino'];
  final _tipos = [
    'Jogador',
    'Olheiro',
  ];

  var _sexo = 'Selecione o sexo*';
  var _posicao = 'Selecione a posição*';
  var _tipo = [0,'Selecione o tipo*'];

  final NewUser _user = NewUser();


  _posicaoJogador(){
    if (_tipo[0]==1){
      return Container (
        width: (MediaQuery.of(context).size.width/100) * 85,
        height: (MediaQuery.of(context).size.height/100) * 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.green[400],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
        child: DropdownButton(

          items: _posicoes.map((String posicao) => DropdownMenuItem(value: posicao,child: Text(posicao))).toList(),
          onChanged: (String posicao) {
            setState(() {
              _posicao = posicao;
              _user.posicao = posicao;
            });
          },
          hint: Text(
            _posicao,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
        )
      );
    }

    return Container();
  }


  _saudeJogador(){
    if (_tipo[0]==1){
      return Container (
        width: (MediaQuery.of(context).size.width/100) * 85,
        height: (MediaQuery.of(context).size.height/100) * 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.green[400],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
        child: TextFormField(
          onChanged: (String value) {
            setState(() {
              _user.problemaSaude = value;
            });
          },
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            hintText: "Você tem algum problema de saúde?\n"
                     +"Se sim, Qual?",
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
        ),
      );
    }

    return Container();
  } 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF008140),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[


              Container(
                width: MediaQuery.of(context).size.width/3,
                height: MediaQuery.of(context).size.height/4,
                child: Image.asset(
                  "images/oole-logo.png",
                  fit: BoxFit.fitWidth,
                ),
              ),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      _user.login = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Login*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  
                  onChanged: (String value) {
                    setState(() {
                      _user.senha = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Senha*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      _user.nome = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Nome Completo*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  // keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: <TextInputFormatter> [
                    LengthLimitingTextInputFormatter(10),
                    BlacklistingTextInputFormatter.singleLineFormatter
                  ],
                  onChanged: (String value) {
                    setState(() {
                      _user.dataNascimento = value;
                    });
                  },
                  //^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Data de Nascimento*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter> [
                    LengthLimitingTextInputFormatter(11),
                    BlacklistingTextInputFormatter.singleLineFormatter
                  ],
                  onChanged: (String value) {
                    setState(() {
                      _user.cpf = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "CPF*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: DropdownButton(
                  
                  items: _sexos.map((String sexo) => DropdownMenuItem(value: sexo,child: Text(sexo))).toList(),
                  onChanged: (String sexo) {
                    setState(() {
                      _sexo = sexo;
                      _user.sexo = sexo;
                    });
                    print(_sexo);
                  },
                  hint: Text(
                    _sexo,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                )
              ),

              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: DropdownButton(
                  
                  items: _tipos.map((String tipo) => DropdownMenuItem(value: tipo,child: Text(tipo))).toList(),
                  onChanged: (String tipo) {
                    setState(() {
                      if(tipo=='Jogador'){
                        _tipo = [1,tipo];
                      }else if(tipo=='Olheiro'){
                        _tipo = [2,tipo];
                      }
                      _user.tipo = _tipo[0];
                    });
                  },
                  hint: Text(
                    _tipo[1],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                )
              ),


              _posicaoJogador(),


              _saudeJogador(),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      _user.nacionalidade = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Nacionalidade*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter> [
                    LengthLimitingTextInputFormatter(8),
                    BlacklistingTextInputFormatter.singleLineFormatter
                  ],
                  onChanged: (String value) {
                    setState(() {
                      _user.cep = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "CEP*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      _user.endereco = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Endereço*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      _user.bairro = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Bairro*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      _user.cidade = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Cidade*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),



              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      _user.estado = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Estado*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      _user.email = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Email*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),


              Container (
                width: (MediaQuery.of(context).size.width/100) * 85,
                height: (MediaQuery.of(context).size.height/100) * 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green[400],
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 2),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      _user.telefone = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Telefone*",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),


              Container(
                width: (MediaQuery.of(context).size.width/100) * 70,
                height: (MediaQuery.of(context).size.height/100) * 8,
                margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/100) * 7, top: (MediaQuery.of(context).size.height/100) * 2),
                child: RaisedButton (
                  child: Text('Finalizar', style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF01E271)
                    ),
                  ),
                  onPressed: () {
                    // if(_user.tipo == 1){
                    //   cadastrarJogador(_user);
                    // }else{
                    //   cadastrarOlheiro(_user);
                    // }
                    Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}