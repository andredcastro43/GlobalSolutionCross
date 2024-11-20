import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/eletropostoProvider.dart';

class EletropostoScreen extends StatefulWidget {
  @override
  _EletropostoScreenState createState() => _EletropostoScreenState();
}

class _EletropostoScreenState extends State<EletropostoScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<EletropostoProvider>(context, listen: false).fetchEletropostos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eletropostos Próximos - André94858 & Ricardo89344',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 38, 131, 74),
      ),
      body: Consumer<EletropostoProvider>(
        builder: (context, eletropostoProvider, child) {
          if (eletropostoProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.green.shade700),
            );
          } else if (eletropostoProvider.errorMessage != null) {
            return Center(
              child: Text(
                eletropostoProvider.errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16.0),
              ),
            );
          } else if (eletropostoProvider.eletropostos.isEmpty) {
            return Center(
              child: Text(
                'Nenhum eletroposto encontrado',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
            );
          } else {
            final eletropostos = eletropostoProvider.eletropostos;
            return ListView.builder(
              padding: EdgeInsets.all(12.0),
              itemCount: eletropostos.length,
              itemBuilder: (context, index) {
                final eletroposto = eletropostos[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: Icon(
                      Icons.ev_station,
                      color: Colors.green.shade700,
                      size: 36.0,
                    ),
                    title: Text(
                      eletroposto.nome,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Endereço: ${eletroposto.endereco}',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          if (eletroposto.telefone != null)
                            Text(
                              'Telefone: ${eletroposto.telefone}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          Text(
                            'Conectores: ${eletroposto.conectores.join(', ')}',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}

