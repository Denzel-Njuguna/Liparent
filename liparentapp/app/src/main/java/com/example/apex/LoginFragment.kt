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
import com.example.customtypes.login.Loginrequest
import com.example.customtypes.login.Loginresponse
import com.example.extras.api.Apiclient
import com.example.extras.validation.Loginvalidation
import com.example.warrex.databinding.FragmentLoginBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class LoginFragment : Fragment() {
    private  var holder: Loginrequest?= null
    private var _binding : FragmentLoginBinding ?= null
    private val binding get() = _binding!!
// this is to create the layer before the ui
    override fun onCreateView(
        inflater: LayoutInflater,container: ViewGroup?, savedINstance: Bundle?
    ): View {
        _binding = FragmentLoginBinding.inflate(inflater,container,false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

//      Note if you decide to do sth about themes this is where to do it
        setupClickListeners()
    }
    // this is to collect data from the fields
    private fun setupClickListeners(){
        binding.btnLogin.setOnClickListener{
            val request = Loginrequest(
                email = binding.etEmail.text.toString().trim(),
                password =binding.etPassword.text.toString().trim()
            )
            holder = request
            attemptLogin(request)
        }
    }
    private fun attemptLogin(holder:Loginrequest){
        val validator = Loginvalidation(binding).Loginisvalid(holder)
        if (validator){
            perfomLoginrequest(holder)
        }
    }

    private fun perfomLoginrequest(data : Loginrequest) {
        showLoading(isLoading = true)
        viewLifecycleOwner.lifecycleScope.launch {
            try {
                val response = Apiclient.apiservice.login(data)
                withContext(Dispatchers.Main){
                    showLoading(false)
                    if(response.isSuccessful){
                        response.body()?.let{
                            loginresponse ->
                            if(loginresponse.success){
                                loginsuccess(loginresponse)
                            }else{
                                showError(loginresponse.message?: "Login failed")
                            }
                        }
                    }else{
                        showError("server error: ${response.code()}")
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
//    this is to handle saving of user data like the session token after a successful login
private fun loginsuccess(response : Loginresponse){
    saveUserSession(response)
    Toast.makeText(requireContext(), "Login successful", Toast.LENGTH_SHORT).show()
    findNavController().navigate(R.id.action_login_to_homepage)
}
    private fun saveUserSession(response: Loginresponse){
        val sharedPref = requireActivity().getSharedPreferences("app_prefs",Context.MODE_PRIVATE)
        sharedPref.edit().apply {
            putBoolean("is_logged", true)
            putString("user_id", response.userid)
            putString("useremail", response.user?.email)
            putString("authtoken", response.token)
            apply()
        }

    }
//    this is to show the loading icon as we send the request to the server
    private fun showLoading(isLoading: Boolean) {
        binding.btnLogin.isEnabled = !isLoading
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