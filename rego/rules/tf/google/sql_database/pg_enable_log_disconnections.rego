# Copyright 2020-2021 Fugue, Inc.
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
package rules.tf_google_sql_database_pg_enable_log_disconnections

import data.fugue
import data.google.sql_database.sql_database_library as lib


__rego__metadoc__ := {
  "custom": {
    "controls": {
      "CIS-Google_v1.1.0": [
        "CIS-Google_v1.1.0_6.2.3"
      ],
      "CIS-Google_v1.2.0": [
        "CIS-Google_v1.2.0_6.2.4"
      ]
    },
    "severity": "Medium"
  },
  "description": "PostgreSQL database instance 'log_disconnections' database flag should be set to 'on'. The PostgreSQL database instance flag 'log_disconnections' causes session terminations to be logged. This data is useful for troubleshooting and identifying unusual activity. This flag and the 'log_connections' flag are typically used together.",
  "id": "FG_R00426",
  "title": "PostgreSQL database instance 'log_disconnections' database flag should be set to 'on'"
}

resource_type = "MULTIPLE"

valid_db_instances[id] {
  db = lib.postgres_database_instances[id]
  flag := lib.get_db_flag_with_default(db, "log_disconnections", "off")
  flag == "on"
}

policy[j] {
  db = lib.postgres_database_instances[id]
  valid_db_instances[id]
  j = fugue.allow_resource(db)
}

policy[j] {
  db = lib.postgres_database_instances[id]
  not valid_db_instances[id]
  j = fugue.deny_resource(db)
}

