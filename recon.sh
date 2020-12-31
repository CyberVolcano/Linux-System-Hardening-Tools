#!/bin/bash

dpkg -l | grep -E '(crack|hack)'

dpkg -l | grep -E '(exploitation|injection)'


dpkg -l | grep -E '(torrent)'

dpkg -l rdp

dpkg -l | grep -E '(remote.+access)'

service --status-all | grep '[+]'

locate *reverse*shell*.*

locate *backdoor*shell*.*
