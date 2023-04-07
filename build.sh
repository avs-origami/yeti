#!/bin/bash
cd build_env

bash -e host_syscheck.sh
bash prepare_env.sh
bash create_env.sh