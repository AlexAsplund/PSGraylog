Class GrayLogRequestGrayLogAlarmcallbacksCreateAlarmCallback {

    [String]$type
    [String]$title
    [PSCustomObject]$configuration

    GrayLogRequestGrayLogAlarmcallbacksCreateAlarmCallback() {}

    GrayLogRequestGrayLogAlarmcallbacksCreateAlarmCallback([String]$type,[String]$title,[PSCustomObject]$configuration) {
        $This.type = $type
        $This.title = $title
        $This.configuration = $configuration
    }
}

Class GrayLogRequestGrayLogDashboardsAddWidget {

    [String]$description
    [String]$type
    [Int]$cache_time
    [PSCustomObject]$config

    GrayLogRequestGrayLogDashboardsAddWidget() {}

    GrayLogRequestGrayLogDashboardsAddWidget([String]$description,[String]$type,[Int]$cache_time,[PSCustomObject]$config) {
        $This.description = $description
        $This.type = $type
        $This.cache_time = $cache_time
        $This.config = $config
    }
}

Class GrayLogRequestGrayLogDashboardsCreateDashboard {

    [String]$title
    [String]$description

    GrayLogRequestGrayLogDashboardsCreateDashboard() {}

    GrayLogRequestGrayLogDashboardsCreateDashboard([String]$title,[String]$description) {
        $This.title = $title
        $This.description = $description
    }
}

Class GrayLogRequestGrayLogDashboardsUpdateDashboard {

    [String]$title
    [String]$description

    GrayLogRequestGrayLogDashboardsUpdateDashboard() {}

    GrayLogRequestGrayLogDashboardsUpdateDashboard([String]$title,[String]$description) {
        $This.title = $title
        $This.description = $description
    }
}

Class GrayLogRequestGrayLogDashboardsUpdateWidget {

    [String]$description
    [Int]$cache_time

    GrayLogRequestGrayLogDashboardsUpdateWidget() {}

    GrayLogRequestGrayLogDashboardsUpdateWidget([String]$description,[Int]$cache_time) {
        $This.description = $description
        $This.cache_time = $cache_time
    }
}

Class GrayLogRequestGrayLogDashboardsWidgetPositions {

    [Array]$positions

    GrayLogRequestGrayLogDashboardsWidgetPositions() {}

    GrayLogRequestGrayLogDashboardsWidgetPositions([Array]$positions) {
        $This.positions = $positions
    }
}

Class GrayLogRequestGrayLogMessagesMessageParse {

    [String]$message
    [String]$codec
    [String]$remote_address
    [PSCustomObject]$configuration

    GrayLogRequestGrayLogMessagesMessageParse() {}

    GrayLogRequestGrayLogMessagesMessageParse([String]$message,[String]$codec,[String]$remote_address,[PSCustomObject]$configuration) {
        $This.message = $message
        $This.codec = $codec
        $This.remote_address = $remote_address
        $This.configuration = $configuration
    }
}

Class GrayLogRequestGrayLogStreamsAlertsCreateCondition {

    [String]$type
    [String]$title
    [PSCustomObject]$parameters

    GrayLogRequestGrayLogStreamsAlertsCreateCondition() {}

    GrayLogRequestGrayLogStreamsAlertsCreateCondition([String]$type,[String]$title,[PSCustomObject]$parameters) {
        $This.type = $type
        $This.title = $title
        $This.parameters = $parameters
    }
}

Class GrayLogRequestGrayLogStreamsOutputsAddOutput {

    [Array]$outputs

    GrayLogRequestGrayLogStreamsOutputsAddOutput() {}

    GrayLogRequestGrayLogStreamsOutputsAddOutput([Array]$outputs) {
        $This.outputs = $outputs
    }
}

Class GrayLogRequestGrayLogStreamsOutputsCreateOutput {

    [String]$title
    [String]$type
    [PSCustomObject]$configuration
    [Array]$streams
    [String]$content_pack

    GrayLogRequestGrayLogStreamsOutputsCreateOutput() {}

    GrayLogRequestGrayLogStreamsOutputsCreateOutput([String]$title,[String]$type,[PSCustomObject]$configuration,[Array]$streams,[String]$content_pack) {
        $This.title = $title
        $This.type = $type
        $This.configuration = $configuration
        $This.streams = $streams
        $This.content_pack = $content_pack
    }
}

