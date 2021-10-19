Everything to be run in environment of your CMSSW branch. As an example, see the `environment` file.

Tested in CMSSW_12_1_0_pre4.



Directory "extract_parameters"
==============================

* Contains tools to run MC (direct simulation) and to extract new association cut strings from the simulation.

* Execute `./run_simu` to run a new simulation. On line 9, you can change the number of simulated events. 1E7 is a decent statistics, but it takes ~2h on LXPLUS.

* `analyze.cc` is the code to fit the hit distributions - adjust the simulated statistics on line 229. Run `make && ./analyze` to execute it - it takes few seconds. The results can be investigated by opening `analyze.root` in the ROOT browser.



Directory "efficiency"
==============================

* Contains tools to evaluate the efficiency of the near-far association. The efficiency is evaluated with the standard CMSSW module `CTPPSProtonReconstructionEfficiencyEstimatorData`. The scripts allow to either use the default association cuts settings (model "default") or define customs settings/models (see below)

* One can adjust settings in `run_multiple`.
  - Line 3: set the statistics: 1E4 runs for a minute, 1E5 runs about 10 minutes but gives smoother results.
  - Line 5: list of models to test. 

* One can adjust the configuration template `template_cfg.py`.
  - Lines 37 to 66: definition of the models.
  - Lines 69 to 72: symmetriation of the settings. The current optics estimate is L-R symmetric.

* Execute `./run_multiple` to run the tests. The results can be investigated by opening `simu/<model>/<statistics>/mc_eff_data.root`, in particular by checking the efficiency histograms `arm <arm>/exp prot <multiplicity>/nsi = 5.0/p_eff2_vs_x_N`. Generally, the "eff2" estimate is considered better.
