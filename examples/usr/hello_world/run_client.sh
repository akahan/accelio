#!/bin/bash

export LD_LIBRARY_PATH=../../../src/usr/

# Configuring Running Directory
TOP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Arguments Check
if [ $# -lt 2 ]; then
        echo "[$0] Missing Parameters!"
        echo "Usage: $0 [Server IP] [Port] [Transport (optional)] [Transport (optional)] [0 for infinite run and 1 for finite. Optional, default is 0]"
        exit 1
fi

server_ip=$1
port=$2
trans="rdma"
if [ $# -eq 3 ]; then
	trans=$3
fi

if [ -z "$4" ]
then
	#running indefinitely
	finite_run="0"
else
	finite_run=$4
fi

taskset -c 1 $TOP_DIR/xio_client ${server_ip} ${port} ${trans} ${finite_run}

