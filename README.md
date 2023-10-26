# Idea

- Add a way to add mods on entrypoint
- Add a way to backup server files to aws s3
- Add UI to manage server
  - Start/Stop
  - Backup
  - Add/Remove mods
  - Add/Remove players
  - Manage server settings
  - Player stats
  -

# Environment variables

| Variable        | Default     | Description                                                                                                                             |
| --------------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `MAP`           | `TheIsland` | TheIsland, ScorchedEarth_P, Aberration_P, Extinction, Genesis, TheCenter, Ragnarok, CrystalIsles, Valguero_P, Fjordur, Gen2, LostIsland |
| `CLUSTER`       | `Cluster`   | Name of the cluster                                                                                                                     |
| `EVENT`         | `None`      | Easter, Arkaeology, ExtinctionChronicles, WinterWonderland, vday, Summer, FearEvolved, TurkeyTrial, birthday, None                      |
| `OPTIONS`       |             | Options for the server                                                                                                                  |
| `CUSTOM_PARAMS` |             | Custom parameters for the server                                                                                                        |
| `PORT`          | `7777`      | Port for the server                                                                                                                     |
| `QUERY_PORT`    | `27015`     | Port steam uses to query the server (Query Port cannot be between 27020 and 27050 due to Steam using those ports)                       |
| `RCON_PORT`     | `27020`     | Port for the rcon server                                                                                                                |

### Options for the server

|                                |                              |                                                       |                        |
| ------------------------------ | ---------------------------- | ----------------------------------------------------- | ---------------------- |
| `-UseDynamicConfig`            | `-automanagedmods`           | `-ClearOldItems`                                      | `-culture=??`          |
| `-EnableIdlePlayerKick`        | `-ForceAllowCaveFlyers`      | `-ForceRespawnDinos`                                  | `-gameplaylogging`     |
| `-MapModID=#########`          | `-noantispeedhack`           | `-NoBattlEye`                                         | `-NoBiomeWalls`        |
| `-nocombineclientmoves`        | `-nofishloot`                | `-noninlinesaveload`                                  | `-nomansky`            |
| `-nomemorybias`                | `-NotifyAdminCommandsInChat` | `-PreventHibernation`                                 | `-servergamelog`       |
| `-ServerRCONOutputTribeLogs`   | `-StasisKeepControllers`     | `-StructureDestructionTag=DestroySwampSnowStructures` | `-usecache`            |
| `-exclusivejoin`               | `-NewYearEvent`              | `-nodinos`                                            | `-noundermeshchecking` |
| `-noundermeshkilling`          | `-AutoDestroyStructures`     | `-crossplay`                                          | `-epiconly`            |
| `-PublicIPForEpic=<IPAddress>` | `-UseStructureStasisGrid`    |                                                       |

### Custom parameters for the server

|                                             |                                             |                                                  |                                           |
| ------------------------------------------- | ------------------------------------------- | ------------------------------------------------ | ----------------------------------------- |
| `?CustomLiveTuningUrl=<link>`               | `?AllowAnyoneBabyImprintCuddle=true`        | `?AllowCrateSpawnsOnTopOfStructures=true`        | `?AllowFlyingStaminaRecovery=false`       |
| `?AllowMultipleAttachedC4=false`            | `?AutoDestroyDecayedDinos=true`             | `?ClampItemSpoilingTimes=true`                   | `?ClampItemStats=true`                    |
| `?DestroyUnconnectedWaterPipes=true`        | `?DisableImprintDinoBuff=true`              | `?EnableExtraStructurePreventionVolumes=true`    | `?ExtinctionEventTimeInterval=2592000`    |
| `?FastDecayUnsnappedCoreStructures=true`    | `?ForceFlyerExplosives=true`                | `?MaxPersonalTamedDinos=Number`                  | `?MinimumDinoReuploadInterval=xxxx`       |
| `?NonPermanentDiseases=true`                | `?OnlyAutoDestroyCoreStructures=true`       | `?OnlyDecayUnsnappedCoreStructures=true`         | `?OverrideOfficialDifficulty=5.0`         |
| `?OverrideStructurePlatformPrevention=true` | `?OxygenSwimSpeedStatMultiplier=1.0`        | `?PreventDiseases=true`                          | `?PreventDownloadSurvivors=False`         |
| `?PreventDownloadItems=False`               | `?PreventDownloadDinos=False`               | `?PreventUploadSurvivors=False`                  | `?PreventUploadItems=False`               |
| `?PreventUploadDinos=False`                 | `?PreventOfflinePvP=true`                   | `?PreventOfflinePvPInterval=900`                 | `?PreventSpawnAnimations=false`           |
| `?PvEAllowStructuresAtSupplyDrops=false`    | `?PvPDinoDecay=true`                        | `?ShowFloatingDamageText=true`                   | `?TribeLogDestroyedEnemyStructures=true`  |
| `?UseOptimizedHarvestingHealth=true`        | `?GameModIds=ModID1,ModID2`                 | `?ForceAllStructureLocking=true`                 | `?AutoDestroyOldStructuresMultiplier=1.0` |
| `?PreventTribeAlliances=true`               | `?AllowHitMarkers=false`                    | `?ServerCrosshair=false`                         | `?PreventMateBoost=true`                  |
| `?ServerAutoForceRespawnWildDinosInterval`  | `?PersonalTamedDinosSaddleStructureCost=19` | `?IgnoreLimitMaxStructuresInRangeTypeFlag=false` | `?NewYear1UTC=<epoch time>`               |
| `?NewYear2UTC=<epoch time>'`                |
