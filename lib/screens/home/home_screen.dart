import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_2/models/users.dart';
import 'package:flutter_application_bloc_2/screens/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeStarted());
    super.initState();
  }

  TextEditingController userController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          userController.clear();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: Text('Add User'),
                content: TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    hintText: 'Enter Full Name',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {
                      if (state is AddUserSuccess) {
                        Navigator.pop(context);
                        BlocProvider.of<HomeBloc>(context).add(HomeStarted());
                      }
                    },
                    buildWhen: (previous, current) {
                      if (current is AddUserSuccess ||
                          current is AddUserLoading ||
                          current is AddUserError) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      return TextButton(
                        onPressed: state is AddUserLoading
                            ? null
                            : () {
                                BlocProvider.of<HomeBloc>(context).add(
                                  AddUserButtonClicked(
                                    Users(
                                      fullName: userController.text,
                                    ),
                                  ),
                                );
                              },
                        child: state is AddUserLoading
                            ? CupertinoActivityIndicator()
                            : Text('Add'),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) {
          if (current is GetUsersSuccess ||
              current is GetUsersLoading ||
              current is GetUsersError) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is GetUsersLoading) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is GetUsersSuccess) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  child: Text(state.users[index].fullName!),
                );
              },
            );
          }
          if (state is GetUsersError) {
            return Center(child: Text(state.error));
          }
          return SizedBox();
        },
      ),
    );
  }
}
