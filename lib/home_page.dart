import 'package:flutter/material.dart';
import 'package:gpt_3/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  String answered = '';
  String load = 'Watting to Search a image';
  bool isLoading = false;
  String initialValue = 'Search IMG';
  bool isImage = true;
  // list of dropdown menue
  final catagories = ['Search IMG', 'Alex', 'Spelling correct'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: double.infinity,
                child: DropdownButton(
                  // Initial Value

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  value: initialValue,

                  // Array list of items
                  items: catagories.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      initialValue = newValue!;
                      if (newValue == 'Search IMG') {
                        isImage = true;
                        isLoading = false;
                        load = 'Watting to Search a image';
                      } else {
                        isImage = false;
                      }
                      answered = '';
                    });
                  },
                ),
              ),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: 'Search here'),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  answered = '';
                  setState(() {
                    load = 'Loading...';
                  });
                  answered = await AppiService.getAItext(
                      _controller.text, initialValue);
                  print(answered);
                  setState(() {
                    isLoading = true;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    'Click',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              isImage
                  ? isLoading
                      ? Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  answered,
                                ),
                                filterQuality: FilterQuality.low),
                          ),
                        )
                      : Container(
                          width: 300,
                          height: 300,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2, color: Colors.brown)),
                          child: Text(
                            load,
                            style: TextStyle(fontSize: isLoading ? 60 : 20),
                          ))
                  : Text(
                      answered,
                      style: const TextStyle(fontSize: 17),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
