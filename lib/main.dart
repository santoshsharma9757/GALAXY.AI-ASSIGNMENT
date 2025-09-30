import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/models/chat_message.dart';
import 'core/models/chat_conversation.dart';
import 'core/providers/chat_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Adapters
  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(ChatConversationAdapter());
  
  // Initialize ChatProvider
  final chatProvider = ChatProvider();
  await chatProvider.initialize();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: chatProvider),
      ],
      child:  MyApp(),
    ),
  );
}
