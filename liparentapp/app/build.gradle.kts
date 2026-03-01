plugins {
    alias(libs.plugins.android.application)
    id("com.google.gms.google-services")
}
val baseurl: String = project.findProperty("BASE_URL") as? String ?: "http://10.0.2.2:4000"

android {
    namespace = "com.example.apex"
    compileSdk {
        version = release(36) {
            minorApiLevel = 1
        }
    }
    buildFeatures {
        viewBinding = true
        buildConfig = true
    }
    defaultConfig {
        applicationId = "com.example.apex"
        minSdk = 26
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"

    buildConfigField("String", "Base_url", "\"$baseurl\"")
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }


}

dependencies {
    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.appcompat)
    implementation(libs.material)
    implementation(libs.androidx.constraintlayout)
    implementation(libs.androidx.navigation.fragment.ktx)
    implementation(libs.androidx.navigation.ui.ktx)
    implementation (libs.retrofit)
    implementation(libs.converter.gson)
    implementation(libs.google.material)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)
    // OkHttp (optional but recommended for logging)
    implementation(libs.okhttp)
    implementation(libs.logging.interceptor)
// Coroutines (if you want to use suspend functions)
    implementation(libs.kotlinx.coroutines.android)
    // Import the Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.9.0"))
    // TODO: Add the dependencies for Firebase products you want to use
    // When using the BoM, don't specify versions in Firebase dependencies
    implementation("com.google.firebase:firebase-analytics")
//    this is the dependency for firebase notifications
    implementation("com.google.firebase:firebase-messaging")

}