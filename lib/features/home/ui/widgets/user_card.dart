import 'package:flutter/material.dart';
import 'package:local_base/core/constants/extensions/context_extension.dart';
import 'package:local_base/features/home/data/user.dart';

class UserCard extends StatelessWidget {
  final User user;
  final void Function()? onUpdate, onDelete;

  const UserCard(this.user, {required this.onUpdate, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.homeUserCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white10),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.cyan.withAlpha((0.1 * 255).toInt()), shape: BoxShape.circle),
        child: Icon(user.gender == "Male" ? Icons.male : Icons.female, color: Colors.cyanAccent),
      ),
      title: Text(
        "${user.firstName} ${user.lastName}",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
      ),
      subtitle: Text("Age: ${user.age} • ${user.gender}", style: TextStyle(color: Colors.white.withAlpha((0.6 * 255).toInt()))),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit_note_rounded, color: Colors.cyanAccent),
            onPressed: onUpdate,
          ),
          IconButton(
            icon: Icon(Icons.delete_sweep_outlined, color: Colors.redAccent),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
