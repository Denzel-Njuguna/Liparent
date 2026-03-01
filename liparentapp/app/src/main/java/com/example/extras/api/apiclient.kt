package com.example.extras.api

import com.example.extras.api.Apiservice
import com.example.warrex.BuildConfig
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

object Apiclient{
    private const val Baseurl = BuildConfig.Base_url

    private val loggingInterceptor = HttpLoggingInterceptor().apply {
        level = HttpLoggingInterceptor.Level.BODY
    }

    private val httpclient  = okhttp3.OkHttpClient.Builder()
        .addInterceptor ( loggingInterceptor )
        .connectTimeout(30,TimeUnit.SECONDS)
        .readTimeout(30,TimeUnit.SECONDS)
        .writeTimeout(30, TimeUnit.SECONDS)
        .build()
    private val retrofit by lazy{
        Retrofit.Builder()
            .baseUrl(Baseurl)
            .client(httpclient)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }
    val apiservice: Apiservice by lazy{
        retrofit.create(Apiservice::class.java)
    }
}