package com.example.customtypes.login

import com.example.customtypes.User

data class Loginresponse(
    val token : String?,
    val success : Boolean,
    val userid: String,
    val message: String?,
    val user : User? = null
)