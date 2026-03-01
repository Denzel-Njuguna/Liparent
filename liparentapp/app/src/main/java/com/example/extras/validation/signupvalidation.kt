package com.example.extras.validation

import com.example.customtypes.signup.Signuprequest
import com.example.warrex.databinding.FragmentSignupBinding

interface Signupvalidator<Signuprequest> {
    fun signupisvalid(value: Signuprequest? = null): Boolean
}

class Signupvalidation(var binding: FragmentSignupBinding) : Signupvalidator<Signuprequest> {

    // FIX 1: Removed the '?' to match the interface and fix the 'nullable receiver' error
    override fun signupisvalid(value: Signuprequest ?): Boolean {
        return when {
            // FIX 2: Now that value is not nullable, you can call .Email directly
            value?.Email.isNullOrEmpty()-> {
                showError("Email is required", type = "email")
                false
            }
            !android.util.Patterns.EMAIL_ADDRESS.matcher(value.Email).matches() -> {
                showError("Enter a valid email address", type = "email")
                false
            }

            // Username validation
            !NameValidator.validateName(value.Username ?: "", "Username", minLength = 3).success -> {
                val result = NameValidator.validateName(value.Username ?: "", "Username", minLength = 3)
                showError(result.message, type = "username")
                false
            }

            // First name validation
            !NameValidator.validateName(value.Firstname ?: "", "First name").success -> {
                val result = NameValidator.validateName(value.Firstname ?: "", "First name")
                showError(result.message, type = "firstname")
                false
            }

            // Last name validation
            !NameValidator.validateName(value.Lastname ?: "", "Last name").success -> {
                val result = NameValidator.validateName(value.Lastname ?: "", "Last name")
                showError(result.message, type = "lastname")
                false
            }

            // Phone validation
            !isValidKenyanPhone(value.Phone ?: "") -> {
                showError("Enter a valid Kenyan phone number", type = "phone")
                false
            }

            // Password validation
            value.Password.length < 6 -> {
                showError("Password must be at least 6 characters", type = "password")
                false
            }

            else -> true
        }
    }

    private fun isValidKenyanPhone(phone: String): Boolean {
        val cleanPhone = phone.replace("\\s".toRegex(), "")
        val kenyanPhonePattern = Regex("""^(?:\+?254|0)?(7[0-9]{8}|1[0-9]{8}|[0-9]{9})$""")
        return kenyanPhonePattern.matches(cleanPhone)
    }

    private fun showError(message: String, type: String) {
        when(type) {
            "email" -> binding.etEmail.error = message
            "password" -> binding.etPassword.error = message
            "username" -> binding.etUsername.error = message
            "firstname" -> binding.etFirstname.error = message
            "lastname" -> binding.etSecondname.error = message
            "phone" -> binding.etPhone.error = message
        }
    }
}
