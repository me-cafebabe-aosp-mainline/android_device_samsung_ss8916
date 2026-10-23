# AGENTS.md - device/qualcomm/ss8916

Agents must read this file before touching anything in this repository.

Part of the mainline repository set. Map of all repos: `vendor/mainline/docs/REPOSITORIES.md`.

Device tree for Samsung MSM8916 devices running a mainline kernel,
booted through lk2nd.

## Read first

| Task | Read |
|------|------|
| Anything about bringup, kernel, boot, init, SELinux | `device/mainline/common/docs/README.md` |
| Anything Qualcomm | `device/mainline/qcom-common/docs/README.md` |
| Commits, style, review | `hardware/mainline/common/docs/` |
| Bootloader and install steps | `README.md` |

## Hard rules

- No Android build, flashing or test without asking the human first
  (`hardware/mainline/common/docs/WORKFLOW.md`).
- Do not search from the AOSP tree root; use precise directories.
- Keep device specific values here. Things that apply to more devices
  belong in the common trees (ask first).
- Do not add firmware or proprietary files.
