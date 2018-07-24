#!/usr/bin/env bash
convert -strip -interlace Plane -gaussian-blur 0.05 -quality 85% $1 $1_output
