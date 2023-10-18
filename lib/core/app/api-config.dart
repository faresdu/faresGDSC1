import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIConfig {
  static String supabaseAPIKey = dotenv.env['SUPABASE_API_KEY'] ?? "";

  static String supabaseAPIUrl = dotenv.env['SUPABASE_API_URL'] ?? "";

  static String s3BucketName = dotenv.env['S3_BUCKET_NAME'] ?? "";
  static String s3PoolID = dotenv.env['S3_POOL_ID'] ?? "";

  static String sentryUrl = dotenv.env['SENTRY_URL'] ?? "";
}
