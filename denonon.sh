#!/bin/bash
echo -ne PWRON\\r| nc -w1 192.168.0.3 23
