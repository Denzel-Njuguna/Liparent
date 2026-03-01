package com.example.warrex

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.example.warrex.databinding.FragmentLandingBinding

class LandingFragment : Fragment() {
    private var _binding: FragmentLandingBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentLandingBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // 1. Check login state first
        checkLoginState()

        // 2. Setup button listeners with safe navigation
        binding.btnGetStarted.setOnClickListener {
            safeNavigate(R.id.action_landing_to_signup)
        }

        binding.btnLogin.setOnClickListener {
            safeNavigate(R.id.action_landing_to_login)
        }
    }

    private fun checkLoginState() {
        val sharedPref = requireActivity().getSharedPreferences("app_prefs", Context.MODE_PRIVATE)
        val isLoggedIn = sharedPref.getBoolean("is_logged", false)

        if (isLoggedIn) {
            safeNavigate(R.id.action_landing_to_home)
        }
    }

    private fun safeNavigate(actionId: Int) {
        val navController = findNavController()
        // Ensure we are currently on the LandingFragment before performing an action from it
        if (navController.currentDestination?.id == R.id.landingFragment) {
            navController.navigate(actionId)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null // Clear binding to prevent memory leaks
    }
}
