# Copyright (C) 2010  Benoit Sigoure
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

CC = gcc
CPPFLAGS = -O2 -pthread

# the build target executable:
TARGETS = ATMProblemShow ATMProblemShow-mutex \
BoundedBuffer-mutex BoundedBuffer-semaphore BoundedBuffer-monitor BoundedBuffer-monitor-mesatest \
Deadlock PreAssignJob DynamicAssignJob HomoThreads HeteroThreads \
ConcurrentWget-ThreadPool ConcurrentWget-OnDemand \
ConcurrentQuickSort-Recursive-broken ConcurrentQuickSort-Recursive ConcurrentQuickSort-Iteration \
Problems-CompilerOptimization Problems-CPUOoO

all: $(TARGETS)

clean:
	$(RM) $(TARGETS)

