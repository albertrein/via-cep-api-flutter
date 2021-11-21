import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:web_service/services/via_cep_service.dart';
import 'package:share/share.dart';
import 'package:web_service/models/result_cep.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  Widget? _result;
  ResultCep ?_resultDadosCep;

  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar CEP (PostalCode)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, size: 20),
            iconSize: 50,
            onPressed: () {
              if(_resultDadosCep != null){
                Share.share(_resultDadosCep.toString());
              }
            },
          )
        ] 
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSearchCepTextField(),
            _buildSearchCepButton(context),
            _buildResultForm()
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCepTextField() {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(labelText: 'Cep'),
      controller: _searchCepController,
      enabled: _enableField,
    );
  }

  String _limpaCaracteresEspeciaisCep(String cepEntrada){
    cepEntrada = cepEntrada.replaceAll(RegExp(r'[^\w\s]+'), '');
    cepEntrada = cepEntrada.replaceAll(' ', '');
    return cepEntrada;
  }

  bool _isCepValido(String cepEntrada){
    if(cepEntrada.length != 8){
      return false;
    }
    return true;
  }

  Widget _buildSearchCepButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RaisedButton(
        onPressed: (){
          _searchCep(context).catchError((error){});
        },
        child: _loading ? _circularLoading() : Text('Consultar'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void _searching(bool enable) {
    setState(() {
      _result = enable ? null : _result;
      _loading = enable;
      _enableField = !enable;
    });
  }

  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(),
    );
  }

  Widget _showUserMessage(mensagem, context){
    return Flushbar(
      title: "Usuário",
      message: mensagem,
      duration: const Duration(seconds: 3),
      isDismissible: false,
    )..show(context);
  }

  Future _searchCep(BuildContext context) async {
    _searching(true);
    _resultDadosCep = null;

    String cep = _searchCepController.text;
    cep = _limpaCaracteresEspeciaisCep(cep);
      
    if(!_isCepValido(cep)) {
      _searching(false);
      _showUserMessage("Cep Inválido", context);
      return Future.error("Error");
    }

    final resultCep = await ViaCepService.fetchCep(cep: cep);

    if(resultCep.erro){
      _searching(false);
      _showUserMessage("CEP não reconhecido", context);
      return Future.error("Error");
    }

    setState(() {
      _resultDadosCep = resultCep;
      _result = __buildChildResult(resultCep);
    });

    _searching(false);
  }

  Widget __buildChildResult(ResultCep dadosCep){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.black12,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(5),child: _buildColumnResultCep(dadosCep),),          
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                Share.share(dadosCep.toString());
              },
              child: const Icon(Icons.share, size: 20),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _buildColumnResultCep(ResultCep dadoCep){
    List<Widget> listaResultadoTexts = [];

    dadoCep.toMap().forEach((String chave, dynamic valor){
      if(chave != "erro" && valor.toString().length > 0){
        listaResultadoTexts.add(
          Row(
            children: [
              Flexible(child: Text(chave+":", style: TextStyle(fontSize: 20,fontWeight: FontWeight. bold))),
              Flexible(child: Text(" "+valor, style: TextStyle(fontSize: 20)))
            ]
          )
        );
      }      
    });
    
    return Column(children: listaResultadoTexts);
  }

  Widget _buildResultForm() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: _result,
    );
  }
}