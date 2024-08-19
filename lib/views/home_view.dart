import 'package:flutter/material.dart';
import 'package:flutter_app_splitthebill/components/action_button.dart';
import 'package:flutter_app_splitthebill/components/fieldtext_button.dart';
import 'package:flutter_app_splitthebill/controllers/home_controller.dart';
import 'package:flutter_app_splitthebill/models/colors.dart';
import 'package:flutter_app_splitthebill/models/person.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Cores cores = Cores();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController moneyController = TextEditingController();
  final TextEditingController pixController = TextEditingController();
  final HomeController homeController = HomeController();
  List<Person> selectedPersons = [];
  double bill = 0.0;

  void _refreshCount() {
    setState(() {
      bill = 0.0;
      bill = homeController.sumList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 70, 63, 58),
      appBar: AppBar(
        title: Text(
          'HowMuchIsMine? - HMIM',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple.shade700,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 150.0,
                  child: ClipRRect(
                    // child: Image.asset(fit: BoxFit.fill, 'lib/assets/bill.jpg'),
                    child: Image.network(
                      'https://donadelas.com/wp-content/uploads/2023/12/pagando-a-conta.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 10.0, right: 10.0, left: 10.0),
                child: FieldtextButton(
                  myIcon:
                      Icon(color: cores.cor5, Icons.person_add_alt_1_outlined),
                  keyBoard: TextInputType.text,
                  controller: nameController,
                  nameFild: 'Insira o nome',
                  nameButton: 'Inserir',
                  myFunction: () {
                    setState(() {
                      if (nameController.text.isEmpty) {
                        //tratamento
                        homeController.scaffoldMessage(
                            'Precisa inserir um nome', 2, context);
                      } else {
                        homeController.addPerson(nameController.text);
                      }
                    });
                    nameController.clear();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 10.0, left: 10.0, right: 10.0),
                child: FieldtextButton(
                  myIcon:
                      Icon(color: cores.cor5, Icons.monetization_on_outlined),
                  keyBoard: TextInputType.number,
                  controller: moneyController,
                  nameFild: 'Insira o valor',
                  nameButton: 'Inserir',
                  myFunction: () {
                    if (selectedPersons.isNotEmpty &&
                        moneyController.text.isNotEmpty) {
                      setState(() {
                        //inserir valor para os selecionados
                        homeController.increaseValueOfSelectedPersons(
                          selectedPersons,
                          double.tryParse(moneyController.text) ?? 0.0,
                        );
                        //atualizando a conta
                        _refreshCount();
                      });
                      moneyController.clear();
                    } else if (moneyController.text.isEmpty) {
                      homeController.scaffoldMessage(
                          'Precisa inserir um valor', 2, context);
                    } else {
                      homeController.scaffoldMessage(
                          'Precisa selecionar um nome', 2, context);
                    }
                  },
                ),
              ),
              Container(
                height: 330,
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade600,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(3.0)),
                        child: ListView.builder(
                          itemCount: homeController.persons.length,
                          itemBuilder: (context, index) {
                            final person = homeController.persons[index];
                            return Column(
                              children: [
                                ListTile(
                                  title: Text('${person.name}',
                                      style: TextStyle(color: Colors.white)),
                                  subtitle: Text(
                                      homeController.moneyPrint(person.money),
                                      style:
                                          TextStyle(color: Colors.green[300])),
                                  contentPadding: EdgeInsets.only(left: 8),
                                  minTileHeight: 20,
                                  trailing: Checkbox(
                                    side: BorderSide(
                                      color: Colors.grey.shade600,
                                    ),
                                    activeColor: cores.cor4,
                                    checkColor: Colors.white,
                                    value: selectedPersons.contains(person),
                                    onChanged: (bool? selected) {
                                      setState(() {
                                        if (selected == true) {
                                          selectedPersons.add(person);
                                        } else {
                                          selectedPersons.remove(person);
                                        }
                                      });
                                    },
                                  ),
                                  leading: Icon(
                                    Icons.person_outline,
                                    color: Colors.purple[50],
                                  ),
                                  dense: true,
                                ),
                                Divider(
                                  color: Colors.grey.shade600,
                                  thickness: 1.0,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ActionButton(
                            myIcon: Icon(Icons.splitscreen),
                            corBgd: cores.cor3,
                            corText: cores.cor5,
                            nameBtn: 'Dividir',
                            myFunction: () {
                              setState(() {
                                if (moneyController.text.isEmpty) {
                                  //tratamento
                                  homeController.scaffoldMessage(
                                      'Precisa inserir um valor', 2, context);
                                } else {
                                  homeController.spliValueOfSelectedPersons(
                                    selectedPersons,
                                    double.tryParse(moneyController.text) ??
                                        0.0,
                                  );
                                  _refreshCount();
                                  moneyController.clear();
                                }
                              });
                            }),
                        ActionButton(
                            myIcon: Icon(Icons.trending_down_outlined),
                            corBgd: cores.cor2,
                            corText: cores.cor5,
                            nameBtn: 'Diminuir',
                            myFunction: () {
                              setState(() {
                                if (moneyController.text.isEmpty) {
                                  //tratamento
                                  homeController.scaffoldMessage(
                                      'Precisa inserir um valor', 2, context);
                                } else {
                                  homeController.decreaseValueOfSelectedPersons(
                                    selectedPersons,
                                    double.tryParse(moneyController.text) ??
                                        0.0,
                                  );
                                  _refreshCount();
                                  selectedPersons.clear();
                                }
                              });
                            }),
                        ActionButton(
                            myIcon: Icon(Icons.volunteer_activism_outlined),
                            corBgd: cores.cor1,
                            corText: cores.cor5,
                            nameBtn: '+10%',
                            myFunction: () {
                              setState(() {
                                homeController.increaseValueOfSelectedPersons(
                                    selectedPersons, 10.0);
                              });
                            }),
                        ActionButton(
                            myIcon: Icon(Icons.restart_alt_rounded),
                            corBgd: Colors.orange.shade300,
                            corText: cores.cor5,
                            nameBtn: 'Zerar',
                            myFunction: () {
                              setState(() {
                                if (selectedPersons.isEmpty) {
                                  homeController.scaffoldMessage(
                                      'Precisa selecionar um nome', 2, context);
                                } else {
                                  homeController.resetValueOfSelectedPersons(
                                      selectedPersons);
                                  _refreshCount();
                                }
                              });
                            }),
                        ActionButton(
                            myIcon: Icon(Icons.delete_forever_sharp),
                            corBgd: cores.cor6,
                            corText: cores.cor5,
                            nameBtn: 'Deletar',
                            myFunction: () {
                              setState(() {
                                if (selectedPersons.isEmpty) {
                                  homeController.scaffoldMessage(
                                      'Precisa selecionar um nome', 2, context);
                                } else {
                                  homeController
                                      .deleteSelectedPersons(selectedPersons);
                                  selectedPersons.clear();
                                  _refreshCount();
                                }
                              });
                            }),
                      ],
                    ),
                    SizedBox(width: 10)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 180, //determinar largura do filho
                          child: ListTile(
                            title: Text('Valor da Conta:'),
                            subtitle: Text(homeController.moneyPrint(bill)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 50,
                                child: TextField(
                                  controller: pixController,
                                  decoration: InputDecoration(
                                      labelText: 'Chave pix',
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton.icon(
                              icon: Icon(Icons.qr_code_2),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple.shade700,
                                foregroundColor: Colors.white,
                                elevation: 5.0,
                              ),
                              onPressed: () {
                                if (pixController.text.isEmpty) {
                                  //tratamento
                                  homeController.scaffoldMessage(
                                      'Precisa inserir um pix', 2, context);
                                } else {
                                  Navigator.of(context).pushNamed(
                                    '/qrcode',
                                    arguments: pixController.text,
                                  );
                                  pixController.clear();
                                }
                              },
                              label: Text('Gerar'),
                            ),
                          ],
                        ),
                        SizedBox(height: 8)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
