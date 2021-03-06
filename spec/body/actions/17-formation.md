# Military Formation

A player is able to select the military formation of a group of units.

## Definition

```ruby
def Formation
  int8 :command 
  int8 :selected_units_count
  int8 :player_id
  int8 :zero
  int32 :formation
  array :unit_ids, type: :int32, initial_length: :selected_units_count
end
```

## Description

*:command*  
The command identifier for the action attack will always be `0x17`.

*:selected_units_count*  
The number of selected units.

*:player_id*  
The player ID.

*:zero*  
Unused data.

*:formation*  
The [military formation](../../constants/formations.md) of the selected units. 

*:unit_ids*  
The ids of the selected units.

## Examples

>`12` &mdash; command  
>`02` &mdash; selected_units_count  
>`01 00` &mdash; player_id  
>`04 00 00 00` &mdash; box formation  
>`08 00 00 00` &mdash; unit_id  
>`09 00 00 00` &mdash; unit_id
