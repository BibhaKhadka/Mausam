plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.bibha.mausamapp"
    compileSdk = 34
    ndkVersion = "26.1.10909125" // Optional: match your Flutter installation

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.bibha.mausamapp"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
     getByName("release") {
        isMinifyEnabled = true
        // REMOVE or COMMENT this if it exists:
        // isShrinkResources = true
        signingConfig = signingConfigs.getByName("debug")
     }
    } 

}

flutter {
    source = "../.."
}
