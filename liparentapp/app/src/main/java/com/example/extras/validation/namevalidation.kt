package com.example.extras.validation

import java.util.regex.Pattern

//TODO: remember to do this in the backend too
class NameValidator {

    companion object {

        // Maximum length allowed
        private const val MAX_NAME_LENGTH = 30

        // Allowed characters: letters (including accents), spaces, hyphens, apostrophes
        private val ALLOWED_NAME_PATTERN = Pattern.compile(
            "^[a-zA-ZÀ-ÿ\\s'-]+$"
        )

        // SQL injection patterns
        private val SQL_INJECTION_PATTERNS = listOf(
            "(?i)(\\bSELECT\\b.*\\bFROM\\b)",
            "(?i)(\\bINSERT\\b.*\\bINTO\\b)",
            "(?i)(\\bUPDATE\\b.*\\bSET\\b)",
            "(?i)(\\bDELETE\\b.*\\bFROM\\b)",
            "(?i)(\\bDROP\\b.*\\bTABLE\\b)",
            "(?i)(\\bUNION\\b.*\\bSELECT\\b)",
            "(?i)(\\bALTER\\b.*\\bTABLE\\b)",
            "(?i)(\\bCREATE\\b.*\\bTABLE\\b)",
            "(?i)(\\bTRUNCATE\\b)",
            "(?i)(\\bEXEC\\b)",
            "(?i)(\\bEXECUTE\\b)",
            "--",
            ";",
            "\\*\\/",
            "\\/\\*",
            "'\\s*OR\\s*'\\d+'\\s*=\\s*'\\d+'",
            "'\\s*OR\\s*\\d+\\s*=\\s*\\d+"
        ).map { Pattern.compile(it) }

        // XSS patterns
        private val XSS_PATTERNS = listOf(
            "<script[^>]*>.*?</script>",
            "javascript:",
            "onclick=",
            "onerror=",
            "onload=",
            "onmouseover=",
            "onfocus=",
            "onblur=",
            "onchange=",
            "onselect=",
            "onsubmit=",
            "onreset=",
            "onkeydown=",
            "onkeypress=",
            "onkeyup=",
            "alert\\(",
            "confirm\\(",
            "prompt\\(",
            "eval\\(",
            "document\\.",
            "window\\.",
            "location\\.",
            "innerHTML",
            "outerHTML",
            "&lt;",
            "&gt;",
            "&#",
            "<[^>]*>",
            "\\{\\{.*\\}\\}",  // Template injection
            "\\$\\{.*\\}"      // Template injection
        ).map { Pattern.compile(it, Pattern.CASE_INSENSITIVE) }

        // Profanity/sensitive words (add more as needed)
        private val BLOCKED_WORDS = listOf(
            "admin", "root", "superuser", "moderator", "staff",
            "test", "user", "anonymous", "null", "undefined"
        )

        /**
         * Validates a single name field
         * @return ValidationResult with success status and error message
         */
        fun validateName(
            name: String,
            fieldName: String,
            allowEmpty: Boolean = false,
            minLength: Int = 2
        ): ValidationResult {

            // Check if empty
            if (name.trim().isEmpty()) {
                return if (allowEmpty) {
                    ValidationResult(true)
                } else {
                    ValidationResult(false, "$fieldName is required")
                }
            }

            val trimmedName = name.trim()

            // Check length
            if (trimmedName.length > MAX_NAME_LENGTH) {
                return ValidationResult(
                    false,
                    "$fieldName cannot exceed $MAX_NAME_LENGTH characters"
                )
            }

            // Check minimum length
            if (trimmedName.length < minLength) {
                return ValidationResult(
                    false,
                    "$fieldName must be at least $minLength characters"
                )
            }

            // Check for allowed characters
            if (!ALLOWED_NAME_PATTERN.matcher(trimmedName).matches()) {
                return ValidationResult(
                    false,
                    "$fieldName can only contain letters, spaces, hyphens, and apostrophes"
                )
            }

            // Check for SQL injection
            SQL_INJECTION_PATTERNS.forEach { pattern ->
                if (pattern.matcher(trimmedName).find()) {
                    return ValidationResult(
                        false,
                        "$fieldName contains invalid characters or patterns"
                    )
                }
            }

            // Check for XSS
            XSS_PATTERNS.forEach { pattern ->
                if (pattern.matcher(trimmedName).find()) {
                    return ValidationResult(
                        false,
                        "$fieldName contains invalid characters or patterns"
                    )
                }
            }

            // Check for blocked words
            BLOCKED_WORDS.forEach { blockedWord ->
                if (trimmedName.contains(blockedWord, ignoreCase = true)) {
                    return ValidationResult(
                        false,
                        "$fieldName contains invalid words"
                    )
                }
            }

            // Check for repeated characters (e.g., "aaaaaa")
            if (hasRepeatedCharacters(trimmedName)) {
                return ValidationResult(
                    false,
                    "$fieldName contains too many repeated characters"
                )
            }

            return ValidationResult(true)
        }

        /**
         * Validates all three names together
         */
        fun validateAllNames(
            username: String,
            firstname: String,
            lastname: String
        ): Map<String, ValidationResult> {
            return mapOf(
                "username" to validateName(username, "Username", minLength = 3),
                "firstname" to validateName(firstname, "First name"),
                "lastname" to validateName(lastname, "Last name")
            )
        }

        /**
         * Quick validation that returns boolean
         */
        fun isValidName(name: String): Boolean {
            return validateName(name, "").success
        }

        /**
         * Sanitize a name by removing dangerous characters
         */
        fun sanitizeName(name: String): String {
            return name
                .trim()
                .replace(Regex("[<>\"'%;()&+]"), "")  // Remove common dangerous chars
                .replace(Regex("\\s+"), " ")          // Normalize spaces
                .take(MAX_NAME_LENGTH)                 // Truncate if too long
        }

        // Helper function to check for too many repeated characters
        private fun hasRepeatedCharacters(input: String): Boolean {
            var count = 1
            for (i in 1 until input.length) {
                if (input[i] == input[i - 1]) {
                    count++
                    if (count > 3) return true  // More than 3 repeats
                } else {
                    count = 1
                }
            }
            return false
        }
    }
}

data class ValidationResult(
    val success: Boolean,
    val message: String = ""
)
