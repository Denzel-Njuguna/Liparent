package com.example.customtypes.signup

data class Signupresponse (
    val success: Boolean,
    val email: String?,
    val message: String?,
    val token:String?,
    val userid: String?
)