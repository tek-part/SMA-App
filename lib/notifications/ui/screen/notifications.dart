import 'package:bandora_app/notifications/logic/cubit/notifications_cubit.dart';
import 'package:bandora_app/notifications/logic/state/notifications_state.dart';
import 'package:bandora_app/utils/them.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../core/notification_services/notification_services.dart';
import '../../data/model/notifications_response.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> with TickerProviderStateMixin {
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    context.read<NotificationsCubit>().fetchFirstPage();
    _scrollController.addListener(_onScroll);
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final cubit = context.read<NotificationsCubit>();
      if (cubit.hasMore) {
        cubit.fetchNextPage();
      }
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: BlocListener<NotificationsCubit, NotificationsState>(
            listener: (context, state) async {
              state.maybeWhen(
                success: (notificationsResponse) async {
                  final unreadCount = notificationsResponse.data?.unreadCount ?? 0;
                  print("objects$unreadCount");
                  if (unreadCount > 0) {
                    await NotificationService.cancelAllNotifications();
                  }
                },
                error: (error) => _showErrorSnackBar(error),
                orElse: () {},
              );
            },
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),
                  loading: () => _buildLoadingState(),
                  success: (notificationsResponse) => _buildSuccessState(notificationsResponse),
                  error: (error) => _buildErrorState(error),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: mainColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'إشعارات',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.sp,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w500,
          height: 0,
          letterSpacing: -0.30,
        ),
      ),
      leading: Container(
        margin: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: const Color(0xFF1A1A1A),
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        color: mainColor,
      ),
    );
  }

  Widget _buildSuccessState(NotificationsResponse notificationsResponse) {
    final notifications = notificationsResponse.data?.notifications ?? [];

    if (notifications.isEmpty) {
      return Center(
        child: Lottie.asset(
          'assets/lottie/Animation - 1700715930477.json',
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.w),
          margin: EdgeInsets.only(bottom: 15.h),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 0.50,
                color: Color(0xFFCED5E1),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x7FCCCCCD),
                blurRadius: 1,
                offset: Offset(1, 0.50),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextUtils(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                text: notification.title ?? 'عنوان غير معروف',
              ),
              SizedBox(height: 5.h),
              TextUtils(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: GreyClr,
                text: notification.message ?? 'لا يوجد محتوى',
              ),
              SizedBox(height: 10.h),
              TextUtils(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: GreyClr,
                text: notification.createdAtHuman ?? '',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
          SizedBox(height: 16.h),
          Text(
            'حدث خطأ أثناء تحميل الإشعارات',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Text(
            'تفاصيل الخطأ: $error',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}