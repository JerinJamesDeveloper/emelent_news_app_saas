/// API Endpoints
/// 
/// Centralized location for all API endpoint paths.
/// Organized by feature/module for easy maintenance.
library;

import 'app_constants.dart';

class ApiEndpoints {
  // Prevent instantiation
  ApiEndpoints._();

static const String baseurl = AppConstants.baseUrl;
  // ============== AUTH ENDPOINTS ==============
  static const String _authBase = '$baseurl/auth';
  
  static const String login = '$_authBase/login';
  static const String register = '$_authBase/signup';
  static const String logout = '$_authBase/logout';
  static const String refreshToken = '$_authBase/refresh-token';
  static const String forgotPassword = '$_authBase/forgot-password';
  static const String resetPassword = '$_authBase/reset-password';
  static const String verifyEmail = '$_authBase/verify-email';
  static const String resendVerification = '$_authBase/resend-verification';
  static const String changePassword = '$_authBase/change-password';
  
  // ============== USER ENDPOINTS ==============
  static const String _userBase = '$baseurl/users';
  
  static const String currentUser = '$_userBase/me';
  static const String updateProfile = '$_userBase/me';
  static const String uploadAvatar = '$_userBase/me/avatar';
  static const String deleteAccount = '$_userBase/me';
  
  /// Get user by ID
  static String userById(String id) => '$_userBase/$id';
  
  // ============== ADMIN ENDPOINTS ==============
  static const String _adminBase = '$baseurl/admin';
  
  static const String adminUsers = '$_adminBase/users';
  static const String adminDashboard = '$_adminBase/dashboard';
  static const String adminStats = '$_adminBase/stats';
  
  /// Admin get user by ID
  static String adminUserById(String id) => '$_adminBase/users/$id';
  
  /// Admin update user role
  static String adminUpdateUserRole(String id) => '$_adminBase/users/$id/role';
  
  // ============== PROFILE ENDPOINTS ==============
  static const String _profileBase = '$baseurl/profile';
  
  static const String getProfile = _profileBase;
  static const String updateProfileDetails = _profileBase;
  
  // ============== COMMON ==============
  static const String health = '/health';
  static const String version = '/version';
}