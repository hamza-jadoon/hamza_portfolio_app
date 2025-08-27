import 'package:flutter/material.dart';
import 'package:hamza_portfolio_app/core/utils/responsive_helper.dart';
import 'package:hamza_portfolio_app/features/portfolio/data/models/skill_model.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/widgets/skill/common/skill_item.dart';
import 'package:hamza_portfolio_app/features/portfolio/presentation/widgets/skill/common/skills_data.dart';
import 'header_section.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.isDesktop(context) ? 60 : 20,
          vertical: 120,
        ),
        child: Column(
          children: [
            const SectionHeader(title: 'SKILLS'),
            const SizedBox(height: 80),
            _buildSkillSection(
              context,
              'CURRENT SKILLS',
              SkillsData.getCurrentSkills(),
              showTitle: false, // Hide title for main skills
            ),
            const SizedBox(height: 60),
            _buildSkillSection(
              context,
              'LEARNING',
              SkillsData.getLearningSkills(),
            ),
            const SizedBox(height: 60),
            _buildSkillSection(
              context,
              'OTHER SKILLS',
              SkillsData.getOtherSkills(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillSection(
      BuildContext context,
      String title,
      List<SkillModel> skills, {
        bool showTitle = true,
      }) {
    return Column(
      children: [
        if (showTitle) _buildSectionTitle(title),
        if (showTitle) const SizedBox(height: 40),
        _buildSkillsGrid(context, skills),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              letterSpacing: 1.5,
            ),
          ),
        );
      }
    );
  }

  Widget _buildSkillsGrid(BuildContext context, List<SkillModel> skills) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    // Determine cross axis count based on screen size
    int crossAxisCount;
    double childAspectRatio;

    if (isDesktop) {
      crossAxisCount = 5; // Show more skills on desktop
      childAspectRatio = 0.9;
    } else if (isTablet) {
      crossAxisCount = 4;
      childAspectRatio = 0.85;
    } else {
      crossAxisCount = 3; // Mobile
      childAspectRatio = 0.8;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: isDesktop ? 30 : 20,
          mainAxisSpacing: isDesktop ? 30 : 20,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: skills.length,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300 + (index * 100)),
            curve: Curves.easeOutBack,
            child: SkillItem(
              skill: skills[index],
              // Add animation delay based on index
              animationDelay: Duration(milliseconds: index * 100),
            ),
          );
        },
      ),
    );
  }
}

// Enhanced version with category filtering (optional)
class AdvancedSkillsPage extends StatefulWidget {
  const AdvancedSkillsPage({Key? key}) : super(key: key);

  @override
  State<AdvancedSkillsPage> createState() => _AdvancedSkillsPageState();
}

class _AdvancedSkillsPageState extends State<AdvancedSkillsPage>
    with TickerProviderStateMixin {
  String selectedCategory = 'All';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.isDesktop(context) ? 60 : 20,
            vertical: 120,
          ),
          child: Column(
            children: [
              const SectionHeader(title: 'SKILLS'),
              const SizedBox(height: 40),
              _buildCategoryFilter(),
              const SizedBox(height: 60),
              _buildFilteredSkills(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = ['All', ...SkillsData.getCategories()];

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: categories.map((category) {
        final isSelected = selectedCategory == category;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).primaryColor.withOpacity(0.2)
                    : Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(0.5),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                category.toUpperCase(),
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFilteredSkills() {
    List<SkillModel> filteredSkills;

    if (selectedCategory == 'All') {
      filteredSkills = SkillsData.getAllSkills();
    } else {
      filteredSkills = SkillsData.getSkillsByCategory(selectedCategory);
    }

    return _buildAnimatedSkillsGrid(filteredSkills);
  }

  Widget _buildAnimatedSkillsGrid(List<SkillModel> skills) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    int crossAxisCount;
    if (isDesktop) {
      crossAxisCount = 6;
    } else if (isTablet) {
      crossAxisCount = 4;
    } else {
      crossAxisCount = 3;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: GridView.builder(
        key: ValueKey(selectedCategory),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: isDesktop ? 25 : 15,
          mainAxisSpacing: isDesktop ? 25 : 15,
          childAspectRatio: 0.85,
        ),
        itemCount: skills.length,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300 + (index * 50)),
            curve: Curves.easeOutBack,
            child: SkillItem(
              skill: skills[index],
              animationDelay: Duration(milliseconds: index * 50),
            ),
          );
        },
      ),
    );
  }
}