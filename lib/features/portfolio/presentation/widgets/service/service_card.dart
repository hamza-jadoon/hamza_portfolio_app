import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:hamza_portfolio_app/core/constants/app_colors.dart';
import 'package:hamza_portfolio_app/core/constants/app_constants.dart';
import 'package:hamza_portfolio_app/core/constants/app_texts.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/services_model.dart';


class ServiceCard extends StatefulWidget {
  final ServiceModel service;

  const ServiceCard({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: _isHovered
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).secondaryHeaderColor,
                borderRadius: BorderRadius.circular(16),
                border: _isHovered
                    ? Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  width: 1,
                )
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? Theme.of(context).primaryColor.withOpacity(0.2)
                        :  Theme.of(context).primaryColor.withOpacity(0.1),
                    blurRadius: 20 + (_elevationAnimation.value * 10),
                    offset: Offset(0, 8 + (_elevationAnimation.value * 7)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).scaffoldBackgroundColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          widget.service.icon ?? _getIconForService(widget.service.title),
                          color:  Theme.of(context).primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          widget.service.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text(
                    widget.service.description,
                    style: TextStyle(
                      fontSize: 15,
                        color: Theme.of(context).primaryColor,
                      height: 1.6,
                      letterSpacing: 0.3,
                    ),
                  ),
                  if (_isHovered) ...[
                    const SizedBox(height: 20),
                    Container(
                      height: 3,
                      width: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                           Theme.of(context).secondaryHeaderColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  IconData _getIconForService(String title) {
    switch (title.toUpperCase()) {
      case AppTextContent.design:
        return Icons.palette_outlined;
      case AppTextContent.development:
        return Icons.code_outlined;
      case AppTextContent.maintenance:
        return Icons.build_outlined;
      default:
        return Icons.star_outline;
    }
  }
}