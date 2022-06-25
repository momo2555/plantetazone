import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:plantetazone/components/actionButton.dart';
import 'package:plantetazone/components/profileListElement.dart';
import 'package:plantetazone/controler/profilController.dart';
import 'package:plantetazone/controler/userConnection.dart';
import 'package:plantetazone/models/userProfileModel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfileModel? userProfile;
  ProfileController profileControler = ProfileController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileControler.getUserProfile.then((UserProfileModel user) {
      setState(() => userProfile = user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      userProfile != null ? userProfile?.getUserName : '',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                    RatingBarIndicator(
                      itemBuilder: (context, index) => Icon(Icons.star,
                          color: Theme.of(context).primaryColor),
                      itemCount: 5,
                      rating:
                          userProfile != null ? userProfile?.getUserRate : 0,
                      itemSize: 25,
                    ),
                  ],
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 60,
                      backgroundImage: userProfile != null
                          ? NetworkImage(userProfile?.getUserProfileImageURL)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).backgroundColor,
                                width: 3),
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(17.5),
                          ),
                          height: 35,
                          width: 35,
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ]),
        ),
        Expanded(
          flex: 1,
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              //profile description
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  userProfile != null ? userProfile?.getUserDescription : '',
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              //followers + publications
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '57 abonnés',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '2 publications',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              //porte feuille
              InkWell(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(
                      Icons.mail,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Porte feuille',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 16)),
                  ]),
                  Text('47,00€',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ],
              )),
              SizedBox(
                height: 35,
              ),

              ProfileListElement(
                  icon: Icons.person,
                  title: 'Aperçu de mon profil',
                  description: 'Voir à quoi ressemble mon profil',
                  action: () {}),
              SizedBox(
                height: 23,
              ),

              ProfileListElement(
                  icon: Icons.edit,
                  title: 'Editer mon profil',
                  description: 'Voir à quoi ressemble mon profil',
                  action: () {}),
              SizedBox(
                height: 23,
              ),

              ProfileListElement(
                  icon: Icons.payment,
                  title: 'payement et livraison',
                  description: 'Voir à quoi ressemble mon profil',
                  action: () {}),
              SizedBox(
                height: 23,
              ),

              ProfileListElement(
                  icon: Icons.dvr,
                  title: 'Mes publications',
                  description: 'Voir à quoi ressemble mon profil',
                  action: () {}),
              SizedBox(
                height: 23,
              ),

              ProfileListElement(
                  icon: Icons.local_mall,
                  title: 'Mes achats',
                  description: 'Voir à quoi ressemble mon profil',
                  action: () {}),
              SizedBox(
                height: 23,
              ),

              ProfileListElement(
                  icon: Icons.comment,
                  title: 'Mes avis',
                  description: 'Voir à quoi ressemble mon profil',
                  action: () {}),
              SizedBox(
                height: 23,
              ),

              ProfileListElement(
                  icon: Icons.people,
                  title: 'Mes abonnements',
                  description: 'Voir à quoi ressemble mon profil',
                  action: () {}),

              //log out button, bouton de déconnexion
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                      text: 'Déconnexion',
                      action: () {
                        UserConnection userConnection = UserConnection();
                        userConnection.logout();
                      }),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
