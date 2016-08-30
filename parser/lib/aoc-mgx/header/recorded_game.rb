require_relative '../mgx_record'

require_relative 'map'
require_relative 'player_info'
require_relative 'trigger'
require_relative '../body/chat'

class RecordedGame < Mgx::Record
  stringz :game_version, :length => 8
  float :patch_version, :length => 4
  int32 :include_ai
  # TODO: skip ai if necessary
  skip :length => 4
  int32 :game_speed1
  skip :length => 4
  int32 :game_speed2
  skip :length => 29
  int16 :rec_owner
  int8 :player_count
  skip :length => 62
  int32 :map_size_x
  int32 :map_size_y
  int32 :unknown_num
  # TODO: skip :length => lambda {  (1275 + map_size_x * map_size_y  * 4 * num_float 6) *  unknown_num }
  # skip unknown  if necessary
  skip :length => 2
  #array :map_data, :type => :map, :read_until => lambda { index + 1 == map_size_x * map_size_y }
  skip :length => lambda { map_size_x * map_size_y * 2 }
  skip :length => 120
  int32 :map_size_x2
  int32 :map_size_y2
  skip :length => lambda { 4 * map_size_x2 * map_size_y2 }
  #skip :length => 15
  # player info
  #player_info = PlayerInfo.new(num_players: :player_count)
  #array :player_info, :type => player_info, :read_until => lambda { index + 1 == player_count }
  array :unused, :type => :int64, :read_until => lambda { element == '0x3FF999999999999A'.to_i(16) }
  skip :length => 1
  int32 :num_trigger
  array :trigger_info, :type => :trigger, :read_until => lambda { index + 1 == num_trigger }
  skip :length => lambda { num_trigger * 4 }

  array :team_indexes, :type => :int8, :read_until => lambda { index + 1 == 8 }
  skip :length => 1#, :onlyif => lambda { patch_version < 12.3 } # TODO really?
  skip :length => 18
  int32 :num_chat
  array :pregame_chat, :type => :chat, :read_until => lambda { index + 1 == num_chat }
end
