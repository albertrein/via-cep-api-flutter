import 'package:meta/meta.dart';
import 'dart:convert';

class ResultCep {
  ResultCep({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge,
    required this.gia,
    required this.ddd,
    required this.siafi,
    required this.erro,
  });

  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String ibge;
  String gia;
  String ddd;
  String siafi;
  bool erro;

  factory ResultCep.fromJson(String str) => ResultCep.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultCep.fromMap(Map<String, dynamic> json) => ResultCep(
    cep: (json.containsKey("cep")? json["cep"]: ""),
    logradouro: (json.containsKey("logradouro")? json["logradouro"]: ""),
    complemento: (json.containsKey("complemento")? json["complemento"]: ""),
    bairro: (json.containsKey("bairro")? json["bairro"]: ""),
    localidade: (json.containsKey("localidade")? json["localidade"]: ""),
    uf: (json.containsKey("uf")? json["uf"]: ""),
    ibge: (json.containsKey("ibge")? json["ibge"]: ""),
    gia: (json.containsKey("gia")? json["gia"]: ""),
    ddd: (json.containsKey("ddd")? json["ddd"]: ""),
    siafi: (json.containsKey("siafi")? json["siafi"]: ""),
    erro: (json.containsKey("erro")? json["erro"]: false),
  );

  Map<String, dynamic> toMap() => {
    "cep": (cep.isEmpty)? "": cep,
    "logradouro": (logradouro.isEmpty)? "": logradouro,
    "complemento": (complemento.isEmpty)? "": complemento,
    "bairro": (bairro.isEmpty)? "": bairro,
    "localidade": (localidade.isEmpty)? "": localidade,
    "uf": (uf.isEmpty)? "": uf,
    "ibge": (ibge.isEmpty)? "": ibge,
    "gia": (gia.isEmpty)? "": gia,
    "ddd": (ddd.isEmpty)? "": ddd,
    "siafi": (siafi.isEmpty)? "": siafi,
    "erro": (erro)? true: false,
  };

  @override
  String toString() {
    String dadosCapturados = "";
    dadosCapturados += (cep.isEmpty)? "": "cep: "+cep+"\n";
    dadosCapturados += (logradouro.isEmpty)? "": "logradouro: "+logradouro+"\n";
    dadosCapturados += (complemento.isEmpty)? "": "complemento: "+complemento+"\n";
    dadosCapturados += (bairro.isEmpty)? "": "bairro: "+bairro+"\n";
    dadosCapturados += (localidade.isEmpty)? "": "localidade: "+localidade+"\n";
    dadosCapturados += (uf.isEmpty)? "": "uf: "+uf+"\n";
    dadosCapturados += (ibge.isEmpty)? "": "ibge: "+ibge+"\n";
    dadosCapturados += (gia.isEmpty)? "": "gia: "+gia+"\n";
    dadosCapturados += (ddd.isEmpty)? "": "ddd: "+ddd+"\n";
    dadosCapturados += (siafi.isEmpty)? "": "siafi: "+siafi+"\n";
    dadosCapturados += (erro) ? "Erro": "";
    return dadosCapturados;
  }
  
}
