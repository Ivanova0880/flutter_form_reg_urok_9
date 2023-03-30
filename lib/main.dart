import 'package:flutter/material.dart';
import 'userPreferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Хранение данных',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String passwordYou = '';
  // String? _nameYou;

  @override
  void initState() {
    super.initState();
    name = UserPreferences().getUsername() ?? '';
    passwordYou = UserPreferences().getUserpassword() ?? '';
  }

  Widget buildNameYouField() {
    return TextFormField(
        decoration:
            const InputDecoration(labelText: 'Имя', icon: Icon(Icons.person)),
        keyboardType: TextInputType.multiline,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Введите Ваше имя';
          }
        },
        onChanged: (name) => setState(() => this.name = name));
  }

  Widget biuldContactYouField() {
    return TextFormField(
        decoration: const InputDecoration(
          labelText: 'Пароль',
          icon: Icon(Icons.key),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Введите пароль для входа';
          }
        },
        onChanged: (passwordYou) => setState(() => passwordYou = passwordYou));

    // onSaved: (value) {
    //   passwordYou = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const Text(
                    'Вход в приложение',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildNameYouField(),
                  biuldContactYouField(),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      await UserPreferences().setUsername(name);
                      await UserPreferences().setPassword(passwordYou);
                      if (formKey.currentState!.validate()) {
                        Color color = Colors.red;
                        String text;

                        if (name != 'Наталья' && passwordYou != '123456') {
                          text = 'Пароль или Имя не совпадают';
                        } else {
                          text = 'Идентификация пройдена';
                          color = Colors.green;
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => FormScreen2()),
                          );
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(text),
                            backgroundColor: color,
                          ),
                        );
                      }

                      // setState(() {
                      //   name = '';
                      // });
                    },
                    child: const Text(
                      'Войти',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FormScreen()),
                      );
                    },
                    child: const Text('Пройти регистрацию'),
                  )
                ],
              )),
        ));
  }
}

class FormScreen2 extends StatelessWidget {
  const FormScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: const [
            Text(
              'Привет, Наталья!',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            // buildNameYouField(),
            // biuldContactYouField(),
          ],
        ),
      ),
    );
  }
}

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? _namePet;
  String? _nameYou;
  String? _contactYou;
  String? _classPet;

  var _eatS = false;
  var _eatV = false;
  var _eatN = false;
  Gender? _gender;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget buildNamePetField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Имя'),
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введитие имя';
        }
      },
      onSaved: (value) {
        _namePet = value;
      },
    );
  }

  Widget buildNameYouField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Фамилия'),
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ведите фамилию';
        }
      },
      onSaved: (value) {
        _nameYou = value;
      },
    );
  }

  Widget biuldContactYouField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Номер телефона'),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введите ваш номер телефона';
        }
      },
      onSaved: (value) {
        _contactYou = value;
      },
    );
  }

  Widget biuldClassPetField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Придумайте пароль'),
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введите пароль из 6 символов';
        }
      },
      onSaved: (value) {
        _classPet = value;
      },
    );
  }

  Widget biuldEatSField() {
    return CheckboxListTile(
        title: const Text('Здоровье'),
        value: _eatS,
        onChanged: (bool? value) {
          setState(() => _eatS = value!);
        });
  }

  Widget biuldEatVField() {
    return CheckboxListTile(
        title: const Text('Семья'),
        value: _eatV,
        onChanged: (bool? value) {
          setState(() => _eatV = value!);
        });
  }

  Widget biuldEatNField() {
    return CheckboxListTile(
        title: const Text('Отношения'),
        value: _eatN,
        onChanged: (bool? value) {
          setState(() => _eatN = value!);
        });
  }

  Widget biuldGenderGField() {
    return RadioListTile(
        title: const Text('Женщина'),
        value: Gender.girl,
        groupValue: _gender,
        onChanged: (Gender? value) {
          setState(() {
            if (value != null) _gender = value;
          });
        });
  }

  Widget buildGenderBField() {
    return RadioListTile(
        title: const Text('Мужчина'),
        value: Gender.boy,
        groupValue: _gender,
        onChanged: (Gender? value) {
          setState(() {
            if (value != null) _gender = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Форма для регистрации'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formkey,
            child: ListView(
              children: [
                buildNamePetField(),
                buildNameYouField(),
                biuldContactYouField(),
                biuldClassPetField(),
                const SizedBox(height: 20.0),
                const Text('Какие темы вам интересны'),
                biuldEatSField(),
                biuldEatVField(),
                biuldEatNField(),
                const SizedBox(height: 20.0),
                biuldGenderGField(),
                buildGenderBField(),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        Color color = Colors.red;
                        String text;

                        if (_gender == null) {
                          text = 'Выберите пол';
                        } else if (_eatN == false ||
                            _eatS == false ||
                            _eatV == false) {
                          text = 'Необходимо выбрать вариант';
                        } else {
                          text = 'Форма успешно заполнена';
                          color = Colors.green;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(text),
                            backgroundColor: color,
                          ),
                        );
                      }
                    },
                    // {
                    //   if (!_formkey.currentState!.validate()) {
                    //     return;
                    //   }

                    //   _formkey.currentState!.save();
                    // },
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}

enum Gender { girl, boy }

// enum Eats { s, v, n }
