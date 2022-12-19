#!/bin/sh
cat backup_segment?? > backup_session_1337.tar.xz
xz -d backup_session_1337.tar.xz
echo "\033[35;m script made by wbousfir \033[0m"

