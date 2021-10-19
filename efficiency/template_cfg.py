import FWCore.ParameterSet.Config as cms

# 2022 settings
from Configuration.Eras.Era_Run3_cff import *
process = cms.Process('Test', Run3)

import Validation.CTPPS.simu_config.year_2022_cff as config
process.load("Validation.CTPPS.simu_config.year_2022_cff")
process.ctppsCompositeESSource.periods = [config.profile_2022_default]

# minimal logger settings
process.MessageLogger = cms.Service("MessageLogger",
  statistics = cms.untracked.vstring(),
  destinations = cms.untracked.vstring('cout'),
  cout = cms.untracked.PSet(
    threshold = cms.untracked.string('WARNING')
  )
)

# number of events
process.maxEvents = cms.untracked.PSet(
  input = cms.untracked.int32(int($statistics))
)

# number of protons per event
process.generator.nParticlesSector45 = 4
process.generator.nParticlesSector56 = 4

# update association cuts
model = "$model"

import CalibPPS.ESProducers.ppsAssociationCuts_non_DB_cff as ac

def Symmetrise(ac):
	ac.association_cuts_45.x_cut_mean = ac.association_cuts_56.x_cut_mean
	ac.association_cuts_45.x_cut_threshold = ac.association_cuts_56.x_cut_threshold
	ac.association_cuts_45.y_cut_mean = ac.association_cuts_56.y_cut_mean
	ac.association_cuts_45.y_cut_threshold = ac.association_cuts_56.y_cut_threshold

if model == "default":
  pass

if model == "old":
  ac.use_single_infinite_iov_entry(ac.ppsAssociationCutsESSource, ac.p2016)
  Symmetrise(ac.p2022)

if model == "model1":
  ac.p2022.association_cuts_56.x_cut_mean = "+0.15"
  ac.p2022.association_cuts_56.x_cut_threshold = "4 * 0.18"
  ac.p2022.association_cuts_56.y_cut_mean = "0"
  ac.p2022.association_cuts_56.y_cut_threshold = "4 * 0.17"
  ac.use_single_infinite_iov_entry(ac.ppsAssociationCutsESSource, ac.p2022)
  Symmetrise(ac.p2022)

if model == "model2":
  ac.p2022.association_cuts_56.x_cut_mean = "-( (-0.217201+0.038945*[x_near]+-0.002679*[x_near]*[x_near]) - (0.005805+0.509159/[x_near])*abs([y_near]) )"
  ac.p2022.association_cuts_56.x_cut_threshold = "4 * (0.076254+0.009505*[x_near])"
  ac.p2022.association_cuts_56.y_cut_mean = "- (0.047727+0.297293/[x_near])*[y_near]"
  ac.p2022.association_cuts_56.y_cut_threshold = "4 * ( (0.009201+1.286303/[x_near]/[x_near]) + (0.010613+-17.666354/pow([x_near],5))*abs([y_near]) )"
  ac.use_single_infinite_iov_entry(ac.ppsAssociationCutsESSource, ac.p2022)
  Symmetrise(ac.p2022)

if model == "model3":
  ac.p2022.association_cuts_56.x_cut_mean = "- ( (-0.336488+0.069988*[x_near]+-0.004550*[x_near]*[x_near]) - (0.020667+0.398921/[x_near])*abs([y_near]) )"
  ac.p2022.association_cuts_56.x_cut_threshold = "4 * ( (0.071700+0.010015*[x_near]) )"
  ac.p2022.association_cuts_56.y_cut_mean = "- ( (0.769397+-1.418314/[x_near])*TMath::Erf([y_near]/(10.042157+-31.606745/[x_near])) )"
  ac.p2022.association_cuts_56.y_cut_threshold = "4 * ( (0.013268+1.103879/[x_near]/[x_near]) + (0.009711+-14.172028/pow([x_near],5))*abs([y_near]) )"
  ac.use_single_infinite_iov_entry(ac.ppsAssociationCutsESSource, ac.p2022)
  Symmetrise(ac.p2022)

if model == "model4":
  ac.p2022.association_cuts_56.x_cut_mean = "- ( (-0.530895+0.112595*[x_near]+-0.006785*[x_near]*[x_near]) - (0.046487+0.179333/[x_near])*abs([y_near]) )"
  ac.p2022.association_cuts_56.x_cut_threshold = "4 * ( (0.091692+0.009316*[x_near]) + (-0.000727)*[y_near]*[y_near] )"
  ac.p2022.association_cuts_56.y_cut_mean = "- ( (0.672525+-0.619398/[x_near])*TMath::Erf([y_near]/(0.968499+0.597136*[x_near])) )"
  ac.p2022.association_cuts_56.y_cut_threshold = "4 * ( (0.015202+0.962944/[x_near]/[x_near]) + (0.009804+-7.710241/pow([x_near],5))*abs([y_near]) )"
  ac.use_single_infinite_iov_entry(ac.ppsAssociationCutsESSource, ac.p2022)
  Symmetrise(ac.p2022)

