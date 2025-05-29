package com.despaircorp.championdex.android.view_model

import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.despaircorp.championdex.domain.GetChampionsEntitiesUseCase
import kotlinx.coroutines.launch

class MainViewModel(
    private val getChampionsEntitiesUseCase: GetChampionsEntitiesUseCase,
) : ViewModel() {
    
    fun getTest() {
        viewModelScope.launch {
            getChampionsEntitiesUseCase.invoke().forEach {
                Log.i("Monokouma", it.toString())
            }
        }
    }
}