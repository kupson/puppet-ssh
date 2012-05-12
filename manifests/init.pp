# Class: ssh
#
# This module installs ssh client and server.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#   include ssh
#
class ssh {
    include ssh::server, ssh::client
}
