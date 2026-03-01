package com.example.customtypes.signup

import java.io.Serializable

data class Signuprequest(
    var Email : String,
    var Password: String,
    var Phone: String,
    var Username: String,
    var Firstname: String,
    var Lastname: String
): Serializable
