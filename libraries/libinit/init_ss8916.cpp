/*
 * Copyright (C) 2026 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include "vendor_init.h"

#include <sys/sysinfo.h>

#include <libinit_mainline_common.h>
#include <libinit_misc.h>
#include <libinit_utils.h>

#define MB(b) (b * 1024ull * 1024)

void vendor_process_bootenv() {
    vendor_process_bootenv_mainline_common();
    enable_insecure_debugging();
    property_override("ro.boot.mode", "");
}

static void set_zram_default() {
    struct sysinfo sys;
    sysinfo(&sys);

    // ZRAM pays off on the 1 GB and 1.5 GB variants
    // The CPU is too weak for it on bigger ones
    if ((unsigned long long)sys.totalram * sys.mem_unit <= MB(1536)) {
        property_override("persist.sys.zram_enabled", "1");
    }
}

void vendor_load_properties() {
    vendor_load_properties_mainline_common();
    set_zram_default();
}
