# Scratch os

making this to understand how operating systems work

# DEPENDENCIES
(more will be added in future)
1. nasm
2. qemu

# HOW TO RUN
1. MAKE SURE YOU'RE IN OsFromScratch DIRECTORY
2. make && qemu-system-i386 -fda build/main_floppy.img (linux/mac)

# RECENT CHANGES
1. Added bootloader/boot.asm to src
2. Added kernel/main.asm to src
3. Changed Makefile to clean and remake build/
4. Makefile now adds bootloader.bin & kernel.bin to build/
5. Added test.img (MAYBE removed in future updates?)
