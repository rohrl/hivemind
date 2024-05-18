#!/usr/bin/env python3.8

import torch

print("Torch version:")
print(torch.__version__)

print("CUDA available:")
print(torch.cuda.is_available())

print("Test CUDA:")
print(torch.rand(2, 3).cuda())