Class GrayLogRequestGrayLogStreamsUpdateStream {

    [String]$title
    [String]$description
    [String]$matching_type
    [Bool]$remove_matches_from_default_stream
    [String]$index_set_id

    GrayLogRequestGrayLogStreamsUpdateStream() {}

    GrayLogRequestGrayLogStreamsUpdateStream([String]$title,[String]$description,[String]$matching_type,[Bool]$remove_matches_from_default_stream,[String]$index_set_id) {
        $This.title = $title
        $This.description = $description
        $This.matching_type = $matching_type
        $This.remove_matches_from_default_stream = $remove_matches_from_default_stream
        $This.index_set_id = $index_set_id
    }
}

Class GrayLogRequestGrayLogSystemContenpacks {

    [Array]$entities

    GrayLogRequestGrayLogSystemContenpacks() {}

    GrayLogRequestGrayLogSystemContenpacks([Array]$entities) {
        $This.entities = $entities
    }
}

Class GrayLogRequestGrayLogSystemGrokpatternGrokPatternTest {

    [String]$grok_pattern
    [String]$sampleData

    GrayLogRequestGrayLogSystemGrokpatternGrokPatternTest() {}

    GrayLogRequestGrayLogSystemGrokpatternGrokPatternTest([String]$grok_pattern,[String]$sampleData) {
        $This.grok_pattern = $grok_pattern
        $This.sampleData = $sampleData
    }
}

Class GrayLogRequestGrayLogSystemIndexerIndicesRead {

    [Array]$indices

    GrayLogRequestGrayLogSystemIndexerIndicesRead() {}

    GrayLogRequestGrayLogSystemIndexerIndicesRead([Array]$indices) {
        $This.indices = $indices
    }
}

Class GrayLogRequestGrayLogSystemInputsCreateStaticField {

    [String]$key
    [String]$value

    GrayLogRequestGrayLogSystemInputsCreateStaticField() {}

    GrayLogRequestGrayLogSystemInputsCreateStaticField([String]$key,[String]$value) {
        $This.key = $key
        $This.value = $value
    }
}

Class GrayLogRequestGrayLogSystemInputsExtractorsCreateExtractor {

    [String]$title
    [String]$cut_or_copy
    [String]$source_field
    [String]$target_field
    [String]$extractor_type
    [PSCustomObject]$extractor_config
    [object]$converters
    [String]$condition_type
    [String]$condition_value
    [Int]$order

    GrayLogRequestGrayLogSystemInputsExtractorsCreateExtractor() {}

    GrayLogRequestGrayLogSystemInputsExtractorsCreateExtractor([String]$title,[String]$cut_or_copy,[String]$source_field,[String]$target_field,[String]$extractor_type,[PSCustomObject]$extractor_config,[object]$converters,[String]$condition_type,[String]$condition_value,[Int]$order) {
        $This.title = $title
        $This.cut_or_copy = $cut_or_copy
        $This.source_field = $source_field
        $This.target_field = $target_field
        $This.extractor_type = $extractor_type
        $This.extractor_config = $extractor_config
        $This.converters = $converters
        $This.condition_type = $condition_type
        $This.condition_value = $condition_value
        $This.order = $order
    }
}

Class GrayLogRequestGrayLogSystemInputsExtractorsOrderExtractors {

    [String]$order

    GrayLogRequestGrayLogSystemInputsExtractorsOrderExtractors() {}

    GrayLogRequestGrayLogSystemInputsExtractorsOrderExtractors([String]$order) {
        $This.order = $order
    }
}

Class GrayLogRequestGrayLogSystemInputsInputCreate {

    [String]$title
    [String]$type
    [Bool]$global
    [PSCustomObject]$configuration
    [String]$node

    GrayLogRequestGrayLogSystemInputsInputCreate() {}

    GrayLogRequestGrayLogSystemInputsInputCreate([String]$title,[String]$type,[Bool]$global,[PSCustomObject]$configuration,[String]$node) {
        $This.title = $title
        $This.type = $type
        $This.global = $global
        $This.configuration = $configuration
        $This.node = $node
    }
}

Class GrayLogRequestGrayLogSystemJobsTrigger {

    [String]$job_name

    GrayLogRequestGrayLogSystemJobsTrigger() {}

    GrayLogRequestGrayLogSystemJobsTrigger([String]$job_name) {
        $This.job_name = $job_name
    }
}

