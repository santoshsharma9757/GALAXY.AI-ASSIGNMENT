import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/widgets/gpt_model_dropdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/widgets/feature_container.dart';
import '../../../../core/widgets/chat_input_section.dart';
import '../../../../core/widgets/ai_bottom_sheet.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/providers/chat_provider.dart';
import '../../../upgrade/presentation/screens/upgrade_screen.dart';
import '../../../temporary_chat/presentation/screens/temporary_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _mainFeatures = [
    {'icon': 'assets/svg/create_image.svg', 'text': AppStrings.createImage},
    {'icon': 'assets/svg/brainstrom.svg', 'text': AppStrings.brainstorm},
    {'icon': 'assets/svg/code.svg', 'text': AppStrings.code},
    {'icon': 'assets/svg/get_advice.svg', 'text': AppStrings.getAdvice},
  ];

  final List<Map<String, dynamic>> _moreFeatures = [
    {'icon': 'assets/svg/surprise_me.svg', 'text': AppStrings.surpriseMe},
    {'icon': 'assets/svg/make_a_plan.svg', 'text': AppStrings.makeAPlan},
    {'icon': 'assets/svg/analyze_data.svg', 'text': AppStrings.analyzeData},
    {'icon': 'assets/svg/summarize_text.svg', 'text': AppStrings.summarizeText},
    {'icon': 'assets/svg/help_me_write.svg', 'text': AppStrings.helpMeWrite},
    {'icon': 'assets/svg/analyze_images.svg', 'text': AppStrings.analyzeImages},
  ];

  bool _showMoreFeatures = false;
  String _selectedModel = AppStrings.gpt4;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _onFeatureTap(String feature) {
    if (feature == AppStrings.more) {
      setState(() {
        _showMoreFeatures = true;
      });
    }
  }

  void _onSendMessage(String message) {
    if (message.trim().isNotEmpty) {
      context.read<ChatProvider>().sendMessage(message.trim(), _selectedModel);
    }
  }

  void _onFileUpload() {
    // Handle file upload
  }

  void _onVoiceInput() {
    // Handle voice input
  }

  void _onModelChanged(String model) {
    setState(() {
      _selectedModel = model;
      _showMoreFeatures = false; // Reset "More" features when changing model
    });
    // Clear current conversation and start fresh with new model
    context.read<ChatProvider>().clearCurrentConversation();
  }

  void _showAiBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AiBottomSheet(
        onCameraTap: () {
          Navigator.pop(context);
        },
        onPhotosTap: () {
          Navigator.pop(context);
        },
        onFilesTap: () {
          Navigator.pop(context);
        },
        onThinkLongerTap: () {
          Navigator.pop(context);
        },
        onDeepResearchTap: () {
          Navigator.pop(context);
        },
        onStudyAndLearnTap: () {
          Navigator.pop(context);
        },
        onCreateImageTap: () {
          Navigator.pop(context);
        },
        onWebSearchTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          const SizedBox(height: AppDimensions.paddingXXXXL),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingS,
            ),
            child: Builder(
              builder: (context) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Drawer icon
                  IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: SvgPicture.asset(
                      'assets/svg/menu.svg',
                      width: AppDimensions.iconM,
                      height: AppDimensions.iconM,
                      colorFilter: const ColorFilter.mode(
                        AppColors.iconPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  // const Spacer(),
                  // Upgrade button
                  _buildUpgradeButton(context),
                  // Message icon
                  _buildTemporaryMessage(context),
                ],
              ),
            ),
          ),
          // Main content area
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                final hasMessages =
                    chatProvider.currentMessages.isNotEmpty ||
                    chatProvider.isStreaming;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (hasMessages) {
                    _scrollToBottom();
                  }
                });

                return Column(
                  children: [
                    // Model Dropdown (always visible)
                    const SizedBox(height: AppDimensions.paddingXL),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: AppDimensions.paddingM,
                        ),
                        child: GptModelDropdown(
                          selectedModel: _selectedModel,
                          onModelChanged: _onModelChanged,
                        ),
                      ),
                    ),

                    // Content Area
                    Expanded(
                      child: hasMessages
                          ? _buildChatView(chatProvider)
                          : _buildWelcomeView(),
                    ),
                  ],
                );
              },
            ),
          ),

          // Bottom input section
          ChatInputSection(
            onSendMessage: _onSendMessage,
            onFileUpload: _onFileUpload,
            onVoiceInput: _onVoiceInput,
            onShowBottomSheet: _showAiBottomSheet,
          ),
        ],
      ),
    );
  }

   _buildTemporaryMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppDimensions.paddingS),
      child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TemporaryChatScreen(),
                ),
              );
            },
            icon: const Icon(Icons.chat_bubble_outline),
          ),
    );
  }

  GestureDetector _buildUpgradeButton(BuildContext context) {
    return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UpgradeScreen()),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(right: AppDimensions.paddingS),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingXS,
            ),
            decoration: BoxDecoration(
              color:AppColors.grey.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.workspace_premium,
                  color: AppColors.primary,
                  size: AppDimensions.iconS,
                ),
                const SizedBox(width: 4),
                const Text(
                  'Upgrade',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
  }

  Widget _buildWelcomeView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingXXL),
      child: Column(
        children: [
          const SizedBox(height: 60),
          // Centered welcome text
          const Text(
            AppStrings.welcomeMessage,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.paddingXXXL),
          // Feature containers
          Wrap(
            spacing: AppDimensions.paddingM,
            runSpacing: AppDimensions.paddingM,
            alignment: WrapAlignment.center,
            children: [
              // Main features (always visible)
              ..._mainFeatures.map(
                (feature) => FeatureContainer(
                  icon: feature['icon'],
                  text: feature['text'],
                  onTap: () => _onFeatureTap(feature['text']),
                ),
              ),
              // More button (only show if not expanded)
              if (!_showMoreFeatures)
                GestureDetector(
                  onTap: () => _onFeatureTap(AppStrings.more),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingL,
                      vertical: AppDimensions.paddingM,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusL,
                      ),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Text(
                      AppStrings.more,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              // More features (only show when expanded)
              if (_showMoreFeatures)
                ..._moreFeatures.map(
                  (feature) => FeatureContainer(
                    icon: feature['icon'],
                    text: feature['text'],
                    onTap: () => _onFeatureTap(feature['text']),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingXXXL),
        ],
      ),
    );
  }

  Widget _buildChatView(ChatProvider chatProvider) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      itemCount:
          chatProvider.currentMessages.length +
          (chatProvider.isStreaming ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < chatProvider.currentMessages.length) {
          final message = chatProvider.currentMessages[index];
          return _MessageBubble(
            content: message.content,
            isUser: message.isUser,
          );
        } else {
          // Streaming message
          return _MessageBubble(
            content: chatProvider.streamingText,
            isUser: false,
            isStreaming: true,
          );
        }
      },
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String content;
  final bool isUser;
  final bool isStreaming;

  const _MessageBubble({
    required this.content,
    required this.isUser,
    this.isStreaming = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingL),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              decoration: BoxDecoration(
                color: isUser
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              ),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
              ),
            ),
            if (isStreaming)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Typing...',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
