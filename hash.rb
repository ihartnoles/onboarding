require 'digest/sha1'
require 'base64'

sha1 = Digest::SHA1.digest('12341234')
base64 = Base64.strict_encode64(sha1)

puts sha1
puts base64