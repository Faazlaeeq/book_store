import 'dart:io';

import 'package:book_store/Database/firebase_service.dart';
import 'package:book_store/Widgets/textformfeild_widget.dart';
import 'package:book_store/logic/manage/manage_cubit.dart';
import 'package:book_store/logic/manage/manage_state.dart';
import 'package:book_store/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ManageBookScreen extends StatefulWidget {
  ManageBookScreen({super.key});
  final TextEditingControllerManager contManager =
      TextEditingControllerManager();
  @override
  State<ManageBookScreen> createState() => _ManageBookScreenState();
}

class _ManageBookScreenState extends State<ManageBookScreen> {
  XFile? file;
  Map<String, TextEditingController> controllers = {};
  ManageCubit submitLoader = ManageCubit();
  Future<void> pickImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    file = await picker.pickImage(source: source, maxWidth: 600);
    if (file == null) return;
    setState(() {});
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext ctx) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take a Photo'),
              onTap: () async {
                context.read<ManageCubit>().startLoading();

                Navigator.pop(ctx);
                await pickImage(ImageSource.camera);
                // ignore: use_build_context_synchronously
                context.read<ManageCubit>().stopLoading();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                context.read<ManageCubit>().startLoading();

                Navigator.pop(ctx);
                await pickImage(ImageSource.gallery);
                // ignore: use_build_context_synchronously
                context.read<ManageCubit>().stopLoading();
              },
            ),
            // Add more options here
          ],
        );
      },
    );
  }

  void submitForm(BuildContext context, ManageCubit cubit) async {
    if (file == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please add image")));
      return;
    }
    cubit.startLoading();
    String? url = await FireStorageService().uploadImage(file!.path);

    if (url == null || url.isEmpty) {
      context.mounted
          ? ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Image upload failed")))
          : null;
      return;
    }
    await FireStoreService("books").insertData(BookModel(
            name: widget.contManager.controllers["Book Name"]!.text,
            desc: widget.contManager.controllers["Author Name"]!.text,
            imgUrl: url,
            author: widget.contManager.controllers["Book Description"]!.text,
            price: widget.contManager.controllers["Book Price"]!.text)
        .toMap());
    cubit.stopLoading();
    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text("Book Added to Record Successfully")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Manage Books")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: SingleChildScrollView(
                child: Column(
          children: [
            SizedBox(
              height: 250,
              width: 180,
              child: BlocBuilder<ManageCubit, ManageState>(
                builder: (context, state) {
                  if (state is LoadingManageState) {
                    return Container(
                        margin: const EdgeInsets.only(bottom: 50),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blueGrey),
                        child:
                            const Center(child: CircularProgressIndicator()));
                  } else {
                    return (file == null)
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 50.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blueGrey),
                            child: IconButton(
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _showOptions(context);
                                }),
                          )
                        : Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipOval(
                                  child: Image.file(
                                    File(file!.path),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _showOptions(context);
                                    },
                                  ),
                                ),
                              )
                            ],
                          );
                  }
                },
              ),
            ),
            widget.contManager.buildTextFormField("Book Name",
                validatorFunc: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (value.length > 50) {
                return "Book name should be less than 50 characters";
              }

              return null;
            }, autovalidate: true),
            widget.contManager.buildTextFormField("Author Name",
                validatorFunc: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (value.length > 50) {
                return "Author name should be less than 50 characters";
              }

              return null;
            }, autovalidate: true),
            widget.contManager.buildTextFormField("Book Description",
                validatorFunc: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (value.length > 500) {
                return "Description should be less than 500 characters";
              }

              return null;
            }, autovalidate: true, minlines: 3, maxlines: 100),
            widget.contManager.buildTextFormField("Book Price",
                validatorFunc: (value) {
              if (value == null || value.isEmpty) {
                return 'Please add price';
              }
              double price = double.parse(value);
              if (price < 10) {
                return "Price should be greater than 10 dollar";
              }

              return null;
            },
                inputType: const TextInputType.numberWithOptions(decimal: true),
                isprice: true),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: BlocBuilder<ManageCubit, ManageState>(
                  bloc: submitLoader,
                  builder: (context, state) {
                    return FilledButton(
                        onPressed: () => submitForm(context, submitLoader),
                        child: (state is InitManageState)
                            ? const Text("Insert Data")
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ));
                  }),
            )
          ],
        ))),
      ),
    ));
  }
}
