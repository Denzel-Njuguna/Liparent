package com.example.extras.api

import com.example.customtypes.login.Loginrequest
import com.example.customtypes.login.Loginresponse
import com.example.customtypes.signup.Signuprequest
import com.example.customtypes.signup.Signupresponse
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.POST

interface Apiservice{
    @POST("/login")
    suspend fun login(@Body request: Loginrequest): Response<Loginresponse>
    @POST("createuser")
    suspend fun signup(@Body request: Signuprequest?): Response<Signupresponse>
}