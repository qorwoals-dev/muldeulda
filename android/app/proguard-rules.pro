# google_mlkit_face_detection uses reflection / Dynamite module loading
# internally; without these keep rules R8 renames classes it looks up by
# name and face detection throws a NullPointerException in release builds.
-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.internal.mlkit_vision_face_bundled.** { *; }
-keep class com.google.android.gms.internal.mlkit_vision_common_bundled.** { *; }
-keep class com.google.android.gms.dynamite.** { *; }
-dontwarn com.google.mlkit.**
-dontwarn com.google.android.gms.**
