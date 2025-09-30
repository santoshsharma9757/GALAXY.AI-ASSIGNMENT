import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_message.dart';
import '../models/chat_conversation.dart';

class ChatProvider extends ChangeNotifier {
  Box<ChatMessage>? _messagesBox;
  Box<ChatConversation>? _conversationsBox;
  
  String? _currentConversationId;
  List<ChatMessage> _currentMessages = [];
  List<ChatConversation> _conversations = [];
  bool _isStreaming = false;
  String _streamingText = '';

  List<ChatMessage> get currentMessages => _currentMessages;
  List<ChatConversation> get conversations => _conversations;
  bool get isStreaming => _isStreaming;
  String get streamingText => _streamingText;
  String? get currentConversationId => _currentConversationId;

  Future<void> initialize() async {
    _messagesBox = await Hive.openBox<ChatMessage>('messages');
    _conversationsBox = await Hive.openBox<ChatConversation>('conversations');
    await loadConversations();
    
    // Don't auto-load last conversation - start fresh each time
  }

  Future<void> loadConversations() async {
    if (_conversationsBox != null) {
      _conversations = _conversationsBox!.values.toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      notifyListeners();
    }
  }

  Future<void> createNewConversation(String modelUsed) async {
    final conversationId = const Uuid().v4();
    final conversation = ChatConversation(
      id: conversationId,
      title: 'New Chat',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      modelUsed: modelUsed,
      messageIds: [],
    );
    
    await _conversationsBox?.put(conversationId, conversation);
    _currentConversationId = conversationId;
    _currentMessages = [];
    await loadConversations();
    notifyListeners();
  }

  Future<void> loadConversation(String conversationId) async {
    _currentConversationId = conversationId;
    final conversation = _conversationsBox?.get(conversationId);
    
    if (conversation != null) {
      _currentMessages = conversation.messageIds
          .map((id) => _messagesBox?.get(id))
          .where((msg) => msg != null)
          .cast<ChatMessage>()
          .toList();
      notifyListeners();
    }
  }

  Future<void> sendMessage(String content, String modelUsed) async {
    if (_currentConversationId == null) {
      await createNewConversation(modelUsed);
    }

    // Add user message
    final userMessageId = const Uuid().v4();
    final userMessage = ChatMessage(
      id: userMessageId,
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );

    await _messagesBox?.put(userMessageId, userMessage);
    _currentMessages.add(userMessage);

    // Update conversation
    final conversation = _conversationsBox?.get(_currentConversationId!);
    if (conversation != null) {
      conversation.messageIds.add(userMessageId);
      
      // Update title with first message
      if (conversation.messageIds.length == 1) {
        conversation.title = content.length > 50 
            ? '${content.substring(0, 50)}...' 
            : content;
      }
      
      conversation.updatedAt = DateTime.now();
      await conversation.save();
    }

    notifyListeners();

    // Simulate AI response with streaming
    await _streamAIResponse(content, modelUsed);
  }

  Future<void> _streamAIResponse(String userMessage, String modelUsed) async {
    _isStreaming = true;
    _streamingText = '';
    notifyListeners();

    // Simulate AI response based on model
    final response = _generateResponse(userMessage, modelUsed);
    
    // Stream the response character by character
    for (int i = 0; i < response.length; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      _streamingText += response[i];
      notifyListeners();
    }

    // Save AI message
    final aiMessageId = const Uuid().v4();
    final aiMessage = ChatMessage(
      id: aiMessageId,
      content: _streamingText,
      isUser: false,
      timestamp: DateTime.now(),
    );

    await _messagesBox?.put(aiMessageId, aiMessage);
    _currentMessages.add(aiMessage);

    // Update conversation
    final conversation = _conversationsBox?.get(_currentConversationId!);
    if (conversation != null) {
      conversation.messageIds.add(aiMessageId);
      conversation.updatedAt = DateTime.now();
      await conversation.save();
    }

    _isStreaming = false;
    _streamingText = '';
    await loadConversations();
    notifyListeners();
  }

  String _generateResponse(String userMessage, String modelUsed) {
    final introduction = "Hello! I'm ChatGPT, powered by $modelUsed. ";
    
    if (userMessage.toLowerCase().contains('hello') || 
        userMessage.toLowerCase().contains('hi')) {
      return "${introduction}It's great to meet you! How can I assist you today?";
    } else if (userMessage.toLowerCase().contains('how are you')) {
      return "${introduction}I'm functioning well, thank you for asking! I'm here to help you with any questions or tasks you have.";
    } else if (userMessage.toLowerCase().contains('what can you do')) {
      return "${introduction}I can help you with a wide range of tasks including:\n\n• Answering questions\n• Writing and editing content\n• Brainstorming ideas\n• Analyzing data\n• Coding assistance\n• And much more!\n\nWhat would you like help with?";
    } else {
      return "${introduction}I understand you're asking about \"$userMessage\". I'm here to help! This is a demo response showing how the chat system works with streaming text and Hive database storage. Your conversation is being saved and can be accessed later from the chat history.";
    }
  }

  Future<void> deleteConversation(String conversationId) async {
    final conversation = _conversationsBox?.get(conversationId);
    if (conversation != null) {
      // Delete all messages
      for (final messageId in conversation.messageIds) {
        await _messagesBox?.delete(messageId);
      }
      // Delete conversation
      await _conversationsBox?.delete(conversationId);
      
      if (_currentConversationId == conversationId) {
        _currentConversationId = null;
        _currentMessages = [];
      }
      
      await loadConversations();
      notifyListeners();
    }
  }

  void clearCurrentConversation() {
    _currentConversationId = null;
    _currentMessages = [];
    notifyListeners();
  }
}
