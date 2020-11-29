#include <jni.h>
#include "com_hank_jni_HelloWorld.h"
#include <stdio.h>
JNIEXPORT void JNICALL Java_com_hank_jni_HelloWorld_DisplayHello
(JNIEnv *env, jobject obj)
{
    printf("From jni_helloworldImpl.cpp :");
    printf("Hello world ! \n");
    return;
}