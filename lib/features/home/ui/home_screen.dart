import 'package:flutter/material.dart';
import 'package:local_base/core/helpers/data_base_helper.dart';
import 'package:local_base/features/home/data/user.dart';
import 'package:local_base/features/home/ui/widgets/field_widget.dart';
import 'package:local_base/features/home/ui/widgets/user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> _users = [];

  void _loadUsers() async {
    List<User> data = await DataBaseHelper.instance.readUsers();
    setState(() {
      _users = data;
    });
  }

  @override
  initState() {
    _loadUsers();
    super.initState();
  }

  String _selectedGender = "Male";
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _firstController = TextEditingController();

  void _userSheet({User? user}) {
    if (user != null) {
      _selectedGender = user.gender;
      _lastController.text = user.lastName;
      _firstController.text = user.firstName;
      _ageController.text = user.age.toString();
    } else {
      _ageController.clear();
      _lastController.clear();
      _firstController.clear();
      _selectedGender = "Male";
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFF1A1F24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height: 20),
              Text(
                user == null ? "Add New User" : "Update User",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: FieldWidget(label: "First Name", controller: _firstController),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: FieldWidget(label: "Last Name", controller: _lastController),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: FieldWidget(label: "Age", controller: _ageController),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedGender,
                      dropdownColor: Color(0xFF1A1F24),
                      style: TextStyle(color: Colors.white),
                      items: ["Male", "Female"].map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
                      onChanged: (value) => setState(() => _selectedGender = value!),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white10),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyanAccent),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
                onPressed: () {
                  if (user == null) {
                    User userToAdd = User(
                      id: DateTime.now().toString(),
                      age: int.tryParse(_ageController.text) ?? 0,
                      gender: _selectedGender,
                      lastName: _lastController.text,
                      firstName: _firstController.text,
                    );
                    DataBaseHelper.instance.createUser(userToAdd);
                  } else {
                    User userToUpdate = User(id: user.id, age: int.tryParse(_ageController.text) ?? 0, gender: _selectedGender, lastName: _lastController.text, firstName: _firstController.text);
                    DataBaseHelper.instance.updateUser(userToUpdate);
                  }
                  Navigator.pop(context);
                  _loadUsers();
                },
                child: Text(user == null ? "CREATE USER" : "SAVE CHANGES", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.cyanAccent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text("LOCAL BASE", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2.0)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _userSheet,
        icon: Icon(Icons.add),
        foregroundColor: Colors.black,
        backgroundColor: Colors.cyanAccent,
        label: Text("Add User", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _users.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.storage_rounded, size: 80, color: Colors.white.withAlpha(25)),
                  SizedBox(height: 10),
                  Text("Database is empty", style: TextStyle(color: Colors.white.withAlpha(100), fontSize: 16)),
                ],
              ),
            )
          : ListView.separated(
              itemCount: _users.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (_, int index) {
                User user = _users[index];
                return UserCard(
                  user,
                  onUpdate: () => _userSheet(user: user),
                  onDelete: () {
                    DataBaseHelper.instance.deleteUser(user.id);
                    _loadUsers();
                  },
                );
              },
              separatorBuilder: (_, _) => SizedBox(height: 12),
            ),
    );
  }
}
