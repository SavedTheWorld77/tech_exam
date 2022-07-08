import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/random_data_bloc.dart';
import '../models/random_datamodel.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile?> imageList = [];

  // List of items in our dropdown menu
  List<String> dates = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String dropdownDateValue = 'Item 1';
  String dropdownAreaValue = 'Item 2';
  String dropdownTaskValue = 'Item 3';
  String dropdownEventValue = 'Item 4';
  TextEditingController? commentController;
  TextEditingController? tagsController;
  List<String> area = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  List<String> taskCategory = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  List<String> event = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  void getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    imageList.add(image);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          // getImage();
          print(dropdownDateValue);
          // print(dropdownvalue);
          // print("dropdownvalue");
        }),
        appBar: AppBar(
          title: const Text("New Diary"),
          backgroundColor: Colors.black,
          leading: const Icon(Icons.close),
        ),
        body: BlocListener<RandomDataBloc, RandomDataState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is RandomDataLoaded) {
              print("data has been sent");
              print(state.randomData.area);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(children: const [
                    Icon(Icons.pin_drop_sharp),
                    Text("20041075 | TAP-NS TAP-North Strathfield")
                  ]),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 232, 232, 232),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text("Add to site diary",
                                style: TextStyle(
                                  fontSize: 25,
                                )),
                            Spacer(),
                            CircleAvatar(
                                radius: 10,
                                backgroundColor:
                                    Color.fromARGB(255, 194, 194, 194),
                                child: Icon(
                                  Icons.question_mark_outlined,
                                  size: 15,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        CustomContainer(
                          text: "Add photos to diary",
                          child: Column(children: [
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: imageList
                                  .map((item) => imageFile(item))
                                  .toList(),
                            ),
                            imageList.isEmpty
                                ? const SizedBox(height: 80)
                                : Container(),
                            Center(
                              child: Button(
                                  onPress: () {
                                    getImage();
                                  },
                                  text: "Add a photo"),
                            ),
                            Row(
                              children: const [
                                Text("Include in photo gallery"),
                                Spacer(),
                                CustomCheckbox(),
                              ],
                            ),
                          ]),
                        ),
                        CustomContainer(
                            text: "Comments",
                            child: Column(
                              children: [
                                TextField(
                                  controller: commentController,
                                  decoration: const InputDecoration(
                                    hintText: "Comments",
                                  ),
                                ),
                              ],
                            )),
                        CustomContainer(
                            text: "Details",
                            child: Column(
                              children: [
                                CustomDropDown(
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownDateValue = value.toString();
                                    });
                                  },
                                  values: dates,
                                  initialValue: dropdownDateValue,
                                ),
                                CustomDropDown(
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownAreaValue = value.toString();
                                    });
                                  },
                                  values: area,
                                  initialValue: dropdownAreaValue,
                                ),
                                CustomDropDown(
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownTaskValue = value.toString();
                                    });
                                  },
                                  values: taskCategory,
                                  initialValue: dropdownTaskValue,
                                ),
                                TextField(
                                  controller: tagsController,
                                  decoration: const InputDecoration(
                                    hintText: "Tags",
                                  ),
                                ),
                              ],
                            )),
                        CustomContainer(
                            checkBox: const CustomCheckbox(),
                            text: "Link to existing event?",
                            child: Column(
                              children: [
                                CustomDropDown(
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownEventValue = value.toString();
                                    });
                                  },
                                  values: event,
                                  initialValue: dropdownEventValue,
                                ),
                              ],
                            )),
                        Center(
                          child: Button(
                            onPress: () {
                              dispatchConcrete();
                            },
                            text: "Next",
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  void dispatchConcrete() {
    List<File> imageFiles = [];
    for (var element in imageList) {
      imageFiles.add(File(element!.path));
    }

    RandomData data = RandomData(
        area: dropdownAreaValue,
        date: dropdownDateValue,
        comments: commentController?.text ?? "no comment",
        events: dropdownEventValue,
        imageFile: imageFiles,
        tags: tagsController?.text ?? "no tags",
        task: dropdownTaskValue);
    BlocProvider.of<RandomDataBloc>(context)
        .add(SendRandomData(randomData: data));
  }

  Widget imageFile(XFile? file) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: FileImage(File(file!.path)),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
            top: -10,
            left: 70,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    imageList.remove(file);
                  });
                },
                child: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.close_outlined,
                        color: Colors.white, size: 15)))),
      ],
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: true,
      onChanged: (value) {},
      activeColor: const Color.fromARGB(255, 177, 230, 4),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Widget child;
  final String text;
  final Widget? checkBox;
  const CustomContainer({
    Key? key,
    required this.child,
    required this.text,
    this.checkBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(text,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              const Spacer(),
              checkBox ?? Container(),
            ],
          ),
          const Divider(),
          child,
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Function()? onPress;
  final String text;
  const Button({Key? key, required this.onPress, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 177, 230, 4),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextButton(
          onPressed: onPress,
          child: Text(text, style: const TextStyle(color: Colors.white))),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {Key? key,
      required this.values,
      required this.onChanged,
      required this.initialValue})
      : super(key: key);
  final List<String> values;
  final Function(Object?) onChanged;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: DropdownButton(
        // Initial Value
        isExpanded: true,
        value: initialValue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: values.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: onChanged,
      ),
    );
  }
}
