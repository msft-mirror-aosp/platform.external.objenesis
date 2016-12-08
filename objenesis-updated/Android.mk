# Copyright (C) 2013 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

LOCAL_PATH := $(call my-dir)

#-------------------------------
# build a target jar

include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(call all-java-files-under, main/src)
# This is an updated version of objenesis to be kept in sync with
# external/mockito/mockito-updated, updates to objenesis-updated
# may be required anytime mockito is updated.
LOCAL_MODULE := objenesis-updated-target
#  SDK 10 needed for ObjectStreamClass lookupAny
LOCAL_SDK_VERSION := 10
LOCAL_MODULE_TAGS := optional
include $(BUILD_STATIC_JAVA_LIBRARY)

#--------------------------------
# Builds the Objenesis TCK as a device-targeted library

include $(CLEAR_VARS)
LOCAL_MODULE := objenesis-updated-tck-target
LOCAL_MODULE_TAGS := tests

LOCAL_STATIC_JAVA_LIBRARIES := objenesis-updated-target
LOCAL_SRC_FILES := $(call all-java-files-under, tck/src)
LOCAL_JAVA_RESOURCE_DIRS := tck/resources
include $(BUILD_STATIC_JAVA_LIBRARY)

# -------------------------------
# Builds the deployable Objenesis TCK for Android
# To build and run:
#    make APP-ObjenesisTck
#    adb install -r out/target/product/generic/data/app/ObjenesisTck.apk
#    adb shell am instrument -w org.objenesis.tck.android/.TckInstrumentation

LOCAL_PATH := $(LOCAL_PATH)/tck-android
include $(CLEAR_VARS)
LOCAL_PACKAGE_NAME := ObjenesisUpdatedTck
LOCAL_MODULE_TAGS := tests
LOCAL_CERTIFICATE := platform

LOCAL_STATIC_JAVA_LIBRARIES := objenesis-updated-tck-target
LOCAL_SRC_FILES := $(call all-java-files-under, src)
include $(BUILD_PACKAGE)
