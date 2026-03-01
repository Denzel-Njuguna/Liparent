package com.example.viewmodels

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.customtypes.home.Transactions

class Homeviewmodel: ViewModel() {
//    this is the writable one that receives data from the backend
    private val _transactions  = MutableLiveData<List<Transactions>>()
    val transactions : LiveData<List<Transactions>> = _transactions

    init {
        loadtransactions()
    }

    private fun loadtransactions(){
//        here we fetch teh user data from the backend
        var list = listOf()
    }
}