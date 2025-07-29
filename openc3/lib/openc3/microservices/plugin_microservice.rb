# encoding: ascii-8bit

# Copyright 2022 Ball Aerospace & Technologies Corp.
# All Rights Reserved.
#
# This program is free software; you can modify and/or redistribute it
# under the terms of the GNU Affero General Public License
# as published by the Free Software Foundation; version 3 with
# attribution addendums as found in the LICENSE.txt
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# Modified by OpenC3, Inc.
# All changes Copyright 2022, OpenC3, Inc.
# All Rights Reserved
#
# This file may also be used under the terms of a commercial license
# if purchased from OpenC3, Inc.

require 'openc3/microservices/microservice'
require 'openc3/topics/topic'

module OpenC3
  class PluginMicroservice < Microservice
    def initialize(name)
      super(name, is_plugin: true)
    end

    def run
      Dir.chdir @work_dir
      begin
        if @config["cmd"][0] != 'ruby'
          # Try to make sure the cmd is executable
          FileUtils.chmod 0777, @config["cmd"][0]
        end
      rescue Exception
        # Its ok if this fails
      end

      # Fortify: Process Control
      # This is dangerous! However, plugins need to be able to run whatever they want.
      # Only admins can install plugins and they need to be vetted for content.
      # NOTE: In Enterprise each microservice gets its own container so the potential
      # footprint is much smaller. In Core you're in the same container
      # as all the other plugins.
      exec(*@config["cmd"])
    end
  end
end

OpenC3::PluginMicroservice.run if __FILE__ == $0
