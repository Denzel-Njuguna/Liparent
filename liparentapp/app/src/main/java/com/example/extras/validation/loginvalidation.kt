package com.example.extras.validation

import android.util.Patterns
import com.example.customtypes.login.Loginrequest
import com.example.warrex.databinding.FragmentLoginBinding

interface Validator<T> {
    fun Loginisvalid(value: T): Boolean
}

data class Loginvalidation(var binding: FragmentLoginBinding) : Validator<Loginrequest> {
    override fun Loginisvalid(value: Loginrequest): Boolean {
        // This handles the showing of the message if there is an error
        return when {
            value.email.isEmpty() -> {
                showError("email is required", type = "email")
                false
            }
            !Patterns.EMAIL_ADDRESS.matcher(value.email).matches() -> {
                showError("enter a valid email address", type = "email")
                false
            }
            value.password.length < 6 -> {
                showError("password must be at least 6 characters", type = "password")
                false
            }
            else -> true
        }
    }

    fun showError(message: String, type: String) {
        when (type) {
            "email" -> binding.etEmail.error = message
            "password" -> binding.etPassword.error = message
        }
    }
}
