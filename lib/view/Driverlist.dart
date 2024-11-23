import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Driver List",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Something  went wrong: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No drivers found."));
          }

          final userDocuments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: userDocuments.length,
            itemBuilder: (context, index) {
              final user = userDocuments[index].data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  shadowColor: Colors.black38,
                  child: ListTile(
                    onTap:() {
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("View Driver")),
                    );  },

                    contentPadding: EdgeInsets.all(10),
                    leading: CircleAvatar(
                      backgroundImage: user['photoURL'] != null
                          ? NetworkImage(user['photoURL'])
                          : null,
                      child: user['photoURL'] == null
                          ? Icon(Icons.person, color: Colors.white)
                          : null,
                      radius: 30,
                      backgroundColor: Colors.blueGrey,
                    ),
                    title: Text(
                      user['Name']?.toString() ?? 'No Nam"e',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    subtitle: Text(
                      user['id']?.toString() ?? 'No ID',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    trailing: Text(
                      user['age']?.toString() ?? 'No Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: user['status'] == 'active' ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
