/*
 * Copyright (C) 2026 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include "vendor_init.h"

#include <libinit_mainline_common.h>
#include <libinit_misc.h>
#include <libinit_utils.h>

void vendor_process_bootenv() {
    vendor_process_bootenv_mainline_common();
    enable_insecure_debugging();
    property_override("ro.boot.mode", "");
}

void vendor_load_properties() {
    vendor_load_properties_mainline_common();
}
