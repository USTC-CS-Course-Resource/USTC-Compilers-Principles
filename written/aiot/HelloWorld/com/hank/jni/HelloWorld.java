package com.hank.jni;

public class HelloWorld {
    static {
        System.loadLibrary("Hello");
    }

    public native void DisplayHello();
    
    public static void main(String[] args) {
        new HelloWorld().DisplayHello();
    }
}