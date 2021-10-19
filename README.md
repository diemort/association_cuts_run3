Everything to be run in environment of your CMSSW branch. As an example, see the `environment` file.

Tested in CMSSW_12_1_0_pre4.



Directory "extract_parameters"
==============================

* Contains tools to run MC (direct simulation) and to extract new association cut strings from the simulation.

* Execute `./run_simu` to run a new simulation. On line 9, you can change the number of simulated events. 1E7 is a decent statistics, but it takes ~2h on LXPLUS.

* `analyze.cc` is the code to fit the hit distributions. Run `make && ./analyze` to execute it - it takes few seconds. The results can be investigated by opening `analyze.root` in the ROOT browser.



Directory "efficiency"
==============================

* to test the efficiency

* in "run_multiple"
  - line 3: set the statistics: 1E4 runs for a minute, 1E5 runs about 10 minutes but gives smoother results
  - line 5: list of models to test
  - execute "./run_multiple" to run it

* template_cfg.py
  - lines 37 to 66: definition of the models
  - lines 69 to 72: symmetriation of the settings

