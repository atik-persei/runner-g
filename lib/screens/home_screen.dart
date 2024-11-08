// Design Library
import 'package:flutter/material.dart';

// Screen Library
import 'package:runner_g/main.dart';
import 'package:runner_g/screens/addGroup_screen.dart';
import 'package:runner_g/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getGroup();
  }

  Future<void> addGroup() async {
    final response = await supabase
      .from('groups')
      .insert({});
    print(response);
  }

  Future<void> getGroup() async {
    final userUUID = supabase.auth.currentUser?.id;

    if (userUUID == null) {
      print('User is not authenticated');
      setState(() {
        isLoading = false;
      });
      return;
    }

    final response = await supabase
      .from('groups')
      .select()
      .eq('group_manager', userUUID);
    print(response);

    setState(() {
      data = response;
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    final profileImageUrl = user?.userMetadata?['avatar_url'];
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 66,
        leading: Row(
          children: [
            const SizedBox(
              height: 8.0,
              width: 8.0,
            ),
            Padding(
            padding: const EdgeInsets.all(8.0), // Padding for the image
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => const ProfileScreen()),
                );
              },
              child: ClipOval(
                  child: Image.network(profileImageUrl!, fit: BoxFit.cover),
              )
            ),
            ),
          ],
        )
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
            },
            child: Text('그룹 생성', style: Theme.of(context).textTheme.bodyMedium)
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddGroupScreen()
                ),
              );
            },
            child: Text('그룹 조회', style: Theme.of(context).textTheme.bodyMedium)
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Text(data[index]['group_manager']);
              },
            ),
          ),
        ],
      ),
    );
  }
}
