package com.example.aura_launcher


import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager


public final class AuraLauncherSender {
    private var activity: Activity? = null
    private var context: Context? = null

    constructor(activity: Activity?, context: Context?) {
        this.activity = activity
        this.context = context
    }


    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    fun setApplicationContext(applicationContext: Context?) {
        this.context = applicationContext
    }

    fun launch(intent: Intent): Boolean {
        println("Application context is null :${context == null}")

        println("Activity is null :${activity == null}")

        if (context == null) {
            return false;
        }

        val canLaunch = this.canLaunch(intent);

        if (!canLaunch) {
            return false;
        }

        if (activity != null) {
            println("Activity is not null")
            intent.addCategory(Intent.CATEGORY_BROWSABLE)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intent.addFlags(Intent.FLAG_ACTIVITY_REQUIRE_NON_BROWSER)
            intent.addFlags(Intent.FLAG_ACTIVITY_REQUIRE_DEFAULT)
            activity!!.startActivity(intent)
        } else {
            println("Context is not null")
            intent.addCategory(Intent.CATEGORY_BROWSABLE)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intent.addFlags(Intent.FLAG_ACTIVITY_REQUIRE_NON_BROWSER)
            intent.addFlags(Intent.FLAG_ACTIVITY_REQUIRE_DEFAULT)
            context!!.startActivity(intent)
        }

        return true
    }

    fun canLaunch(intent: Intent): Boolean {
        if (context == null) {
            return false
        }

        val packageManager: PackageManager = context!!.packageManager

        return packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY) != null
    }

}