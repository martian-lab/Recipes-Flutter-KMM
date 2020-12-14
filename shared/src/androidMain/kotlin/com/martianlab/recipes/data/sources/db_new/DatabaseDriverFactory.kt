package com.martianlab.recipes.data.sources.db_new

import android.content.Context
import com.martianlab.recipes.shared.db.cache.AppDatabase
import com.squareup.sqldelight.android.AndroidSqliteDriver
import com.squareup.sqldelight.db.SqlDriver

actual class DatabaseDriverFactory(val context: Context) {
    actual fun createDriver(): SqlDriver {
        return AndroidSqliteDriver(AppDatabase.Schema, context, "recipes.db")
    }
}