Class GrayLogRequestGrayLogSystemLdapLdapSettings {

    [Bool]$enabled
    [String]$system_username
    [String]$system_password
    [Bool]$system_password_set
    [String]$ldap_uri
    [Bool]$use_start_tls
    [Bool]$trust_all_certificates
    [Bool]$active_directory
    [String]$search_base
    [String]$search_pattern
    [String]$display_name_attribute
    [String]$default_group
    [String]$group_mapping
    [String]$group_search_base
    [String]$group_id_attribute
    [Array]$additional_default_groups
    [String]$group_search_pattern

    GrayLogRequestGrayLogSystemLdapLdapSettings() {}

    GrayLogRequestGrayLogSystemLdapLdapSettings([Bool]$enabled,[String]$system_username,[String]$system_password,[Bool]$system_password_set,[String]$ldap_uri,[Bool]$use_start_tls,[Bool]$trust_all_certificates,[Bool]$active_directory,[String]$search_base,[String]$search_pattern,[String]$display_name_attribute,[String]$default_group,[String]$group_mapping,[String]$group_search_base,[String]$group_id_attribute,[Array]$additional_default_groups,[String]$group_search_pattern) {
        $This.enabled = $enabled
        $This.system_username = $system_username
        $This.system_password = $system_password
        $This.system_password_set = $system_password_set
        $This.ldap_uri = $ldap_uri
        $This.use_start_tls = $use_start_tls
        $This.trust_all_certificates = $trust_all_certificates
        $This.active_directory = $active_directory
        $This.search_base = $search_base
        $This.search_pattern = $search_pattern
        $This.display_name_attribute = $display_name_attribute
        $This.default_group = $default_group
        $This.group_mapping = $group_mapping
        $This.group_search_base = $group_search_base
        $This.group_id_attribute = $group_id_attribute
        $This.additional_default_groups = $additional_default_groups
        $This.group_search_pattern = $group_search_pattern
    }
}

Class GrayLogRequestGrayLogSystemLdapLdapTestConfig {

    [String]$system_username
    [String]$system_password
    [String]$ldap_uri
    [Bool]$use_start_tls
    [Bool]$trust_all_certificates
    [Bool]$active_directory
    [String]$search_base
    [String]$search_pattern
    [String]$principal
    [String]$password
    [Bool]$test_connect_only
    [String]$group_search_base
    [String]$group_id_attribute
    [String]$group_search_pattern

    GrayLogRequestGrayLogSystemLdapLdapTestConfig() {}

    GrayLogRequestGrayLogSystemLdapLdapTestConfig([String]$system_username,[String]$system_password,[String]$ldap_uri,[Bool]$use_start_tls,[Bool]$trust_all_certificates,[Bool]$active_directory,[String]$search_base,[String]$search_pattern,[String]$principal,[String]$password,[Bool]$test_connect_only,[String]$group_search_base,[String]$group_id_attribute,[String]$group_search_pattern) {
        $This.system_username = $system_username
        $This.system_password = $system_password
        $This.ldap_uri = $ldap_uri
        $This.use_start_tls = $use_start_tls
        $This.trust_all_certificates = $trust_all_certificates
        $This.active_directory = $active_directory
        $This.search_base = $search_base
        $This.search_pattern = $search_pattern
        $This.principal = $principal
        $This.password = $password
        $This.test_connect_only = $test_connect_only
        $This.group_search_base = $group_search_base
        $This.group_id_attribute = $group_id_attribute
        $This.group_search_pattern = $group_search_pattern
    }
}

Class GrayLogRequestGrayLogSystemLookupErrorStates {

    [Array]$tables
    [Array]$data_adapters
    [Array]$caches

    GrayLogRequestGrayLogSystemLookupErrorStates() {}

    GrayLogRequestGrayLogSystemLookupErrorStates([Array]$tables,[Array]$data_adapters,[Array]$caches) {
        $This.tables = $tables
        $This.data_adapters = $data_adapters
        $This.caches = $caches
    }
}

Class GrayLogRequestGrayLogSystemMetricsMetricsRead {

    [Array]$metrics

    GrayLogRequestGrayLogSystemMetricsMetricsRead() {}

    GrayLogRequestGrayLogSystemMetricsMetricsRead([Array]$metrics) {
        $This.metrics = $metrics
    }
}

