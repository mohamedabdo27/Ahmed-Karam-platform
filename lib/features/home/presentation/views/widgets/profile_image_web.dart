import 'package:ahmed_karam/core/constants.dart';
import 'package:ahmed_karam/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'dart:io' show Platform;
// import 'package:flutter/foundation.dart' show kIsWeb;
// class ProfileImage extends StatefulWidget {
//   const ProfileImage({super.key, required this.raduis});
//   final double raduis;
//   @override
//   State<ProfileImage> createState() => _ProfileImageState();
// }
// class _ProfileImageState extends State<ProfileImage> {
//   final GlobalKey _profileKey = GlobalKey();
//   OverlayEntry? _overlayEntry;
//   bool _isHovering = false;
//   void _showPopupMenu(BuildContext context) {
//     if (_overlayEntry != null) return; // don’t show multiple
//     final renderBox =
//         _profileKey.currentContext!.findRenderObject() as RenderBox;
//     final offset = renderBox.localToGlobal(Offset.zero);
//     final size = renderBox.size;
//     _overlayEntry = OverlayEntry(
//       builder: (_) {
//         return Positioned(
//           left: offset.dx - 32,
//           top: offset.dy + size.height + 5, // under profile image
//           child: MouseRegion(
//             onEnter: (_) => _setHover(true),
//             onExit: (_) => _setHover(false),
//             child: Material(
//               elevation: 8,
//               borderRadius: BorderRadius.circular(8),
//               child: Container(
//                 // width: 200,
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   // color: Colors.green,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: TextButton(
//                   onPressed: () {
//                     _removePopup();
//                     BlocProvider.of<HomeCubit>(context).logout();
//                   },
//                   child: const Text(
//                     "Logout",
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//     Overlay.of(context).insert(_overlayEntry!);
//     // monitor hover to auto-close
//     Future.delayed(const Duration(milliseconds: 200), () async {
//       while (_isHovering) {
//         await Future.delayed(const Duration(milliseconds: 200));
//       }
//       _removePopup();
//     });
//   }
//   void _setHover(bool hovering) {
//     setState(() => _isHovering = hovering);
//   }
//   void _removePopup() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }
//   @override
//   Widget build(BuildContext context) {
//    final isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {
//         if (state is LogoutSuccessState) {
//           context.go(AppNavigate.kLoginView);
//         }
//       },
//       builder: (context, state) {
//         return GestureDetector(
//           onTap:
//               isMobile
//                   ? () {
//                     _showPopupMenu(context);
//                   }
//                   : null,
//           child: MouseRegion(
//             key: _profileKey,
//             onEnter:
//                 isMobile
//                     ? null
//                     : (_) {
//                       _setHover(true);
//                       _showPopupMenu(context);
//                     },
//             onExit: isMobile ? null : (_) => _setHover(false),
//             child: CircleAvatar(
//               radius: widget.raduis,
//               backgroundImage:
//                   userModel?.image == null
//                       ? AssetImage("assets/images/profile_image.jpeg")
//                       : CachedNetworkImageProvider(userModel!.image!),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class ProfileImageWeb extends StatefulWidget {
  const ProfileImageWeb({super.key});

  @override
  State<ProfileImageWeb> createState() => _ProfileImageWebState();
}

class _ProfileImageWebState extends State<ProfileImageWeb> {
  final GlobalKey _profileKey = GlobalKey();

  void showCustomPopup(context) {
    final RenderBox renderBox =
        _profileKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    showDialog(
      context: context,
      barrierColor: Colors.transparent, // don’t darken the background
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              left: offset.dx - 32,
              top: offset.dy + size.height, // exactly under the profile image
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                      BlocProvider.of<HomeCubit>(context).logout();
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCustomPopup(context);
      },
      child: CircleAvatar(
        key: _profileKey,
        radius: 28,
        backgroundImage:
            userModel?.image == null
                ? AssetImage("assets/images/profile_image.jpeg")
                : CachedNetworkImageProvider(userModel!.image!),
      ),
    );
  }
}
