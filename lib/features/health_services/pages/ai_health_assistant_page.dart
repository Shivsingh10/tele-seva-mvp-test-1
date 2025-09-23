import 'package:flutter/material.dart';

class AIHealthAssistantPage extends StatefulWidget {
  const AIHealthAssistantPage({super.key});

  @override
  State<AIHealthAssistantPage> createState() => _AIHealthAssistantPageState();
}

class _AIHealthAssistantPageState extends State<AIHealthAssistantPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _messages.add({
      'text':
          'Hello! I\'m your AI Health Assistant. I can help you check your symptoms, provide health information, and guide you to appropriate care. How can I help you today?',
      'isUser': false,
      'timestamp': DateTime.now(),
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text,
        'isUser': true,
        'timestamp': DateTime.now(),
      });
    });

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'text': _getAIResponse(_messageController.text),
          'isUser': false,
          'timestamp': DateTime.now(),
        });
      });
      _scrollToBottom();
    });

    _messageController.clear();
    _scrollToBottom();
  }

  String _getAIResponse(String userMessage) {
    String message = userMessage.toLowerCase();

    if (message.contains('headache') || message.contains('head pain')) {
      return 'Headaches can have various causes. Common triggers include stress, dehydration, lack of sleep, or eye strain. Try resting in a quiet, dark room and staying hydrated. If headaches persist or are severe, please consult a doctor.';
    } else if (message.contains('fever') || message.contains('temperature')) {
      return 'Fever is your body\'s natural response to infection. Stay hydrated, rest, and monitor your temperature. Seek immediate medical attention if fever exceeds 103°F (39.4°C) or if you experience difficulty breathing.';
    } else if (message.contains('cough') || message.contains('cold')) {
      return 'For cough and cold symptoms, try warm saltwater gargles, honey (for ages 1+), and plenty of fluids. Rest is important. If symptoms worsen or persist beyond 7-10 days, consult a healthcare provider.';
    } else if (message.contains('stomach') || message.contains('nausea')) {
      return 'For stomach discomfort, try the BRAT diet (bananas, rice, applesauce, toast) and stay hydrated with small sips of water. Avoid dairy and fatty foods. Contact a doctor if symptoms are severe or persistent.';
    } else if (message.contains('emergency') || message.contains('urgent')) {
      return 'This seems like it might be urgent. For medical emergencies, please call emergency services immediately or visit the nearest emergency room. Don\'t delay seeking professional medical care.';
    } else {
      return 'Thank you for sharing your concern. While I can provide general health information, I recommend consulting with a qualified healthcare professional for personalized medical advice. Would you like me to help you find nearby doctors or medical facilities?';
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('AI Health Assistant'),
        backgroundColor: const Color(0xFFEA2A33),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _messages.clear();
                _messages.add({
                  'text':
                      'Hello! I\'m your AI Health Assistant. I can help you check your symptoms, provide health information, and guide you to appropriate care. How can I help you today?',
                  'isUser': false,
                  'timestamp': DateTime.now(),
                });
              });
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'Clear Chat',
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick Actions Header
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Health Checks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildQuickActionChip('Headache', Icons.psychology),
                      const SizedBox(width: 8),
                      _buildQuickActionChip('Fever', Icons.thermostat),
                      const SizedBox(width: 8),
                      _buildQuickActionChip('Cough', Icons.sick),
                      const SizedBox(width: 8),
                      _buildQuickActionChip(
                        'Stomach Pain',
                        Icons.monitor_heart,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Chat Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Describe your symptoms...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Color(0xFFEA2A33)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (value) => _sendMessage(),
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFEA2A33),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionChip(String label, IconData icon) {
    return InkWell(
      onTap: () {
        _messageController.text = 'I have $label';
        _sendMessage();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.blue.shade600),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isUser = message['isUser'] as bool;
    final text = message['text'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.smart_toy,
                size: 18,
                color: Colors.blue.shade600,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? const Color(0xFFEA2A33) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: isUser ? Colors.white : const Color(0xFF111827),
                ),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.person, size: 18, color: Colors.grey.shade600),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
