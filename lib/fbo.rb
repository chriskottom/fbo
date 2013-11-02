require 'fbo/version'

module FBO
  NOTICE_TYPES        = %w( presol combine amdcss mod award ja itb fairopp fstd ) +
                        %w( srcsgt snote ssale epsupload delete archive unarchive )
  NOTICE_TAG_NAMES    = NOTICE_TYPES.map { |name| name.upcase }
  NOTICE_CLOSE_REGEXP = /<\/(#{ NOTICE_TAG_NAMES.join('|') })>$/

end

require 'fbo/file'
require 'fbo/chunked_file'
require 'fbo/segmented_file'
require 'fbo/remote_file'
require 'fbo/parser'
require 'fbo/node_extensions'
require 'fbo/interpreter'

