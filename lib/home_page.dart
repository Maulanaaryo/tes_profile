import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tes_application/datasources/local/profile_local_datasource.dart';
import 'package:flutter_tes_application/datasources/profile_datasource.dart';
import 'package:flutter_tes_application/models/profile_response_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<ProfileResponseModel> profileData;

  @override
  void initState() {
    profileData = _getProfileData();
    super.initState();
  }

  Future<void> _refreshProfileData() async {
    setState(() {
      profileData = _getProfileData();
    });
  }

  Future<ProfileResponseModel> _getProfileData() async {
    await ProfileLocalDatasource.initialize();

    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    ProfileData localProfile = ProfileLocalDatasource.getProfileStorage();

    if (connectivityResult == ConnectivityResult.none) {
      if (localProfile.name.isNotEmpty &&
          localProfile.email.isNotEmpty &&
          localProfile.phone.isNotEmpty &&
          localProfile.moto.isNotEmpty) {
        return ProfileResponseModel(
          code: 200,
          message: "success",
          data: localProfile,
        );
      } else {
        _showNoInternetWarning();
        throw Exception('No internet connection');
      }
    } else {
      ProfileDataSource profileService = ProfileDataSource();
      ProfileResponseModel response = await profileService.getProfile('001');

      ProfileLocalDatasource.saveLastProfile(response.data);

      return response;
    }
  }

  void _showNoInternetWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('Please enable internet and refresh profile.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: FutureBuilder<ProfileResponseModel>(
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
                return Column(
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
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
