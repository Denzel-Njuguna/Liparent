package com.example.warrex

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.customtypes.home.Transactions
import com.example.customtypes.home.Screenbalance
import com.example.warrex.databinding.FragmentHomeBinding

class HomeFragment : Fragment() {

    private var screenbalance: Screenbalance?=null
    private var _binding: FragmentHomeBinding?=null
    private var activities: Transactions?=null
    private val binding get()= _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
//        TODO: check what this does
       _binding = FragmentHomeBinding.inflate(inflater,container,false)
        return binding.root
    }
//    this is where i get the data to populate the recent activity view list
private fun getdata(){
    viewlife
//    this is where i setup the event click listeners

    private func set
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            HomeFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                    putString(ARG_PARAM2, param2)
                }
            }
    }
}