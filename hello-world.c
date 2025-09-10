// hello-world.c
#include <linux/module.h>
#include <linux/kernel.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Harel Erlich");
MODULE_DESCRIPTION("A simple Hello World kernel module.");

static int __init hello_init(void) {
    printk(KERN_INFO "Hello, World! from the kernel module v3.\n");
    return 0;
}

static void __exit hello_exit(void) {
    printk(KERN_INFO "Goodbye, World! from the kernel module.\n");
}

module_init(hello_init);
module_exit(hello_exit);