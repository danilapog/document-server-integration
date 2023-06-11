#
# (c) Copyright Ascensio System SIA 2023
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
#

# frozen_string_literal: true
# typed: true

require 'uri'

class ConfigurationManager
  extend T::Sig

  sig { returns(String) }
  attr_reader :version

  sig { void }
  def initialize
    @version = '1.6.0'
  end

  sig { returns(T.nilable(URI::Generic)) }
  def example_uri
    url = ENV['EXAMPLE_URL']
    return nil if url.nil?
    URI(url)
  end

  sig { returns(URI::Generic) }
  def document_server_uri
    url = ENV['DOCUMENT_SERVER_URL'] || 'http://document-server/'
    URI(url)
  end

  sig { returns(URI::Generic) }
  def document_server_api_uri
    path =
      ENV['DOCUMENT_SERVER_API_PATH'] ||
      'web-apps/apps/api/documents/api.js'
    URI.join(document_server_uri, path)
  end

  sig { returns(URI::Generic) }
  def document_server_preloader_uri
    path =
      ENV['DOCUMENT_SERVER_PRELOADER_PATH'] ||
      'web-apps/apps/api/documents/cache-scripts.html'
    URI.join(document_server_uri, path)
  end

  sig { returns(URI::Generic) }
  def document_server_command_uri
    path =
      ENV['DOCUMENT_SERVER_COMMAND_PATH'] ||
      'coauthoring/CommandService.ashx'
    URI.join(document_server_uri, path)
  end

  sig { returns(URI::Generic) }
  def document_server_converter_uri
    path =
      ENV['DOCUMENT_SERVER_CONVERTER_PATH'] ||
      'ConvertService.ashx'
    URI.join(document_server_uri, path)
  end

  sig { returns(String) }
  def jwt_secret
    ENV['JWT_SECRET'] || ''
  end

  sig { returns(String) }
  def jwt_header
    ENV['JWT_HEADER'] || 'Authorization'
  end

  sig { returns(T::Boolean) }
  def jwt_use_for_request
    env = ENV['JWT_USE_FOR_REQUEST']
    return ActiveModel::Type::Boolean.new.cast(env) if env
    true
  end

  sig { returns(T::Boolean) }
  def ssl_verify_peer_mode_enabled
    env = ENV['SSL_VERIFY_PEER_MODE_ENABLED']
    return ActiveModel::Type::Boolean.new.cast(env) if env
    false
  end

  sig { returns(Pathname) }
  def storage_path
    storage_path = ENV['STORAGE_PATH'] || 'storage'
    storage_directory = Pathname(storage_path)
    return storage_directory if storage_directory.absolute?
    current_directory = Pathname(File.expand_path(__dir__))
    current_directory.join('..', storage_directory)
  end

  sig { returns(Numeric) }
  def maximum_file_size
    env = ENV['MAXIMUM_FILE_SIZE']
    return env.to_i if env
    5 * 1024 * 1024
  end

  sig { returns(Numeric) }
  def convertation_timeout
    120
  end

  sig { returns(T::Array[String]) }
  def fillable_file_extensions
    '.docx|.oform'
      .split('|')
  end

  sig { returns(T::Array[String]) }
  def viewable_file_extensions
    '.djvu|.oxps|.pdf|.xps'
      .split('|')
  end

  sig { returns(T::Array[String]) }
  def editable_file_extensions
    '.csv|.docm|.docx|.docxf|.dotm|.dotx|.epub|.fb2|.html|.odp|.ods|.odt|.otp|.ots|.ott|.potm|.potx|.ppsm|.ppsx|.pptm|.pptx|.rtf|.txt|.xlsm|.xlsx|.xltm|.xltx'
      .split('|')
  end

  sig { returns(T::Array[String]) }
  def convertable_file_extensions
    '.doc|.dot|.dps|.dpt|.epub|.et|.ett|.fb2|.fodp|.fods|.fodt|.htm|.html|.mht|.mhtml|.odp|.ods|.odt|.otp|.ots|.ott|.pot|.pps|.ppt|.rtf|.stw|.sxc|.sxi|.sxw|.wps|.wpt|.xls|.xlsb|.xlt|.xml'
      .split('|')
  end

  sig { returns(T::Hash[String, String]) }
  def languages
    {
      'en' => 'English',
      'hy' => 'Armenian',
      'az' => 'Azerbaijani',
      'eu' => 'Basque',
      'be' => 'Belarusian',
      'bg' => 'Bulgarian',
      'ca' => 'Catalan',
      'zh' => 'Chinese (Simplified)',
      'zh-TW' => 'Chinese (Traditional)',
      'cs' => 'Czech',
      'da' => 'Danish',
      'nl' => 'Dutch',
      'fi' => 'Finnish',
      'fr' => 'French',
      'gl' => 'Galego',
      'de' => 'German',
      'el' => 'Greek',
      'hu' => 'Hungarian',
      'id' => 'Indonesian',
      'it' => 'Italian',
      'ja' => 'Japanese',
      'ko' => 'Korean',
      'lo' => 'Lao',
      'lv' => 'Latvian',
      'ms' => 'Malay (Malaysia)',
      'no' => 'Norwegian',
      'pl' => 'Polish',
      'pt' => 'Portuguese (Brazil)',
      'pt-PT' => 'Portuguese (Portugal)',
      'ro' => 'Romanian',
      'ru' => 'Russian',
      'si' => 'Sinhala (Sri Lanka)',
      'sk' => 'Slovak',
      'sl' => 'Slovenian',
      'es' => 'Spanish',
      'sv' => 'Swedish',
      'tr' => 'Turkish',
      'uk' => 'Ukrainian',
      'vi' => 'Vietnamese',
      'aa-AA' => 'Test Language'
    }
  end
end
