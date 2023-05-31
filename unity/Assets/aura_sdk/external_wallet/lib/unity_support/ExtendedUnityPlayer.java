package com.DefaultCompany.AuraSDK;

import android.os.Bundle;
import com.unity3d.player.UnityPlayerActivity;
import android.net.Uri;
import android.content.Intent;
import android.util.Log;

public class ExtendedUnityPlayer extends UnityPlayerActivity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    public void OpenURL(String url)
    {   
        Uri uri = Uri.parse(url);
        Log.i("AuraSDK", "Launching URL " + url);
        Intent myIntent= new Intent(Intent.ACTION_VIEW, uri); 
        myIntent.addCategory(Intent.CATEGORY_BROWSABLE);
        myIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        myIntent.addFlags(Intent.FLAG_ACTIVITY_REQUIRE_NON_BROWSER);
        myIntent.addFlags(Intent.FLAG_ACTIVITY_REQUIRE_DEFAULT);
        startActivity(myIntent);
    }
}