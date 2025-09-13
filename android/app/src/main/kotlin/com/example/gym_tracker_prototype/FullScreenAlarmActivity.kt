package com.example.gym_tracker_prototype

import android.app.Activity
import android.os.Bundle
import android.widget.Button

class FullScreenAlarmActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_fullscreen_alarm)

        val stopButton: Button = findViewById(R.id.stopButton)
        stopButton.setOnClickListener {
            // Aquí detienes la alarma sonora si tienes un MediaPlayer o similar
            finish() // Cierra la Activity
        }
    }
}
