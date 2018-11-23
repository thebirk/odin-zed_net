@echo off
cl -nologo -DZED_NET_IMPLEMENTATION -MT -TC -O2 -c zed_net.h
lib -nologo zed_net.obj
del zed_net.obj
