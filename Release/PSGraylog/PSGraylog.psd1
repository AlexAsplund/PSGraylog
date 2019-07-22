#
# Module manifest for module 'PSGet_PSGraylog'
#
# Generated by: Alex Asplund
#
# Generated on: 2019-07-22
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSGraylog.psm1'

# Version number of this module.
ModuleVersion = '0.0.2'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '050d6687-639a-4651-9d33-d40f524f1392'

# Author of this module
Author = 'Alex Asplund'

# Company or vendor of this module
CompanyName = 'automativity.com'

# Copyright statement for this module
Copyright = '(c) 2018 Alex Asplund. All rights reserved.'

# Description of the functionality provided by this module
Description = 'A Powershell module for Graylog'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Add-GLStreamAlertsReceiver', 'Add-GLStreamOutputs', 
               'Analyze-GLMessages', 'Cancel-GLClusterJobsJob', 
               'Cancel-GLSystemJobs', 'Close-GLIndexerIndices', 
               'Connect-GLPipelinesConnectionsPipelines', 
               'Connect-GLPipelinesConnectionsStreams', 
               'Copy-GLSidecarCollectorsCollector', 
               'Copy-GLSidecarConfigurationsConfiguration', 
               'Copy-GLStreamsCloneStream', 
               'Download-GLSystemContentPacksContentPackRevisions', 
               'Find-GLMessagesSearch', 
               'Find-GLSearchAbsoluteExportSearchAbsoluteChunked', 
               'Find-GLSearchAbsoluteFieldHistogramAbsolute', 
               'Find-GLSearchAbsoluteHistogramAbsolute', 
               'Find-GLSearchAbsoluteSearchAbsolute', 
               'Find-GLSearchAbsoluteSearchAbsoluteChunked', 
               'Find-GLSearchAbsoluteStatsAbsolute', 
               'Find-GLSearchAbsoluteTermsAbsolute', 
               'Find-GLSearchAbsoluteTermsHistogramRelative', 
               'Find-GLSearchAbsoluteTermsStatsAbsolute', 
               'Find-GLSearchKeywordExportSearchKeywordChunked', 
               'Find-GLSearchKeywordFieldHistogramKeyword', 
               'Find-GLSearchKeywordHistogramKeyword', 
               'Find-GLSearchKeywordSearchKeyword', 
               'Find-GLSearchKeywordSearchKeywordChunked', 
               'Find-GLSearchKeywordStatsKeyword', 
               'Find-GLSearchKeywordTermsHistogramRelative', 
               'Find-GLSearchKeywordTermsKeyword', 
               'Find-GLSearchRelativeExportSearchRelativeChunked', 
               'Find-GLSearchRelativeFieldHistogramRelative', 
               'Find-GLSearchRelativeHistogramRelative', 
               'Find-GLSearchRelativeSearchRelative', 
               'Find-GLSearchRelativeSearchRelativeChunked', 
               'Find-GLSearchRelativeStatsRelative', 
               'Find-GLSearchRelativeTermsHistogramRelative', 
               'Find-GLSearchRelativeTermsRelative', 
               'Find-GLSystemClusterStatsElasticsearchStats', 
               'Get-GLAlarmCallbackHistoriesForAlert', 'Get-GLAlarmCallbacksAll', 
               'Get-GLAlarmCallbacksAvailable', 'Get-GLAlertConditionsAll', 
               'Get-GLAlertConditionsAvailable', 'Get-GLAlerts', 
               'Get-GLAlertsPaginated', 'Get-GLAlertsRecent', 'Get-GLCluster', 
               'Get-GLClusterInputState', 'Get-GLClusterJobs', 
               'Get-GLClusterJobsJob', 'Get-GLClusterJournal', 'Get-GLClusterJvm', 
               'Get-GLClusterMetricsMultipleMetricsAllNodes', 
               'Get-GLClusterNodeMetricsByNamespace', 
               'Get-GLClusterNodeMetricsMetricNames', 
               'Get-GLClusterNodeMetricsMultipleMetrics', 'Get-GLClusterPlugins', 
               'Get-GLClusterSystemLoggersLoggers', 
               'Get-GLClusterSystemLoggersSubsystems', 'Get-GLClusterThreadDump', 
               'Get-GLCountsTotal', 'Get-GLCountsTotalAll', 'Get-GLDashboards', 
               'Get-GLDashboardsAll', 'Get-GLDashboardsWidgetsAddWid', 
               'Get-GLDashboardsWidgetsWid', 'Get-GLDashboardsWidgetsWidValue', 
               'Get-GLDocumentationOverview', 'Get-GLDocumentationRoute', 
               'Get-GLExtractors', 'Get-GLExtractorsOrder', 'Get-GLExtractorsSingle', 
               'Get-GLIndexerClusterClusterHealth', 
               'Get-GLIndexerClusterClusterName', 'Get-GLIndexerFailuresSingle', 
               'Get-GLIndexerIndicesAll', 'Get-GLIndexerIndicesIndex', 
               'Get-GLIndexerIndicesIndexOpen', 'Get-GLIndexerIndicesMultiple', 
               'Get-GLIndexerIndicesOpen', 'Get-GLIndexerIndicesSingle', 
               'Get-GLIndexerIndicesTemplates', 'Get-GLIndexerIndicesTemplatesAll', 
               'Get-GLIndexerOverviewIndex', 'Get-GLIndexerOverviewIndexAll', 
               'Get-GLMapWidgetMapData', 'Get-GLPipelinesConnectionsAll', 
               'Get-GLPipelinesConnectionsPipelinesForStream', 
               'Get-GLPipelinesPipelines', 'Get-GLPipelinesPipelinesAll', 
               'Get-GLPipelinesRules', 'Get-GLPipelinesRulesAll', 
               'Get-GLPipelinesRulesBulk', 
               'Get-GLPipelinesRulesFunctionDescriptors', 'Get-GLRolesAll', 
               'Get-GLRolesMembers', 'Get-GLRolesRead', 'Get-GLSearchDecorators', 
               'Get-GLSearchDecoratorsAvailable', 
               'Get-GLSearchKeywordTermsStatsRelative', 
               'Get-GLSearchRelativeTermsStatsRelative', 'Get-GLSearchSaved', 
               'Get-GLSearchSavedAll', 'Get-GLSidecar', 
               'Get-GLSidecarAdministrationAdministration', 'Get-GLSidecarAll', 
               'Get-GLSidecarCollectorActionsAction', 
               'Get-GLSidecarCollectorsCollector', 
               'Get-GLSidecarCollectorsCollectors', 
               'Get-GLSidecarCollectorsSummary', 
               'Get-GLSidecarConfigurationsConfigurations', 
               'Get-GLSidecarConfigurationsConfigurationsAll', 
               'Get-GLSidecarConfigurationsConfigurationSidecars', 
               'Get-GLSidecarConfigurationsImports', 
               'Get-GLSidecarConfigurationsRenderConfiguration', 
               'Get-GLSidecarConfigurationsRenderConfigurationAll', 
               'Get-GLSidecarConfigurationVariablesConfigurationVariables', 
               'Get-GLSidecarConfigurationVariablesConfigurationVariablesConfigurations', 
               'Get-GLSidecarSidecars', 'Get-GLSources', 
               'Get-GLStreamAlarmCallbacks', 'Get-GLStreamAlarmCallbacksAll', 
               'Get-GLStreamAlarmCallbacksAvailable', 
               'Get-GLStreamAlertConditions', 'Get-GLStreamAlertConditionsAll', 
               'Get-GLStreamAlerts', 'Get-GLStreamAlertsPaginated', 
               'Get-GLStreamOutputs', 'Get-GLStreamOutputsAll', 'Get-GLStreamRules', 
               'Get-GLStreamRulesAll', 'Get-GLStreamRulesTypes', 'Get-GLStreams', 
               'Get-GLStreamsAll', 'Get-GLStreamsEnabled', 
               'Get-GLSystemAuthenticationAuthenticators', 
               'Get-GLSystemCatalogShowEntityIndex', 'Get-GLSystemClusterConfig', 
               'Get-GLSystemClusterConfigRead', 'Get-GLSystemClusterConfigSchema', 
               'Get-GLSystemClusterNode', 'Get-GLSystemClusterNodeAll', 
               'Get-GLSystemClusterNodes', 'Get-GLSystemClusterStatsMongoStats', 
               'Get-GLSystemClusterStatsSystemStats', 'Get-GLSystemClusterTraffic', 
               'Get-GLSystemCodecsTypesAll', 'Get-GLSystemConfigurationRelevant', 
               'Get-GLSystemContentPacksContentPackInstallationsById', 
               'Get-GLSystemContentPacksContentPackRevisions', 
               'Get-GLSystemContentPacksContentPackRevisionsAll', 
               'Get-GLSystemContentPacksContentPacks', 
               'Get-GLSystemContentPacksLatestContentPacks', 
               'Get-GLSystemContentPacksUninstallDetails', 
               'Get-GLSystemDebugEventsShowLastClusterDebugEvent', 
               'Get-GLSystemDebugEventsShowLastDebugEvent', 
               'Get-GLSystemDeflectorDeflector', 
               'Get-GLSystemDeflectorDeprecatedDeflector', 
               'Get-GLSystemFieldsFields', 
               'Get-GLSystemGettingStartedGuidesDismisstingStarted', 
               'Get-GLSystemGettingStartedGuidesDisplaytingStarted', 
               'Get-GLSystemGrokGrokPatterns', 'Get-GLSystemGrokPattern', 
               'Get-GLSystemIndexRanges', 'Get-GLSystemIndexRangesRebuild', 
               'Get-GLSystemIndexRangesRebuildIndex', 
               'Get-GLSystemIndexRangesShow', 'Get-GLSystemIndexSets', 
               'Get-GLSystemIndexSetsAll', 'Get-GLSystemIndexSetsGlobalStats', 
               'Get-GLSystemIndexSetsIndexStatistics', 
               'Get-GLSystemIndicesRetention', 
               'Get-GLSystemIndicesRetentionConfigSchema', 
               'Get-GLSystemIndicesRotation', 
               'Get-GLSystemIndicesRotationConfigSchema', 'Get-GLSystemInputs', 
               'Get-GLSystemInputsAll', 'Get-GLSystemInputStates', 
               'Get-GLSystemInputStatesAll', 'Get-GLSystemInputsTypesAll', 
               'Get-GLSystemInputsTypesInfo', 'Get-GLSystemInputsTypesTypes', 
               'Get-GLSystemJobs', 'Get-GLSystemJobsAll', 'Get-GLSystemJournalShow', 
               'Get-GLSystemJvm', 'Get-GLSystemLDAPLdaptings', 
               'Get-GLSystemLDAPReadGroupMapping', 'Get-GLSystemLDAPReadGroups', 
               'Get-GLSystemLoadBalancersStatus', 'Get-GLSystemLocales', 
               'Get-GLSystemLoggersLoggers', 'Get-GLSystemLoggersMessages', 
               'Get-GLSystemLoggersSubsystems', 'Get-GLSystemLookup', 
               'Get-GLSystemLookupAdapter', 'Get-GLSystemLookupAdapters', 
               'Get-GLSystemLookupAvailableAdapterTypes', 
               'Get-GLSystemLookupAvailableCacheTypes', 'Get-GLSystemLookupCache', 
               'Get-GLSystemLookupCaches', 'Get-GLSystemLookupErrorStates', 
               'Get-GLSystemLookupTables', 'Get-GLSystemMessageProcessorsConfig', 
               'Get-GLSystemMessagesAll', 'Get-GLSystemMetricsByNamespace', 
               'Get-GLSystemMetricsHistoryHistoricSingleMetric', 
               'Get-GLSystemMetricsMetricNames', 'Get-GLSystemMetricsMetrics', 
               'Get-GLSystemMetricsMultipleMetrics', 
               'Get-GLSystemMetricsSingleMetric', 
               'Get-GLSystemNotificationsNotifications', 'Get-GLSystemOutputs', 
               'Get-GLSystemOutputsAll', 'Get-GLSystemOutputsAvailable', 
               'Get-GLSystemPermissionsPermissions', 
               'Get-GLSystemPermissionsReaderPermissions', 'Get-GLSystemPlugins', 
               'Get-GLSystemServiceManager', 'Get-GLSystemStatsFsStats', 
               'Get-GLSystemStatsJvmStats', 'Get-GLSystemStatsNetworkStats', 
               'Get-GLSystemStatsOsStats', 'Get-GLSystemStatsProcessStats', 
               'Get-GLSystemStatsSystemStats', 'Get-GLSystemSystem', 
               'Get-GLSystemThreaddump', 'Get-GLSystemThreadDumpAsText', 
               'Get-GLSystemThroughputTotal', 'Get-GLUsers', 'Get-GLUsersTokens', 
               'Get-GLUsersUsers', 'Install-GLSystemContentPacksContentPack', 
               'Measure-GLIndexerFailuresCount', 'New-GLDashboards', 
               'New-GLExtractors', 'New-GLPipelinesPipelinesFromParser', 
               'New-GLPipelinesRulesFromParser', 'New-GLRoles', 
               'New-GLSearchDecorators', 'New-GLSearchSaved', 
               'New-GLSidecarCollectorsCollector', 
               'New-GLSidecarConfigurationsConfiguration', 
               'New-GLSidecarConfigurationVariablesConfigurationVariable', 
               'New-GLStaticFields', 'New-GLStreamAlarmCallbacks', 
               'New-GLStreamAlertConditions', 'New-GLStreamAlertConditionsTest', 
               'New-GLStreamRules', 'New-GLStreams', 'New-GLSystemAuthentication', 
               'New-GLSystemContentPacksContentPack', 
               'New-GLSystemDebugEventsGenerateClusterDebugEvent', 
               'New-GLSystemDebugEventsGenerateDebugEvent', 
               'New-GLSystemDeflectorDeprecatedCycle', 'New-GLSystemGrokPattern', 
               'New-GLSystemInputs', 'New-GLSystemJobsTrigger', 
               'New-GLSystemLookupAdapter', 'New-GLSystemLookupCache', 
               'New-GLSystemLookupTable', 'New-GLSystemOutputs', 
               'New-GLSystemSessionsSession', 'New-GLUsers', 
               'New-GLUsersGenerateToken', 'Open-GLIndexerIndicesClosed', 
               'Open-GLIndexerIndicesIndexClosed', 
               'Open-GLIndexerIndicesIndexReed', 'Open-GLIndexerIndicesRe', 
               'Open-GLIndexerIndicesReed', 'Parse-GLMessages', 
               'Parse-GLPipelinesPipelines', 'Parse-GLPipelinesRules', 
               'Pause-GLClusterProcessing', 'Pause-GLStreams', 'Remove-GLDashboards', 
               'Remove-GLDashboardsWidgets', 'Remove-GLExtractorsTerminate', 
               'Remove-GLIndexerIndices', 'Remove-GLPipelinesPipelines', 
               'Remove-GLPipelinesRules', 'Remove-GLRoles', 'Remove-GLRolesMember', 
               'Remove-GLSearchDecorators', 'Remove-GLSearchSaved', 
               'Remove-GLSidecarCollectorsCollector', 
               'Remove-GLSidecarConfigurationsConfiguration', 
               'Remove-GLSidecarConfigurationVariablesConfigurationVariable', 
               'Remove-GLStaticFields', 'Remove-GLStreamAlarmCallbacks', 
               'Remove-GLStreamAlertConditions', 'Remove-GLStreamAlertsReceiver', 
               'Remove-GLStreamOutputs', 'Remove-GLStreamRules', 'Remove-GLStreams', 
               'Remove-GLSystemClusterConfig', 
               'Remove-GLSystemContentPacksContentPack', 
               'Remove-GLSystemContentPacksContentPackAll', 
               'Remove-GLSystemContentPacksContentPackInstallationById', 
               'Remove-GLSystemGrokPattern', 'Remove-GLSystemIndexSets', 
               'Remove-GLSystemLDAPLdaptings', 'Remove-GLSystemLookupAdapter', 
               'Remove-GLSystemLookupCache', 'Remove-GLSystemLookupTable', 
               'Remove-GLSystemNotificationsNotification', 
               'Remove-GLSystemOutputs', 'Remove-GLUsersPermissions', 
               'Remove-GLUsersUser', 'Resolve-GLSystemCatalogEntities', 
               'Resolve-GLSystemLookupPerformAdapterLookup', 
               'Resolve-GLSystemLookupPerformLookup', 
               'Resolve-GLSystemLookupPerformPurge', 'Resume-GLClusterProcessing', 
               'Resume-GLStreams', 'Revoke-GLUsersToken', 
               'Send-GLAlarmCallbacksTest', 'Send-GLStreamAlertsDummyAlert', 
               'Set-GLClusterInputStateStart', 'Set-GLClusterInputStateStop', 
               'Set-GLClusterLoadBalancersOverride', 
               'Set-GLClusterSystemLoggersSubsystemLoggerLevel', 
               'Set-GLDashboardsPositions', 'Set-GLIndexerIndicesTemplatesSync', 
               'Set-GLIndexerIndicesTemplatesSyncAll', 'Set-GLRolesAddMember', 
               'Set-GLSidecarAdministrationAction', 
               'Set-GLSidecarAssignConfiguration', 
               'Set-GLSidecarCollectorActionsAction', 'Set-GLSidecarRegister', 
               'Set-GLSystemDeflectorCycle', 'Set-GLSystemIndexRangesRebuildIndex', 
               'Set-GLSystemIndexSetsDefault', 'Set-GLSystemIndexSetsSave', 
               'Set-GLSystemInputStatesStart', 'Set-GLSystemInputStatesStop', 
               'Set-GLSystemLoadBalancersOverride', 
               'Set-GLSystemLoggersSingleLoggerLevel', 
               'Set-GLSystemLoggersSubsystemLoggerLevel', 
               'Set-GLSystemProcessingPauseProcessing', 
               'Set-GLSystemProcessingResumeProcessing', 
               'Set-GLUsersChangePassword', 'Set-GLUsersChangeUser', 
               'Set-GLUsersEditPermissions', 'Set-GLUsersSavePreferences', 
               'Simulate-GLPipelinesSimulator', 'Start-GLClusterDeflectorCycle', 
               'Start-GLClusterDeflectorCycleAll', 
               'Start-GLStreamAlertsCheckConditions', 
               'Stop-GLClusterShutdownShutdown', 'Stop-GLSystemInputsTerminate', 
               'Stop-GLSystemSessionsTerminateSession', 
               'Stop-GLSystemShutdownShutdown', 
               'Test-GLSidecarCollectorsValidateCollector', 
               'Test-GLSidecarConfigurationsValidateConfiguration', 
               'Test-GLSidecarConfigurationVariablesValidateConfigurationVariable', 
               'Test-GLStreamAlertConditionsExisting', 'Test-GLStreamsMatch', 
               'Test-GLSystemGrokPattern', 'Test-GLSystemLDAPLdapConfiguration', 
               'Test-GLSystemLookupValidateAdapter', 
               'Test-GLSystemLookupValidateCache', 
               'Test-GLSystemLookupValidateTable', 
               'Test-GLSystemSessionsValidateSession', 'Update-GLDashboards', 
               'Update-GLDashboardsWidgetsCacheTime', 
               'Update-GLDashboardsWidgetsDescription', 
               'Update-GLDashboardsWidgetsWid', 'Update-GLExtractors', 
               'Update-GLPipelinesPipelines', 'Update-GLPipelinesRules', 
               'Update-GLRoles', 'Update-GLSearchDecorators', 'Update-GLSearchSaved', 
               'Update-GLSidecarCollectorsCollector', 
               'Update-GLSidecarConfigurationsConfiguration', 
               'Update-GLSidecarConfigurationVariablesConfigurationVariable', 
               'Update-GLStreamAlarmCallbacks', 'Update-GLStreamAlertConditions', 
               'Update-GLStreamRules', 'Update-GLStreams', 
               'Update-GLSystemClusterConfig', 'Update-GLSystemGrokBulkPatterns', 
               'Update-GLSystemGrokBulkPatternsFromTextFile', 
               'Update-GLSystemGrokPattern', 'Update-GLSystemIndexSets', 
               'Update-GLSystemInputs', 'Update-GLSystemLDAPGroupMappingtings', 
               'Update-GLSystemLDAPLdaptings', 'Update-GLSystemLookupAdapter', 
               'Update-GLSystemLookupCache', 'Update-GLSystemLookupTable', 
               'Update-GLSystemMessageProcessorsConfig', 'Update-GLSystemOutputs', 
               'Convert-GLTokenToCredential', 'Set-GLAPIConfig'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        # ProjectUri = ''

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '# Release notes

## 0.0.2
Generation of cmdlets from Graylog Swagger API

## 0.0.1
Initial creation of project with plaster template'

        # External dependent modules of this module
        # ExternalModuleDependencies = ''

    } # End of PSData hashtable
    
 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

