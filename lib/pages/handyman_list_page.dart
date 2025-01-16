import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labactivity8/components/%20my_drawer.dart';
import 'package:labactivity8/components/my_button.dart';
import 'package:labactivity8/components/my_textfield.dart';
import 'package:labactivity8/pages/handyman_ add _page.dart';
import 'package:labactivity8/services/database_method.dart';

class HandymanListPage extends StatefulWidget {
  const HandymanListPage({super.key});

  @override
  State<HandymanListPage> createState() => _HandymanListPageState();
}

class _HandymanListPageState extends State<HandymanListPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController serviceController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  Stream? handymanStream;
  // Load Handyman details from Firestore
  loadHandyman() async {
    handymanStream = await DatabaseMethod().getHandymanDetails();
    setState(() {});
  }

  @override
  void initState() {
    loadHandyman();
    super.initState();
  }

  // Populate data from Firestore to ListView
  Widget allHandymanDetails() {
    return StreamBuilder(
      stream: handymanStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name: ${ds["Name"]}",
                              style: TextStyle(
                                color:
                                Theme.of(context).colorScheme.inversePrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                nameController.text = ds["Name"];
                                serviceController.text = ds["Service"];
                                locationController.text = ds["Location"];
                                phoneController.text = ds["Phone"];
                                editHandymanDetail(ds["Id"]);
                              },
                              child: Icon(
                                Icons.edit,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                            SizedBox(width: 15),
                            // Delete button
                            GestureDetector(
                              onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Delete Confirmation'),
                                  content: Text(
                                    'Are you sure to delete ${ds["Name"]} data',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.inversePrimary,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await DatabaseMethod().deleteHandymanDetails(ds["Id"]);
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.inversePrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              child: Icon(
                                Icons.delete,
                                color: Theme.of(context).colorScheme.inversePrimary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Service: ${ds["Service"]}",
                          style: TextStyle(
                            color:
                            Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Location: ${ds["Location"]}",
                          style: TextStyle(
                            color:
                            Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Phone: ${ds["Phone"]}",
                          style: TextStyle(
                            color:
                            Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // Show edit dialog for handyman details
  Future editHandymanDetail(String id) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.cancel),
              ),
              const SizedBox(width: 60),
              Text(
                "Edit Details",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          MyTextfield(
            controller: nameController,
            hintText: "Name",
            obscureText: false,
          ),
          const SizedBox(height: 20),
          MyTextfield(
            controller: serviceController,
            hintText: "Type of Service",
            obscureText: false,
          ),
          const SizedBox(height: 20),
          MyTextfield(
            controller: locationController,
            hintText: "Location",
            obscureText: false,
          ),
          const SizedBox(height: 20),
          MyTextfield(
            controller: phoneController,
            hintText: "Phone Number",
            obscureText: false,
          ),
          const SizedBox(height: 20),
          MyButton(
            text: "Update",
            onTap: () async {
              Map<String, dynamic> updateInfo = {
                "Id": id,
                "Name": nameController.text,
                "Service": serviceController.text,
                "Location": locationController.text,
                "Phone": phoneController.text,
              };
              await DatabaseMethod()
                  .updateHandymanDetails(id, updateInfo)
                  .then((value) => Navigator.pop(context));
            },
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Handyman List"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HandymanAddPage()),
          );
        },
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Expanded(child: allHandymanDetails()),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
