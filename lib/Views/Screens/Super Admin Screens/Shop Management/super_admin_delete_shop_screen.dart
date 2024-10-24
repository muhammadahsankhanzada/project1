import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class SuperAdminDeleteShopScreen extends StatefulWidget {
  const SuperAdminDeleteShopScreen({super.key});

  @override
  State<SuperAdminDeleteShopScreen> createState() =>
      _SuperAdminDeleteShopScreenState();
}

class _SuperAdminDeleteShopScreenState
    extends State<SuperAdminDeleteShopScreen> {
  final _formKey = GlobalKey<FormState>();
  var _searchController = TextEditingController();
  bool isSearching = false;
  bool isShopSelected = false;
  String searchedText = '';

  // Selected shop details
  String selectedShopName = '';
  String selectedShopImage = '';
  String selectedShopAddress = '';
  String selectedShopContact = '';
  String selectedShopEmail = '';

  void _onChanged(String value) {
    setState(() {
      isSearching = value.isNotEmpty; // Update isSearching based on input
      searchedText = value.toLowerCase();
      isShopSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Delete Shop'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Delete Shop',
                    style: AppTextStyles.nameHeadingTextStyle(size: 20),
                  ),
                ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Text(
                //     'Are you sure you want to delete this shop?\nThis action cannot be undone..',
                //     style: AppTextStyles.belowMainHeadingTextStyle(
                //       fontSize: 15,
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),
                AnimatedContainer(
                  // height: isSearching ? 300 : 50,
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(isSearching ? 15 : 30),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: TextFormField(
                          controller: _searchController,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Enter driver name here';
                          //   }
                          //   return null;
                          // },
                          onChanged: _onChanged,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Search shop name...',
                            // filled: true,
                            // fillColor: AppColors.white,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 30),
                            suffixIcon: Icon(
                              Icons.search,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      AnimatedSize(
                        duration: Duration(milliseconds: 500),
                        child: Visibility(
                          visible: isSearching,
                          child: Column(
                            children: [
                              Divider(
                                color: AppColors.grey,
                                indent: 30,
                                endIndent: 30,
                              ),
                              searchShops(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: isShopSelected,
                  child: Container(
                    // height: 200,
                    width: 300,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(selectedShopImage),
                        ),
                        Text(
                          selectedShopName,
                          style: AppTextStyles.simpleHeadingTextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Address:',
                                    style: AppTextStyles.simpleHeadingTextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Contact:',
                                    style: AppTextStyles.simpleHeadingTextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Email:',
                                    style: AppTextStyles.simpleHeadingTextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedShopAddress,
                                    style: AppTextStyles.simpleHeadingTextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    selectedShopContact,
                                    style: AppTextStyles.simpleHeadingTextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    selectedShopEmail,
                                    style: AppTextStyles.simpleHeadingTextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: isShopSelected,
                  child: UniversalButton(
                      buttonWidth: 250,
                      title: 'Delete Shop',
                      ontap: () {
                        // if (_formKey.currentState!.validate()) {}
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: Container(
                                  height: 200,
                                  width: 300,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.lightGreen,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Text(
                                        'Delete Shop?',
                                        style: AppTextStyles
                                            .nameHeadingTextStyle(),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Are you sure you want to delete.\nAll associated data will be deleted.',
                                        style: AppTextStyles
                                            .belowMainHeadingTextStyle(),
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          UniversalButton(
                                              title: 'Cancel',
                                              buttonHeight: 40,
                                              buttonWidth: 110,
                                              // buttonColor: AppColors.red.shade300,
                                              ontap: () {
                                                Navigator.pop(context);
                                              }),
                                          UniversalButton(
                                              title: 'Delete',
                                              buttonHeight: 40,
                                              buttonWidth: 110,
                                              buttonColor: AppColors
                                                  .universalButtonGreen,
                                              ontap: () {
                                                deleteShop(selectedShopName);
                                                Navigator.pop(context);
                                                customSnackbar(
                                                    context, 'Shop deleted.');
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom Textfield
  textField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required FormFieldValidator validator,
    required TextInputType keyboardType,
  }) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.nameHeadingTextStyle(size: 15),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Icon(
                icon,
                color: AppColors.green,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget searchShops() {
    CollectionReference firestore =
        FirebaseFirestore.instance.collection('Shops');

    return StreamBuilder<QuerySnapshot>(
      stream: firestore.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No shops found.'));
        }

        final shops = snapshot.data!.docs;

        // Filter shops based on the searchedText
        final filteredShops = shops.where((shop) {
          final shopName = (shop['name'] ?? '').toLowerCase();
          // final shopAddress = (shop['address'] ?? '').toLowerCase();
          return shopName.contains(searchedText);
          //  || shopAddress.contains(searchedText);
        }).toList();

        return SizedBox(
          height: 300,
          child: filteredShops.isEmpty
              ? Center(
                  child: Text(
                  'No Shops found',
                  style: AppTextStyles.simpleHeadingTextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ))
              : ListView.builder(
                  padding: EdgeInsets.only(left: 20),
                  itemCount: filteredShops.length,
                  itemBuilder: (context, index) {
                    final shop = filteredShops[index];
                    final shopImage = shop['imageUrl'];
                    final shopName = shop['name'] ?? 'No Name';
                    final shopAddress = shop['address'] ?? 'No Address';

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(shopImage),
                      ),
                      title: Text(shopName),
                      subtitle: Text(shopAddress),
                      onTap: () {
                        // Assign the selected shop details
                        selectedShopName = filteredShops[index]['name'];
                        selectedShopImage =
                            filteredShops[index]['imageUrl'] ?? '';
                        selectedShopAddress =
                            filteredShops[index]['address'] ?? 'No Address';
                        selectedShopContact =
                            filteredShops[index]['contact'] ?? 'No Contact';
                        selectedShopEmail =
                            filteredShops[index]['email'] ?? 'No Email';
                        setState(() {
                          _searchController.text = '';
                          searchedText = '';
                          isSearching = false;
                          isShopSelected = true;
                          final selectedShopName = filteredShops[index]['name'];
                          print(selectedShopName);
                        });
                      },
                    );
                  },
                ),
        );
      },
    );
  }

  deleteShop(String shopId) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('Shops').doc(shopId).delete();
    print('Shop deleted with id: $shopId');
  }
}
