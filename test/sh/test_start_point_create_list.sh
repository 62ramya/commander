#!/bin/bash

# Some of these tests will fail
#   o) if you do not have a network connection
#   o) if github is down

. ./cyber_dojo_helpers.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

test_START_POINT_CREATE_LIST() { :; }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

test_SUCCESS_exits_zero() { :; }

test_new_name_creates_start_point_prints_nothing()
{
  local name=jj
  local url="${github_cyber_dojo}/start-points-exercises.git-UNUSED_AT_PRESENT"
  refuteStartPointExists ${name}
  startPointCreateList ${name} ${url}
  assertTrue $?
  assertNoStdout
  assertNoStderr
  assertStartPointExists ${name}
  startPointRm ${name}
  refuteStartPointExists ${name}
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

test_FAILURE_prints_msg_to_stderr_and_exits_non_zero() { :; }

test_name_exists()
{
  local name=jj
  local url="${github_cyber_dojo}/start-points-exercises.git"
  refuteStartPointExists ${name}
  startPointCreateGit ${name} ${url}
  assertTrue $?
  assertStartPointExists ${name}

  local expected_stderr="FAILED: a start-point called ${name} already exists"
  startPointCreateList ${name} ${url}
  assertFalse $?
  assertNoStdout
  assertEqualsStderr "${expected_stderr}"
  assertStartPointExists ${name}
  startPointRm ${name}
  refuteStartPointExists ${name}
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

. ./shunit2_helpers.sh
. ./shunit2
