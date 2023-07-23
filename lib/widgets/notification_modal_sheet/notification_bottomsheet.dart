import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationModalsheet extends StatefulWidget {
  const NotificationModalsheet({Key? key}) : super(key: key);

  @override
  State<NotificationModalsheet> createState() => _NotificationModalsheetState();
}

class _NotificationModalsheetState extends State<NotificationModalsheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notifications",
                    style: TextStyle(
                        color: Colors.indigo.shade700,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Close",
                      style: TextStyle(
                          color: Colors.indigo.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            height: 500,
                              width: 700,
                              child: Column()
                          ),
                        );
                      });
                  // Navigator.push(context, MaterialPageRoute(builder: (context){
                  //   return const NotificationSettings();
                  // }));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "What type of updates do you want to get?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Icon(Icons.notifications_active_outlined)
                  ],
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.xmark,
                      size: 57,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "No Notification Yet",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
