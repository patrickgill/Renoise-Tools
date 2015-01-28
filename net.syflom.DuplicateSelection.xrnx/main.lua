-- Duplicate -- 
-- A tool for duplicating the current selection in a pattern
-- Written by Patrick Gill (c) 2015

local rs = renoise.song()

local function set_edit_position(line)
  rs.transport.edit_pos = renoise.SongPos(rs.selected_sequence_index,line)
end

local function select_duplicate()
  local pattern_length = rs.selected_pattern.number_of_lines
  if rs.selection_in_pattern.end_line ~= pattern_length then
    local new_selection = rs.selection_in_pattern
    local height = new_selection.end_line - new_selection.start_line + 1

    new_selection.start_line = math.min(new_selection.start_line + height, pattern_length) -- to stop overflow
    new_selection.end_line = math.min(new_selection.end_line + height, pattern_length)
    rs.selection_in_pattern = new_selection
    
    set_edit_position(new_selection.start_line)
  end
end

local function insert_blank_lines(pos)
  
end

local function duplicate_selection(selection_in_pattern)
  local pattern_iter = rs.pattern_iterator
  local pattern_index = rs.selected_pattern_index
  local selection = selection_in_pattern
  
  for pos,line in pattern_iter:lines_in_pattern(pattern_index) do
    if pos.line >= selection.start_line and pos.line <= selection.end_line and pos.track >= selection.start_track and pos.track <= selection.end_track then -- restrict to selection
      local selection_height = selection.end_line - selection.start_line + 1
      
      if pos.line + selection_height <= renoise.Pattern.MAX_NUMBER_OF_LINES then -- don't copy past the line limit
        local destination_line = pos.line + selection_height
        
        for index, note_column in pairs(line.note_columns) do
            if note_column.is_selected then
              --note_column:clear()
              rs:pattern(pattern_index):track(pos.track):line(destination_line):note_column(index):copy_from(note_column)
            end
          end
        for index, effect_column in pairs(line.effect_columns) do
          if effect_column.is_selected then
            rs:pattern(pattern_index):track(pos.track):line(destination_line):effect_column(index):copy_from(effect_column)
            --effect_column:clear()
          end
        end
      end
    end
  end
end

local function duplicate()
  if rs.selection_in_pattern ~= nil then -- makes sure something is selected before attempting anything
    duplicate_selection(rs.selection_in_pattern)
    select_duplicate()
  end
end

renoise.tool():add_keybinding {
  name = "Pattern Editor:Selection:Duplicate Selection",
  invoke = function()
    duplicate()
  end
}

renoise.tool():add_menu_entry {
  name = "Pattern Editor:Selection:Duplicate Selection",
  invoke = function()
    duplicate()
  end
}

