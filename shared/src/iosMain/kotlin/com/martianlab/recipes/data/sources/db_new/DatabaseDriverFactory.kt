package com.martianlab.recipes.data.sources.db_new


import com.martianlab.recipes.shared.db.cache.AppDatabase
import com.squareup.sqldelight.db.SqlDriver

actual class DatabaseDriverFactory {
    actual fun createDriver(): SqlDriver {
        return NativeSqliteDriver(AppDatabase.Schema, "recipes.db")
    }
}