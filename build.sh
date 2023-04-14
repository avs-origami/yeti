#!/bin/bash
cd build_env

bash -e host_syscheck.sh

read -n 1 -s -r -p "Verify that there were no erors above, then press any key to continue"
echo && echo

bash prepare_env.sh
bash create_env.sh

echo "Build complete! Enjoy your new Yeti OS system"