from Configuration.Eras.Era_Run3_cff import *
era = Run3

def LoadConfig(process):
  global config
  import Validation.CTPPS.simu_config.year_$year_cff as config
  process.load("Validation.CTPPS.simu_config.year_$year_cff")
  process.ctppsCompositeESSource.periods = [config.profile_$year_default]
  process.profile_$year_default.ctppsLHCInfo.beamEnergy = $Ebeam