if model == "model4-x4-y3":
  ac.p2022.association_cuts_56.x_cut_mean = "- ( (-0.530895+0.112595*[x_near]+-0.006785*[x_near]*[x_near]) - (0.046487+0.179333/[x_near])*abs([y_near]) )"
  ac.p2022.association_cuts_56.x_cut_threshold = "4 * ( (0.091692+0.009316*[x_near]) + (-0.000727)*[y_near]*[y_near] )"
  ac.p2022.association_cuts_56.y_cut_mean = "- ( (0.672525+-0.619398/[x_near])*TMath::Erf([y_near]/(0.968499+0.597136*[x_near])) )"
  ac.p2022.association_cuts_56.y_cut_threshold = "3 * ( (0.015202+0.962944/[x_near]/[x_near]) + (0.009804+-7.710241/pow([x_near],5))*abs([y_near]) )"
  ac.use_single_infinite_iov_entry(ac.ppsAssociationCutsESSource, ac.p2022)
  Symmetrise(ac.p2022)

if model == "model4-x4-y2":
  ac.p2022.association_cuts_56.x_cut_mean = "- ( (-0.530895+0.112595*[x_near]+-0.006785*[x_near]*[x_near]) - (0.046487+0.179333/[x_near])*abs([y_near]) )"
  ac.p2022.association_cuts_56.x_cut_threshold = "4 * ( (0.091692+0.009316*[x_near]) + (-0.000727)*[y_near]*[y_near] )"
  ac.p2022.association_cuts_56.y_cut_mean = "- ( (0.672525+-0.619398/[x_near])*TMath::Erf([y_near]/(0.968499+0.597136*[x_near])) )"
  ac.p2022.association_cuts_56.y_cut_threshold = "2 * ( (0.015202+0.962944/[x_near]/[x_near]) + (0.009804+-7.710241/pow([x_near],5))*abs([y_near]) )"
  ac.use_single_infinite_iov_entry(ac.ppsAssociationCutsESSource, ac.p2022)
  Symmetrise(ac.p2022)

# reconstruction efficiency - MC module
process.ctppsProtonReconstructionEfficiencyEstimatorMC = cms.EDAnalyzer("CTPPSProtonReconstructionEfficiencyEstimatorMC",
  tagHepMCAfterSmearing = cms.InputTag("beamDivergenceVtxGenerator"),
  tagStripRecHitsPerParticle = cms.InputTag('ctppsDirectProtonSimulation'),
  tagPixelRecHitsPerParticle = cms.InputTag('ctppsDirectProtonSimulation'),
  tagTracks = cms.InputTag('ctppsLocalTrackLiteProducer'),
  tagRecoProtonsMultiRP = cms.InputTag("ctppsProtons", "multiRP"),

  lhcInfoLabel = cms.string(""),

  rpId_45_F = process.rpIds.rp_45_F,
  rpId_45_N = process.rpIds.rp_45_N,
  rpId_56_N = process.rpIds.rp_56_N,
  rpId_56_F = process.rpIds.rp_56_F,

  outputFile = cms.string("mc_eff_mc.root")
)

# reconstruction efficiency - data module
process.load("Validation.CTPPS.ctppsProtonReconstructionEfficiencyEstimatorData_cfi")
process.ctppsProtonReconstructionEfficiencyEstimatorData.tagTracks = cms.InputTag('ctppsLocalTrackLiteProducer')
process.ctppsProtonReconstructionEfficiencyEstimatorData.tagRecoProtonsMultiRP = cms.InputTag("ctppsProtons", "multiRP")

process.ctppsProtonReconstructionEfficiencyEstimatorData.rpId_45_F = process.rpIds.rp_45_F
process.ctppsProtonReconstructionEfficiencyEstimatorData.rpId_45_N = process.rpIds.rp_45_N
process.ctppsProtonReconstructionEfficiencyEstimatorData.rpId_56_N = process.rpIds.rp_56_N
process.ctppsProtonReconstructionEfficiencyEstimatorData.rpId_56_F = process.rpIds.rp_56_F

process.ctppsProtonReconstructionEfficiencyEstimatorData.outputFile = cms.string("mc_eff_data.root")

process.ctppsProtonReconstructionEfficiencyEstimatorData.verbosity = cms.untracked.uint32(0)

# processing path
process.p = cms.Path(
    process.generator
    * process.beamDivergenceVtxGenerator
    * process.ctppsDirectProtonSimulation

    * process.reco_local

    * process.ctppsProtons

    #* process.ctppsProtonReconstructionEfficiencyEstimatorMC
    * process.ctppsProtonReconstructionEfficiencyEstimatorData
)