Class GrayLogRequestGrayLogSystemSessionsSessionCreate {

    [String]$username
    [String]$password
    [String]$host

    GrayLogRequestGrayLogSystemSessionsSessionCreate() {}

    GrayLogRequestGrayLogSystemSessionsSessionCreate([String]$username,[String]$password,[String]$host) {
        $This.username = $username
        $This.password = $password
        $This.host = $host
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesSearchCreateSavedSearch {

    [String]$title
    [PSCustomObject]$query

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesSearchCreateSavedSearch() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesSearchCreateSavedSearch([String]$title,[PSCustomObject]$query) {
        $This.title = $title
        $This.query = $query
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesStreamsCloneStream {

    [String]$title
    [String]$description
    [Bool]$remove_matches_from_default_stream
    [String]$index_set_id

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesStreamsCloneStream() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesStreamsCloneStream([String]$title,[String]$description,[Bool]$remove_matches_from_default_stream,[String]$index_set_id) {
        $This.title = $title
        $This.description = $description
        $This.remove_matches_from_default_stream = $remove_matches_from_default_stream
        $This.index_set_id = $index_set_id
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesStreamsCreateStream {

    [String]$title
    [String]$description
    [Array]$rules
    [String]$content_pack
    [String]$matching_type
    [Bool]$remove_matches_from_default_stream
    [String]$index_set_id

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesStreamsCreateStream() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesStreamsCreateStream([String]$title,[String]$description,[Array]$rules,[String]$content_pack,[String]$matching_type,[Bool]$remove_matches_from_default_stream,[String]$index_set_id) {
        $This.title = $title
        $This.description = $description
        $This.rules = $rules
        $This.content_pack = $content_pack
        $This.matching_type = $matching_type
        $This.remove_matches_from_default_stream = $remove_matches_from_default_stream
        $This.index_set_id = $index_set_id
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesStreamsRulesCreateStreamRule {

    [Int]$type
    [String]$value
    [String]$field
    [Bool]$inverted
    [String]$description

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesStreamsRulesCreateStreamRule() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesStreamsRulesCreateStreamRule([Int]$type,[String]$value,[String]$field,[Bool]$inverted,[String]$description) {
        $This.type = $type
        $This.value = $value
        $This.field = $field
        $This.inverted = $inverted
        $This.description = $description
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesSystemIndexerIndexSetUpdate {

    [String]$title
    [String]$description
    [Bool]$writable
    [Int]$shards
    [Int]$replicas
    [String]$rotation_strategy_class
    [String]$rotation_strategy
    [String]$retention_strategy_class
    [String]$retention_strategy
    [Int]$index_optimization_max_num_segments
    [Bool]$index_optimization_disabled
    [Int]$field_type_refresh_interval

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesSystemIndexerIndexSetUpdate() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylog2RestResourcesSystemIndexerIndexSetUpdate([String]$title,[String]$description,[Bool]$writable,[Int]$shards,[Int]$replicas,[String]$rotation_strategy_class,[String]$rotation_strategy,[String]$retention_strategy_class,[String]$retention_strategy,[Int]$index_optimization_max_num_segments,[Bool]$index_optimization_disabled,[Int]$field_type_refresh_interval) {
        $This.title = $title
        $This.description = $description
        $This.writable = $writable
        $This.shards = $shards
        $This.replicas = $replicas
        $This.rotation_strategy_class = $rotation_strategy_class
        $This.rotation_strategy = $rotation_strategy
        $This.retention_strategy_class = $retention_strategy_class
        $This.retention_strategy = $retention_strategy
        $This.index_optimization_max_num_segments = $index_optimization_max_num_segments
        $This.index_optimization_disabled = $index_optimization_disabled
        $This.field_type_refresh_interval = $field_type_refresh_interval
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsMapSearchMapDataSearch {

    [String]$query
    [String]$timerange
    [Int]$limit
    [Array]$fields
    [String]$stream_id

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsMapSearchMapDataSearch() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsMapSearchMapDataSearch([String]$query,[String]$timerange,[Int]$limit,[Array]$fields,[String]$stream_id) {
        $This.query = $query
        $This.timerange = $timerange
        $This.limit = $limit
        $This.fields = $fields
        $This.stream_id = $stream_id
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsPipelineprocessorRestBulkRule {

    [Array]$rules

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsPipelineprocessorRestBulkRule() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsPipelineprocessorRestBulkRule([Array]$rules) {
        $This.rules = $rules
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsPipelineprocessorRestSimulation {

    [String]$stream_id
    [PSCustomObject]$message
    [String]$input_id

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsPipelineprocessorRestSimulation() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsPipelineprocessorRestSimulation([String]$stream_id,[PSCustomObject]$message,[String]$input_id) {
        $This.stream_id = $stream_id
        $This.message = $message
        $This.input_id = $input_id
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestAdministration {

    [Int]$page
    [Int]$per_page
    [String]$query
    [String]$filters

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestAdministration() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestAdministration([Int]$page,[Int]$per_page,[String]$query,[String]$filters) {
        $This.page = $page
        $This.per_page = $per_page
        $This.query = $query
        $This.filters = $filters
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestBulkActions {

    [String]$action
    [Array]$collectors

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestBulkActions() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestBulkActions([String]$action,[Array]$collectors) {
        $This.action = $action
        $This.collectors = $collectors
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestConfigurationPreview {

    [String]$template

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestConfigurationPreview() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestConfigurationPreview([String]$template) {
        $This.template = $template
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestNodeConfiguration {

    [Array]$nodes

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestNodeConfiguration() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestNodeConfiguration([Array]$nodes) {
        $This.nodes = $nodes
    }
}

Class GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestRegistration {

    [String]$node_name
    [String]$node_details

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestRegistration() {}

    GrayLogRequestGrayLogUrnJsonschemaOrgGraylogPluginsSidecarRestRegistration([String]$node_name,[String]$node_details) {
        $This.node_name = $node_name
        $This.node_details = $node_details
    }
}

Class GrayLogRequestGrayLogUsersChangePassword {

    [String]$old_password
    [String]$password

    GrayLogRequestGrayLogUsersChangePassword() {}

    GrayLogRequestGrayLogUsersChangePassword([String]$old_password,[String]$password) {
        $This.old_password = $old_password
        $This.password = $password
    }
}

Class GrayLogRequestGrayLogUsersChangeUser {

    [String]$email
    [String]$full_name
    [Array]$permissions
    [String]$timezone
    [String]$startpage
    [Int]$session_timeout_ms
    [Array]$roles

    GrayLogRequestGrayLogUsersChangeUser() {}

    GrayLogRequestGrayLogUsersChangeUser([String]$email,[String]$full_name,[Array]$permissions,[String]$timezone,[String]$startpage,[Int]$session_timeout_ms,[Array]$roles) {
        $This.email = $email
        $This.full_name = $full_name
        $This.permissions = $permissions
        $This.timezone = $timezone
        $This.startpage = $startpage
        $This.session_timeout_ms = $session_timeout_ms
        $This.roles = $roles
    }
}

Class GrayLogRequestGrayLogUsersCreateUser {

    [String]$username
    [String]$password
    [String]$email
    [String]$full_name
    [Array]$permissions
    [String]$timezone
    [Int]$session_timeout_ms
    [String]$startpage
    [Array]$roles

    GrayLogRequestGrayLogUsersCreateUser() {}

    GrayLogRequestGrayLogUsersCreateUser([String]$username,[String]$password,[String]$email,[String]$full_name,[Array]$permissions,[String]$timezone,[Int]$session_timeout_ms,[String]$startpage,[Array]$roles) {
        $This.username = $username
        $This.password = $password
        $This.email = $email
        $This.full_name = $full_name
        $This.permissions = $permissions
        $This.timezone = $timezone
        $This.session_timeout_ms = $session_timeout_ms
        $This.startpage = $startpage
        $This.roles = $roles
    }
}

Class GrayLogRequestGrayLogUsersPermissionEdit {

    [Array]$permissions

    GrayLogRequestGrayLogUsersPermissionEdit() {}

    GrayLogRequestGrayLogUsersPermissionEdit([Array]$permissions) {
        $This.permissions = $permissions
    }
}

Class GrayLogRequestGrayLogUsersUpdateUserPreferences {

    [PSCustomObject]$preferences

    GrayLogRequestGrayLogUsersUpdateUserPreferences() {}

    GrayLogRequestGrayLogUsersUpdateUserPreferences([PSCustomObject]$preferences) {
        $This.preferences = $preferences
    }
}


