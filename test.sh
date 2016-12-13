#!/bin/sh
./bin/slice add slice_a
./bin/slice add_host --mac 11:11:11:11:11:11 --port 0x1:1 --slice slice_a
./bin/slice add_host --mac 22:22:22:22:22:22 --port 0x4:1 --slice slice_a
./bin/slice add_host --mac 33:33:33:33:33:33 --port 0x5:1 --slice slice_a
./bin/slice add_host --mac 44:44:44:44:44:44 --port 0x6:1 --slice slice_a
./bin/trema send_packets --source host1 --dest host2
./bin/trema send_packets --source host2 --dest host3
./bin/trema send_packets --source host3 --dest host4
./bin/trema send_packets --source host4 --dest host1
./bin/trema show_stats host1
./bin/trema show_stats host2
./bin/trema show_stats host3
./bin/trema show_stats host4
./bin/slice split slice_a --into slice_b:11:11:11:11:11:11,33:33:33:33:33:33 slice_c:22:22:22:22:22:22,44:44:44:44:44:44
./bin/slice list
./bin/trema send_packets --source host1 --dest host2
./bin/trema send_packets --source host1 --dest host3
./bin/trema show_stats host1
./bin/trema show_stats host2
./bin/trema show_stats host3
./bin/slice join slice_b slice_c --into slice_a
./bin/slice list
./bin/trema send_packets --source host1 --dest host2
./bin/trema send_packets --source host1 --dest host3
./bin/trema show_stats host1
./bin/trema show_stats host2
./bin/trema show_stats host3
