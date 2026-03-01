package com.example.customtypes.login

import java.io.Serializable

data class Loginrequest(
    var email: String,
    var password: String
): Serializable