# Copyright 2020 Fugue, Inc.
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

# This is a larger test case that mocks the whole `data.rules` tree as well
# as the `input`.
package fugue.regula_report_01_test

import data.fugue.regula
import data.tests.lib.inputs.volume_encrypted_infra_json

# We reuse the mock input from another test case.
mock_config = volume_encrypted_infra_json.mock_config

# We construct some mock rules as well.
mock_rules = {
  "always_pass": {
    "__rego__metadoc__": {
      "custom": {
        "controls": {
          "MOCK": ["MOCK_1.2.3"]
        },
        "severity": "hIgH",
        "rule_remediation_doc": "https://example.com"
      },
      "id": "FG_R00001",
      "title": "Always pass",
      "description": "This rule always passes"
    },
    "resource_type": "aws_ebs_volume",
    "allow": true
  },
  "always_fail": {
    "resource_type": "aws_ebs_volume",
    "deny": true
  }
}

# Produce a report.
report = ret {
  ret = regula.report with input as mock_config with data.rules as mock_rules
}

contains_result(arr, result) {
  r = arr[_]
  result == r
}

# Test the report.
test_report {
  count(expected_report.rule_results) == count(report.rule_results)
  count([c | r = expected_report.rule_results[_]; c = contains_result(report.rule_results, r)]) == count(report.rule_results)
  expected_report.summary == report.summary
}

expected_report = {
  "rule_results": [
    {
      "provider": "aws",
      "resource_id": "aws_ebs_volume.good",
      "resource_type": "aws_ebs_volume",
      "rule_message": "",
      "rule_result": "PASS",
      "rule_name": "always_pass",
      "input_type": "tf_plan",
      "rule_id": "FG_R00001",
      "rule_summary": "Always pass",
      "rule_description": "This rule always passes",
      "rule_severity": "High",
      "rule_remediation_doc": "https://example.com",
      "controls": {"MOCK_1.2.3"},
      "families": {"MOCK"},
      "filepath": "",
      "rule_raw_result": true
    },
    {
      "provider": "aws",
      "resource_id": "aws_ebs_volume.missing",
      "resource_type": "aws_ebs_volume",
      "rule_message": "",
      "rule_result": "PASS",
      "rule_name": "always_pass",
      "input_type": "tf_plan",
      "rule_id": "FG_R00001",
      "rule_summary": "Always pass",
      "rule_description": "This rule always passes",
      "rule_severity": "High",
      "rule_remediation_doc": "https://example.com",
      "controls": {"MOCK_1.2.3"},
      "families": {"MOCK"},
      "filepath": "",
      "rule_raw_result": true
    },
    {
      "provider": "aws",
      "resource_id": "aws_ebs_volume.bad",
      "resource_type": "aws_ebs_volume",
      "rule_message": "",
      "rule_result": "PASS",
      "rule_name": "always_pass",
      "input_type": "tf_plan",
      "rule_id": "FG_R00001",
      "rule_summary": "Always pass",
      "rule_description": "This rule always passes",
      "rule_severity": "High",
      "rule_remediation_doc": "https://example.com",
      "controls": {"MOCK_1.2.3"},
      "families": {"MOCK"},
      "filepath": "",
      "rule_raw_result": true
    },
    {
      "provider": "aws",
      "resource_id": "aws_ebs_volume.good",
      "resource_type": "aws_ebs_volume",
      "rule_message": "",
      "rule_result": "FAIL",
      "rule_name": "always_fail",
      "input_type": "tf_plan",
      "rule_id": "",
      "rule_summary": "",
      "rule_description": "",
      "rule_severity": "Unknown",
      "rule_remediation_doc": "",
      "controls": set(),
      "families": set(),
      "filepath": "",
      "rule_raw_result": false
    },
    {
      "provider": "aws",
      "resource_id": "aws_ebs_volume.missing",
      "resource_type": "aws_ebs_volume",
      "rule_message": "",
      "rule_result": "FAIL",
      "rule_name": "always_fail",
      "input_type": "tf_plan",
      "rule_id": "",
      "rule_summary": "",
      "rule_description": "",
      "rule_severity": "Unknown",
      "rule_remediation_doc": "",
      "controls": set(),
      "families": set(),
      "filepath": "",
      "rule_raw_result": false
    },
    {
      "provider": "aws",
      "resource_id": "aws_ebs_volume.bad",
      "resource_type": "aws_ebs_volume",
      "rule_message": "",
      "rule_result": "FAIL",
      "rule_name": "always_fail",
      "input_type": "tf_plan",
      "rule_id": "",
      "rule_summary": "",
      "rule_description": "",
      "rule_severity": "Unknown",
      "rule_remediation_doc": "",
      "controls": set(),
      "families": set(),
      "filepath": "",
      "rule_raw_result": false
    }
  ],
  "summary": {
    "filepaths": [""],
    "rule_results": {
      "PASS": 3,
      "FAIL": 3,
      "WAIVED": 0
    },
    "severities": {
      "Critical": 0,
      "High": 0,
      "Medium": 0,
      "Low": 0,
      "Informational": 0,
      "Unknown": 3,
    }
  }
}
