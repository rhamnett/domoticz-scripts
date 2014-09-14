#!/bin/bash
echo -ne PWSTANDBY\\r| nc -w1 192.168.0.3 23
