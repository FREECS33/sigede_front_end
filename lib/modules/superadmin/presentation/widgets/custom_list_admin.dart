import 'package:flutter/material.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/admin_entity.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/admins_entity.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institutions_entity.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/pages/edit_admin.dart';

class CustomListAdmin extends StatefulWidget {
  final AdminsEntity? admins;
  final InstitutionsEntity? institution;
  const CustomListAdmin({super.key, this.admins, this.institution});

  @override
  State<CustomListAdmin> createState() => _CustomListAdminState();
}

class _CustomListAdminState extends State<CustomListAdmin> {
  bool light = true;
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF6F5F5),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Color(0xFF917D62), // Color del borde
          width: 1.5, // Grosor del borde
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(
              Icons.admin_panel_settings,
              size: 40.0,
              color: Colors.grey,
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.admins!.name!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  maxLines: 1, // Limita a una sola línea
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.admins!.email!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87),
                  maxLines: 1, // Limita a una sola línea
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: Icon(Icons.edit_outlined,color: Colors.grey[750],),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => EditAdmin(admin:widget.admins,logo: widget.institution?.logo,name: widget.institution?.name,)));              
              },
            ),
            Switch(
              inactiveThumbColor: Colors.red,
              inactiveTrackColor: Colors.red.withOpacity(0.5),
              activeTrackColor: Colors.green.withOpacity(0.5),                
              thumbIcon: thumbIcon,
              value: light,
              activeColor: Colors.green,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  light = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
