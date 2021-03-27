#!/usr/bin/env python3

import sys
import os

region = sys.argv[1]

if __name__ == '__main__':
    for path in sys.argv[2:]:
        bucket = os.path.dirname(path).removeprefix("s3://")
        obj = os.path.basename(path)
        print(f'https://{bucket}.s3-{region}.amazonaws.com/{obj}')
