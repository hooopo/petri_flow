## LoLA

LoLA is a Petri nets model-checking tool. To install LoLA, download lola-2.0.tar.gz from http://home.gna.org/service-tech/lola/index.html and extract it. You will need a working C++ compiler such as GCC or Clang. On Linux and OS X, LoLA can be compiled with ./configure and make. On Windows, you might need a Unix-like environment via Cygwin.

LoLA can answer reachability queries using the flag '-f' followed by 'REACHABLE' and a formula, e.g.:

  lola petrinet.lola -f "REACHABLE DEADLOCK"             # Tests whether a dead marking can be reached
  lola petrinet.lola -f "REACHABLE (p = 1 AND q > 2)"    # Tests whether a marking M such that
                                                         #  M(p) = 1 and M(q) > 2 can be reached
  lola petrinet.lola -f "REACHABLE (p + q = 1 OR r > 2)" # Tests whether a marking M such that
                                                         #  M(p) + M(q) = 1 or M(r) > 2 can be reached
  lola petrinet.lola -f "REACHABLE FIREABLE(t)"          # Tests whether it is possible to reach a marking
                                                         #  at which t is fireable

Positive reachability queries can be witnessed by a state and a path using flags -s and -p respectively.

The tool documentation can be found at http://download.gna.org/service-tech/lola/lola.pdf.
