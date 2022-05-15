clc;
clear all;
close all;
code = train('D:\train', 37);
test('D:\test',37, code);
