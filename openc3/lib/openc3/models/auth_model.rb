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

require 'digest'
require 'openc3/utilities/store'

module OpenC3
  class AuthModel
    PRIMARY_KEY = 'OPENC3__TOKEN'

    TOKEN_CACHE_TIMEOUT = 5
    @@token_cache = nil
    @@token_cache_time = nil

    def self.is_set?(key = PRIMARY_KEY)
      Store.exists(key) == 1
    end

    def self.verify(token, permission: nil)
      return false if token.nil? or token.empty?

      token_hash = hash(token)
      return true if @@token_cache and (Time.now - @@token_cache_time) < TOKEN_CACHE_TIMEOUT and @@token_cache == token_hash

      @@token_cache = Store.get(PRIMARY_KEY)
      @@token_cache_time = Time.now
      return true if @@token_cache == token_hash

      # Handle a service password - Generally only used by ScriptRunner
      service_password = ENV['OPENC3_SERVICE_PASSWORD']
      return true if service_password and service_password == token

      return false
    end

    def self.set(token, old_token, key = PRIMARY_KEY)
      raise "token must not be nil or empty" if token.nil? or token.empty?

      if is_set?(key)
        raise "old_token must not be nil or empty" if old_token.nil? or old_token.empty?
        raise "old_token incorrect" unless verify(old_token)
      end
      Store.set(key, hash(token))
    end

    def self.hash(token)
      Digest::SHA2.hexdigest token
    end
  end
end
