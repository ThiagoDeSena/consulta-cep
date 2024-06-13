import 'dart:convert';
import 'package:consulta_cep/widgets/row_dados_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController cepController = TextEditingController();
  String? cep, logradouro, bairro, localidade, uf;

  Future<void> getCep(String cep) async {
    Uri uri = Uri.parse("https://viacep.com.br/ws/$cep/json/");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      print("Carregou dados CEP");
      Map<String, dynamic> dadosCep = json.decode(response.body);
      setState(() {
        cep = dadosCep['cep'];
        logradouro = dadosCep['logradouro'];
        bairro = dadosCep['bairro'];
        localidade = dadosCep['localidade'];
        uf = dadosCep['uf'];
      });
    } else {
      print("Falha ao obter CEP da API");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consulta CEP"),
        backgroundColor: Colors.lime,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(controller: cepController),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.lime),
                onPressed: () async {
                  await getCep(cepController.text);
                },
                child: const Text("Buscar CEP",style: TextStyle(color: Colors.black),)),
            const SizedBox(
              height: 20,
            ),
            RowDadosWidget(title: "CEP", subtitle: cep ?? ""),
            RowDadosWidget(title: "Logradouro", subtitle: logradouro ?? ""),
            RowDadosWidget(title: "bairro", subtitle: bairro ?? ""),
            RowDadosWidget(title: "localidade", subtitle: localidade ?? ""),
            RowDadosWidget(title: "UF", subtitle: uf ?? "")
          ],
        ),
      ),
    );
  }
}
