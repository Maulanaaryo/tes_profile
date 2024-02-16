import 'package:flutter/material.dart';
import 'package:flutter_tes_application/datasources/profile_datasource.dart';
import 'package:flutter_tes_application/models/profile_response_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<ProfileResponseModel> profileData;
  late ProfileData lastRetrievedProfile;

  @override
  void initState() {
    profileData = ProfileDataSource().getProfile('001');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<ProfileResponseModel>(
            future: profileData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error Profile Page'),
                );
              } else {
                final profile = snapshot.data!.data;
                return SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name : ${profile.name}'),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text('Email : ${profile.email}'),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text('No Telepon : ${profile.phone}'),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text('Moto Hidup : ${profile.moto}')
                    ],
                  ),
                );
              }
            }));
  }
}
