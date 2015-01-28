
-- BlockLoopSize version 4.0.0 by Syflom for Renoise

-- Functions

local rst = renoise.song().transport

function increase_coeff()
	if rst.loop_block_range_coeff ~= 16 then
		rst.loop_block_range_coeff = rst.loop_block_range_coeff + 1
	end
end

function decrease_coeff()
	if rst.loop_block_range_coeff ~= 2 then
		rst.loop_block_range_coeff = rst.loop_block_range_coeff - 1
	end
end

function double_coeff()
  if rst.loop_block_range_coeff <= 8 then
    rst.loop_block_range_coeff = rst.loop_block_range_coeff * 2
  end
end

function halve_coeff()
  if rst.loop_block_range_coeff >= 4 and ( rst.loop_block_range_coeff % 2 == 0 ) then
    rst.loop_block_range_coeff = rst.loop_block_range_coeff / 2
  end
end

-- MIDI Mapping

renoise.tool():add_midi_mapping{
  name = "Loop Block Size:Loop Block Size Increase [Trigger]",
  invoke = function(message)
    if (message:is_trigger()) then      
      increase_coeff()      
    end
  end
}

renoise.tool():add_midi_mapping{
  name = "Loop Block Size:Loop Block Size Decrease [Trigger]",
  invoke = function(message)
    if (message:is_trigger()) then      
      decrease_coeff()      
    end
  end
}

renoise.tool():add_midi_mapping{
  name = "Loop Block Size:Loop Block Size Double [Trigger]",
  invoke = function(message)
    if (message:is_trigger()) then      
      double_coeff()     
    end
  end
}

renoise.tool():add_midi_mapping{
  name = "Loop Block Size:Loop Block Size Halve [Trigger]",
  invoke = function(message)
    if (message:is_trigger()) then      
      halve_coeff()      
    end
  end
}

-- Key bindings

renoise.tool():add_keybinding {
  name = "Global:Transport:Loop Block Size Increase",
  invoke = function()
    increase_coeff() 
  end
}

renoise.tool():add_keybinding {
  name = "Global:Transport:Loop Block Size Decrease",
  invoke = function()
    decrease_coeff() 
  end
}

renoise.tool():add_keybinding {
  name = "Global:Transport:Loop Block Size Double",
  invoke = function()
    double_coeff()
  end
}

renoise.tool():add_keybinding {
  name = "Global:Transport:Loop Block Size Halve",
  invoke = function()
    halve_coeff()
  end
}

-- † --
