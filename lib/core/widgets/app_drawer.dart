import 'package:flutter/material.dart';
import 'package:flutter_application_5/features/settings/presentation/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_strings.dart';
import '../providers/chat_provider.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _searchFocusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {
      _isSearching = _searchFocusNode.hasFocus;
    });
  }

  void _onSearchChanged() {
    setState(() {});
  }

  void _openSettingsDrawer() {
    Navigator.pop(context); // Close main drawer
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: _isSearching ? MediaQuery.of(context).size.width : null,
      child: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusL,
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        decoration: InputDecoration(
                          hintText: AppStrings.search,
                          hintStyle: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.iconSecondary,
                            size: AppDimensions.iconM,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingL,
                            vertical: AppDimensions.paddingM,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.paddingM),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      context.read<ChatProvider>().clearCurrentConversation();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingS),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusM,
                        ),
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        color: AppColors.iconPrimary,
                        size: AppDimensions.iconM,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingS,
              ),
              child: Column(
                children: [
                  _DrawerMenuItem(
                    icon: Icons.edit_outlined,
                    title: AppStrings.newChat,
                    onTap: () {
                      Navigator.pop(context);
                      context.read<ChatProvider>().clearCurrentConversation();
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.collections_bookmark_outlined,
                    title: AppStrings.library,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.apps,
                    title: AppStrings.gpts,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.folder_outlined,
                    title: AppStrings.projects,
                    badge: AppStrings.newBadge,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.paddingM),

            // Chat History List
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, chatProvider, child) {
                  final searchText = _searchController.text.toLowerCase();
                  final filteredConversations = searchText.isEmpty
                      ? chatProvider.conversations
                      : chatProvider.conversations
                          .where((conv) =>
                              conv.title.toLowerCase().contains(searchText))
                          .toList();

                  if (filteredConversations.isEmpty) {
                    return const Center(
                      child: Text(
                        'No conversations yet',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingS,
                    ),
                    itemCount: filteredConversations.length,
                    itemBuilder: (context, index) {
                      final conversation = filteredConversations[index];
                      return ListTile(
                        title: Text(
                          conversation.title,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                conversationId: conversation.id,
                                selectedModel: conversation.modelUsed,
                              ),
                            ),
                          );
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingL,
                          vertical: AppDimensions.paddingXS,
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // User Profile Section
            GestureDetector(
              onTap: _openSettingsDrawer,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.border, width: 1),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    backgroundImage: const NetworkImage(
                      'https://i.pravatar.cc/150?img=33',
                    ),
                  ),
                  title: const Text(
                    'santosh sharma',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.iconSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? badge;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.title,
    this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.iconPrimary,
        size: AppDimensions.iconM,
      ),
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
          ),
          if (badge != null) ...[
            const SizedBox(width: AppDimensions.paddingS),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingS,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ],
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: 0,
      ),
      dense: true,
    );
  }
}
