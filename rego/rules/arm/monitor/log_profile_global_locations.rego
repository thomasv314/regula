# Copyright 2021 Fugue, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package rules.arm_monitor_log_profile_global_locations

import data.fugue

__rego__metadoc__ := {
	"id": "FG_R00342",
	"title": "Monitor log profile should have activity logs for global services and all regions",
	"description": "Configure the log profile to export activities from all Azure supported regions/locations including global. This rule is evaluated against all resource locations that Fugue has permission to scan.",
	"custom": {
		"controls": {
			"CIS-Azure_v1.1.0": [
				"CIS-Azure_v1.1.0_5.1.4"
			],
		},
		"severity": "Medium"
	}
}

input_type = "arm"

resource_type = "MULTIPLE"

log_profiles = fugue.resources("Microsoft.Insights/logprofiles")

used_locations := {lower(l) |
	fugue.resource_types_v0[ty]
	r := fugue.resources(ty)
	l := r[_].location
}

required_locations := used_locations | {"global"}

invalid_profiles := {id: msg |
	profile := log_profiles[id]
	locs := {lower(l) | l = profile.properties.locations[_]}
	missing := required_locations - locs
	count(missing) > 0
	msg := sprintf(
		"The log profile is missing the following locations: %s",
		[concat(", ", missing)]
	)
}

policy[p] {
	profile := log_profiles[id]
	not invalid_profiles[id]
	p := fugue.allow({"resource": profile})
}

policy[p] {
	profile := log_profiles[id]
	msg := invalid_profiles[id]
	p := fugue.deny({"resource": profile, "message": msg})
}
