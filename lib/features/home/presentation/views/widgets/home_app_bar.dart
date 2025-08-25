import 'package:ahmed_karam/core/utils/app_navigate.dart';
import 'package:ahmed_karam/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final GlobalKey _profileKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isHovering = false;

  void _showPopupMenu(BuildContext context) {
    if (_overlayEntry != null) return; // don’t show multiple

    final renderBox =
        _profileKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (_) {
        return Positioned(
          left: offset.dx - 32,
          top: offset.dy + size.height + 5, // under profile image
          child: MouseRegion(
            onEnter: (_) => _setHover(true),
            onExit: (_) => _setHover(false),
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                // width: 200,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  // color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    _removePopup();
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
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);

    // monitor hover to auto-close
    Future.delayed(const Duration(milliseconds: 200), () async {
      while (_isHovering) {
        await Future.delayed(const Duration(milliseconds: 200));
      }
      _removePopup();
    });
  }

  void _setHover(bool hovering) {
    setState(() => _isHovering = hovering);
  }

  void _removePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          context.go(AppNavigate.kLoginView);
        }
      },
      builder: (context, state) {
        return AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: SvgPicture.asset('assets/images/logo.svg'),
          actionsPadding: EdgeInsets.symmetric(horizontal: 16),
          actions: [
            GestureDetector(
              onTap:
                  isMobile
                      ? () {
                        _showPopupMenu(context);
                      }
                      : null,
              child: MouseRegion(
                key: _profileKey,
                onEnter:
                    isMobile
                        ? null
                        : (_) {
                          _setHover(true);
                          _showPopupMenu(context);
                        },
                onExit: isMobile ? null : (_) => _setHover(false),
                child: const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(
                    "assets/images/profile_image.jpeg",
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
