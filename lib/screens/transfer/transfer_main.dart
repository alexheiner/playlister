import 'package:flutter/material.dart';
import 'package:playlister/config/themes/colors.dart';
import '../../widgets/buttons/filled_button.dart';
import '../../widgets/navigation/default_app_bar.dart';
import '../../widgets/text_input.dart';
import '../../widgets/buttons/outline_button.dart';
import '../../widgets/fixed_gradient.dart';
class Transfer extends StatefulWidget {

  Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FixedGradient(
        child: Scaffold( 
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: DefaultAppBar(
            title: 'Transfer', 
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 150, 15.0, 0),
            child: Column(
              children: [
                TextInput(
                  controller: myController,
                  placeholder: 'Playlist Link',
                  icon: Icons.search,
                  autoFocus: true,
                ),
                Container(
                  margin: EdgeInsets.only(top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlineElevatedButton(
                        callback: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(myController.text),
                              );
                            },
                          );
                        },
                        title: 'Cancel', 
                        size: Size(150.0, 25),
                        fontSize: 22,
                        fontColor: Colors.white,
                        borderColor: OpaqueGray,
                        backgroundColor: Colors.transparent.withOpacity(0),
                      ),
                      FilledElevatedButton(
                        callback: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(myController.text),
                              );
                            },
                          );
                        },
                        title: 'Search', 
                        size: Size(150.0, 25),
                        fontSize: 20,
                        backgroundColor: OpaqueGray
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
