package com.example.warrex

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.example.customtypes.signup.Signuprequest
import com.example.customtypes.signup.Signupresponse
import com.example.extras.api.Apiclient
import com.example.extras.validation.Signupvalidation
import com.example.warrex.databinding.FragmentSignupBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class SignupFragment : Fragment() {
    private  var holder: Signuprequest ?=null
    private var _binding: FragmentSignupBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = FragmentSignupBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupClickListeners()
    }

    private fun setupClickListeners() {
        binding.btnSignup.setOnClickListener {
            val request  = Signuprequest(
                Email = binding.etEmail.text.toString().trim(),
                Password = binding.etEmail.text.toString().trim(),
                Phone = binding.etPhone.text.toString().trim(),
                Username = binding.etUsername.text.toString().trim(),
                Firstname = binding.etFirstname.text.toString().trim(),
                Lastname = binding.etSecondname.text.toString().trim()
            )
            holder = request
            attemptsignup(request)
        }
    }
    private fun attemptsignup(data : Signuprequest){
        val response  = Signupvalidation(binding).signupisvalid(holder)
        if(response){
            performsignup(holder)
        }
    }
//    TODO:check the validation process that it does not correct on its own the user must correct their data
    private fun performsignup(data: Signuprequest?){
        showLoading(true)
    viewLifecycleOwner.lifecycleScope.launch {
        try {
            val response = Apiclient.apiservice.signup(data)
            withContext(Dispatchers.Main){
                showLoading(false)
                if(response.isSuccessful){
                    response.body()?.let{
                        signupresponse ->
                        if(signupresponse.success){
                            Signupsuccess(signupresponse)
                        }else{
                            showError(signupresponse.message?: "signup response")
                        }
                    }
                }
            }
        }catch (e: Exception){
            withContext(Dispatchers.Main){
                showLoading(false)
                showError("Network Error: ${e.message}")
            }
        }
    }
    }
    private fun Signupsuccess(response: Signupresponse){
        saveusersession(response)
        Toast.makeText(requireContext(), "SIgnup successful", Toast.LENGTH_SHORT).show()
        findNavController().navigate(R.id.action_signup_to_homepage)
    }
    private fun saveusersession(data : Signupresponse){
        val sharedpref = requireActivity().getSharedPreferences("app_prefs", Context.MODE_PRIVATE)
        sharedpref.edit().apply{
            putBoolean("is_logged", true)
            putString("user_id", data.userid)
            putString("useremail", holder?.Email)
            putString("authtoken", data.token)
            apply()
        }
    }
    private fun showLoading(isLoading: Boolean) {
        binding.btnSignup.isEnabled = !isLoading
        binding.progressBar.visibility = if (isLoading) View.VISIBLE else View.GONE
        binding.tvError.visibility = View.GONE
    }
    private fun showError(message: String) {
        binding.tvError.text = message
        binding.tvError.visibility = View.VISIBLE
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}