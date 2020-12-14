package com.martianlab.data.sources.db_new.converters


import com.squareup.sqldelight.ColumnAdapter
import kotlinx.datetime.DateTimeUnit
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.builtins.list
import kotlinx.serialization.builtins.serializer
import kotlinx.serialization.json.Json


internal object Converters {
    val listOfStringsAdapter = object : ColumnAdapter<List<String>, String> {
        override fun decode(value: String) : List<String> = Json.decodeFromString(ListSerializer(String.serializer()), value)
        override fun encode(list: List<String>) = Json.encodeToString(ListSerializer(String.serializer()), list)
    }

//    val dateAdapter = object  : ColumnAdapter<DateTimeUnit, Long>{
//        override fun decode(unixtime: Long): Date = Date(unixtime)
//        override fun encode(date: Date): Long = date.time
//    }


}