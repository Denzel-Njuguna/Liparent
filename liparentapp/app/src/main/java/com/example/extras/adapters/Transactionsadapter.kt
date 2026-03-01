package com.example.extras.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.RecyclerView
import com.example.customtypes.home.Transactions
import com.example.warrex.R
import com.example.warrex.databinding.ItemTransactionBinding

class Transactionsadapter (private val transactions: List<Transactions>):
        RecyclerView.Adapter<Transactionsadapter.TransactionViewHolder>(){
    class TransactionViewHolder(val binding: ItemTransactionBinding): RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TransactionViewHolder {
       val binding = ItemTransactionBinding.inflate(LayoutInflater.from(parent.context),parent,false)
        return TransactionViewHolder(binding)
    }

    override fun onBindViewHolder(holder: TransactionViewHolder, position: Int) {
        val item = transactions[position]
        val context = holder.binding.root.context
        holder.binding.apply {
            tvTransactionTitle.text = item.title
            tvTransactionDate.text = item.time
            tvTransactionAmount.text = item.amount
            val colorresid  = if(item.transactiontype)R.color.debit else R.color.credit
            val color = ContextCompat.getColor(context,colorresid)
            tvTransactionAmount.setTextColor(color)
        }
    }

    override fun getItemCount() = transactions.size
  }