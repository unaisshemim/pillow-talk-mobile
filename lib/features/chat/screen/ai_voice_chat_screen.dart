import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/common/ui/button/icon_button.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

enum AIVoiceState { idle, connecting, listening, thinking, speaking }

class AIVoiceChatScreen extends StatefulWidget {
  final String? chatId;
  final String? topic;

  const AIVoiceChatScreen({super.key, this.chatId, this.topic});

  @override
  State<AIVoiceChatScreen> createState() => _AIVoiceChatScreenState();
}

class _AIVoiceChatScreenState extends State<AIVoiceChatScreen>
    with SingleTickerProviderStateMixin {
  AIVoiceState _voiceState = AIVoiceState.connecting;

  // One lightweight controller to create the “breathing” orb
  late final AnimationController _breathCtrl;

  bool _isMuted = false;
  bool _isSpeakerOn = true;

  @override
  void initState() {
    super.initState();

    _breathCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat(reverse: true);

    // Simple simulated flow: Connecting -> Listening -> Speaking
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() => _voiceState = AIVoiceState.listening);
    });
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      setState(() => _voiceState = AIVoiceState.speaking);
    });
  }

  @override
  void dispose() {
    _breathCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        context.pColor.primary.base.withOpacity(0.10),
        context.pColor.secondary.base.withOpacity(0.12),
      ],
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: bg),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: PSizes.s16),
            child: Column(
              children: [
                const SizedBox(height: PSizes.s8),
                _buildHeader(context),
                const SizedBox(height: PSizes.s8),
                Expanded(child: _buildCenter(context)),
                const SizedBox(height: PSizes.s8),
                _buildCallBar(context),
                const SizedBox(height: PSizes.s16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────── HEADER ───────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        PIconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        const Spacer(),
        if (widget.topic != null && widget.topic!.trim().isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PSizes.s12,
              vertical: PSizes.s4,
            ),
            decoration: BoxDecoration(
              color: context.pColor.primary.base.withOpacity(0.12),
              borderRadius: BorderRadius.circular(PSizes.s16),
            ),
            child: Text(
              widget.topic!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: responsive(context, PSizes.s12),
                color: context.pColor.primary.base,
              ),
            ),
          ),
      ],
    );
  }

  // ─────────────────────────────── CENTER AREA ────────────────────────────────

  Widget _buildCenter(BuildContext context) {
    final (label, icon, color) = _statusMeta();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // The orb
        AnimatedBuilder(
          animation: _breathCtrl,
          builder: (_, __) {
            // 0.96 ↔ 1.04 subtle scale
            final t = _breathCtrl.value;
            final scale = 1.0 + 0.04 * math.sin(t * 2 * math.pi);

            return Transform.scale(
              scale: scale,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    stops: const [0.0, 0.6, 1.0],
                    colors: [
                      color.withOpacity(0.30),
                      color.withOpacity(0.12),
                      Colors.transparent,
                    ],
                  ),
                  border: Border.all(color: color.withOpacity(0.35), width: 2),
                ),
                child: Center(
                  child: Icon(
                    _iconForState(),
                    size: 64,
                    color: color.withOpacity(0.95),
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: PSizes.s16),

        // Status chip
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: PSizes.s12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.10),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: responsive(context, PSizes.s14),
                  color: color,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: PSizes.s12),

        // Optional captions line (very light, single line)
        Opacity(
          opacity:
              (_voiceState == AIVoiceState.speaking ||
                  _voiceState == AIVoiceState.listening)
              ? 1
              : 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: PSizes.s20),
            child: Text(
              _voiceState == AIVoiceState.listening
                  ? 'Listening…'
                  : '“Hi! How are you both feeling today?”',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.pColor.neutral.n80,
                fontSize: responsive(context, PSizes.s14),
                height: 1.3,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ───────────────────────────────── CALL BAR ────────────────────────────────

  Widget _buildCallBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _roundActionButton(
          icon: _isMuted ? Icons.mic_off : Icons.mic,
          active: !_isMuted,
          onTap: _toggleMute,
        ),
        _endCallButton(context),
        _roundActionButton(
          icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_down,
          active: _isSpeakerOn,
          onTap: _toggleSpeaker,
        ),
      ],
    );
  }

  Widget _roundActionButton({
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
  }) {
    final color = active
        ? context.pColor.primary.base
        : context.pColor.neutral.n60;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active ? color.withOpacity(0.14) : context.pColor.neutral.n20,
          border: Border.all(
            color: active ? color : context.pColor.neutral.n40,
            width: 2,
          ),
        ),
        child: Icon(icon, color: color, size: 26),
      ),
    );
  }

  Widget _endCallButton(BuildContext context) {
    return GestureDetector(
      onTap: _endVoiceChat,
      child: Container(
        width: 76,
        height: 76,
        decoration: BoxDecoration(
          color: context.pColor.error.base,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.call_end,
          color: context.pColor.neutral.n10,
          size: 34,
        ),
      ),
    );
  }

  // ────────────────────────────── STATE HELPERS ──────────────────────────────

  (String, IconData, Color) _statusMeta() {
    switch (_voiceState) {
      case AIVoiceState.connecting:
        return (
          'Connecting…',
          Icons.wifi_tethering,
          context.pColor.primary.base,
        );
      case AIVoiceState.listening:
        return ('Listening', Icons.hearing, context.pColor.success.base);
      case AIVoiceState.thinking:
        return ('Thinking…', Icons.psychology, context.pColor.secondary.base);
      case AIVoiceState.speaking:
        return (
          'Speaking',
          Icons.record_voice_over,
          context.pColor.primary.base,
        );
      case AIVoiceState.idle:
      default:
        return ('Ready', Icons.chat_bubble_outline, context.pColor.neutral.n70);
    }
  }

  IconData _iconForState() {
    switch (_voiceState) {
      case AIVoiceState.listening:
        return Icons.hearing;
      case AIVoiceState.speaking:
        return Icons.graphic_eq;
      case AIVoiceState.thinking:
        return Icons.psychology;
      case AIVoiceState.connecting:
        return Icons.wifi_tethering;
      case AIVoiceState.idle:
      default:
        return Icons.circle;
    }
  }

  // ──────────────────────────────── ACTIONS ──────────────────────────────────

  void _endVoiceChat() {
    Navigator.pop(context);
  }

  void _toggleMute() {
    setState(() => _isMuted = !_isMuted);
    // TODO: integrate with your audio input route
  }

  void _toggleSpeaker() {
    setState(() => _isSpeakerOn = !_isSpeakerOn);
    // TODO: integrate with your audio output route (speaker/earpiece/Bluetooth)
  }
}
