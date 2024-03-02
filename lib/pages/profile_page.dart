import 'package:flutter/material.dart';
import 'package:tasky/config/custom_text_styles.dart';
import 'package:tasky/widgets/box_container.dart';

class ProfileData {
  static const String name = 'Ilham Abdillah Alhamdi';
  static const String nickname = 'Hamdi';
  static const String major = 'Ilmu Komputer';
  static const String dateOfBirth = '17 October 2003';
  static const String email = 'ilhamabdillah123@gmail.com';
  static const String profileImage = 'images/profile.png';
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
      ),
      CustomScrollView(
          slivers: [
            const SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                title: Text("My Profile"),
                centerTitle: true,
                titlePadding: EdgeInsets.only(bottom: 16.0),
              ),
              pinned: true,
              stretch: true,
              expandedHeight: 200,
              collapsedHeight: 80,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
            ),
            SliverToBoxAdapter(
                child: Container(
                    padding: const EdgeInsets.all(16.0),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 160,
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(36.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            backgroundImage:
                                const AssetImage(ProfileData.profileImage),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          "Name",
                          style: CustomTextStyle.title(context),
                        ),
                        const BoxContainer(child: Text(ProfileData.name)),
                        const SizedBox(height: 16.0),
                        Text(
                          "Nickname",
                          style: CustomTextStyle.title(context),
                        ),
                        const BoxContainer(child: Text(ProfileData.nickname)),
                        const SizedBox(height: 16.0),
                        Text(
                          "Major",
                          style: CustomTextStyle.title(context),
                        ),
                        const BoxContainer(child: Text(ProfileData.major)),
                        const SizedBox(height: 16.0),
                        Text(
                          "Date of Birth",
                          style: CustomTextStyle.title(context),
                        ),
                        BoxContainer(
                            child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 8.0),
                            const Text(ProfileData.dateOfBirth),
                          ],
                        )),
                        const SizedBox(height: 16.0),
                        Text(
                          "Email",
                          style: CustomTextStyle.title(context),
                        ),
                        const BoxContainer(child: Text(ProfileData.email)),
                        const SizedBox(height: 16.0),
                      ],
                    )))
          ])
    ]);
  }
}
