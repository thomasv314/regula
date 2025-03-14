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
package rules.tf_aws_ebs_ebs_volume_encryption

import data.tests.rules.tf.aws.ebs.inputs.volume_encrypted_infra_json

test_ebs_ebs_volume_encryption {
  resources = volume_encrypted_infra_json.mock_resources
  allow with input as resources["aws_ebs_volume.good"]
  not allow with input as resources["aws_ebs_volume.missing"]
  not allow with input as resources["aws_ebs_volume.bad"]
}
