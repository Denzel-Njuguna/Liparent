package com.example.extras.utils

import android.content.Context
import android.content.res.Configuration
import android.util.TypedValue
//look for explanation for what this does
object Themeutils {
    fun isDarkMode(context: Context): Boolean{
        return (context.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_YES

    }
    fun getThemedcolor(context: Context, attribute: Int): Int{
        val typedvalue = TypedValue()
        context.theme.resolveAttribute(attribute,typedvalue,true)
        return typedvalue.data
    }
}