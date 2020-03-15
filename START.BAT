echo off

tasm /la code.asm
tlink /t code.obj
code.com

echo on