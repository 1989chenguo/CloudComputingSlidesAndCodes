// Copyright (C) 2010  Benoit Sigoure
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>

static inline long long unsigned time_ns(struct timespec* const ts) {
  if (clock_gettime(CLOCK_REALTIME, ts)) {
    exit(1);
  }
  return ((long long unsigned) ts->tv_sec) * 1000000000LLU
    + (long long unsigned) ts->tv_nsec;
}

int main(void) {
  const int iterations = 500000;
  struct timespec ts;
  const pid_t other = fork();
  if (other == 0) {
    for (int i = 0; i < iterations; i++)
      sched_yield();
    return 0;
  }

  const long long unsigned start_ns = time_ns(&ts);
  for (int i = 0; i < iterations; i++)
      sched_yield();
  const long long unsigned delta = time_ns(&ts) - start_ns;

  const int nswitches = iterations << 2;
  printf("%i process context switches in %lluns (%.1fns/ctxsw) [Use sched_yield()]\n",
         nswitches, delta, (delta / (float) nswitches));
  return 0;
}
