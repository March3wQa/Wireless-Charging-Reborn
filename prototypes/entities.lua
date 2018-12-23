local function make_rail(name, icon, mined, ...)
  local rail =
  {
    type = "straight-rail",
    name = name,
    icon = icon,
    icon_size = 32,
    collision_box = {{-0.7, -0.8}, {0.7, 0.8}},
    selection_box = {{-0.7, -0.8}, {0.7, 0.8}},
    flags = {"player-creation"},
    minable = mined and {mining_time = 0.5, result = mined},
    max_health = 250,
    corpse = "straight-rail-remnants",
    collision_mask = {"object-layer"},
    selectable_in_game = false,
    resistances =
    {
      {
        type = "fire",
        percent = 100
      }
    },
    rail_category = "regular",
    pictures = rail_pictures(),
  }
  for i = 1, select("#", ...) do
    local image = select(i, ...)
    local picture = rail.pictures["straight_rail_" .. image[1]][image[2]]
    picture.filename = image[3]
  end
  return rail
end

local function induction_station_circuit_connector_sprite()
  local dx = 0.71875
  local dy = -0.28125
  local sprite = table.deepcopy(data.raw.inserter["inserter"].circuit_connector_sprites)
  for k, v in pairs(sprite) do
    if(v.shift) then
      v.shift[1] = v.shift[1] + dx
      v.shift[2] = v.shift[2] + dy
    end
  end
  light_def =
  {
    type = "basic",
    intensity = 0.5,
    size = 10
  }
  sprite.blue_led_light_offset = {0, 0}
  sprite.red_green_led_light_offset = {0, 0}
  sprite.blue_led_light_offset[1] = sprite.blue_led_light_offset[1] + dx
  sprite.blue_led_light_offset[2] = sprite.blue_led_light_offset[2] + dy
  sprite.red_green_led_light_offset[1] = sprite.red_green_led_light_offset[1] + dx
  sprite.red_green_led_light_offset[2] = sprite.red_green_led_light_offset[2] + dy
  sprite.led_red = universal_connector_template.led_red
  sprite.led_green = universal_connector_template.led_green
  sprite.led_blue = universal_connector_template.led_blue
  sprite.led_light = light_def
  return sprite
end

local function induction_rail_circuit_connector_sprite(orientation)
  local dx, dy
  if(orientation == "horizontal") then
    dx = 0.9375
    dy = 0.75
  else
    dx = 1.0625
    dy = -0.03125
  end
  local sprite = table.deepcopy(data.raw.inserter["inserter"].circuit_connector_sprites)
  for k, v in pairs(sprite) do
    if(v.shift) then
      v.shift[1] = v.shift[1] + dx
      v.shift[2] = v.shift[2] + dy
    end
  end
  light_def =
  {
    type = "basic",
    intensity = 0.5,
    size = 10
  }
  sprite.blue_led_light_offset = {0, 0}
  sprite.red_green_led_light_offset = {0, 0}
  sprite.blue_led_light_offset[1] = sprite.blue_led_light_offset[1] + dx
  sprite.blue_led_light_offset[2] = sprite.blue_led_light_offset[2] + dy
  sprite.red_green_led_light_offset[1] = sprite.red_green_led_light_offset[1] + dx
  sprite.red_green_led_light_offset[2] = sprite.red_green_led_light_offset[2] + dy
  sprite.led_red = universal_connector_template.led_red
  sprite.led_green = universal_connector_template.led_green
  sprite.led_blue = universal_connector_template.led_blue
  sprite.led_light = light_def
  return sprite
end

local function make_station(name, icon, type, filename)
  -- local health = 0
  -- if type == "hi" then
  --   health = 300
  -- elseif type == "lo" then
  --   health = 200
  -- end
  return {
    type = "electric-energy-interface",
    name = name,
    icon = icon,
    icon_size = 32,
    collision_box = {{-1.3, -0.3}, {1.3, 2.3}},
    selection_box = {{-1.5, -0.5}, {1.5, 2.5}},
    flags = {"player-creation", "not-blueprintable", "not-deconstructable"},
    minable = {hardness = 0.1, mining_time = 0.1, result = name},
    -- max_health = health,
    max_health = 300,
    corpse = "medium-remnants",
    collision_mask = {"object-layer"},
    energy_source =
    {
      type = "electric",
      buffer_capacity = "100J",
      usage_priority = "terciary",
      input_flow_limit = "0W",
      output_flow_limit = "0W"
    },
    charge_cooldown = 30,
    discharge_cooldown = 60,
    picture =
    {
      filename = filename,
      priority = "low",
      width = 96,
      height = 96,
      shift = {0, 1},
    },
    circuit_wire_connection_point =
    {
      shadow =
      {
        red = {0.375, -0.21875},
        green = {0.375, -0.21875},
      },
      wire =
      {
        red = {0.375, -0.21875},
        green = {0.375, -0.21875},
      }
    },
    circuit_connector_sprites = induction_station_circuit_connector_sprite(),
    circuit_wire_max_distance = 7.5,
    default_output_signal = {type = "virtual", name = "signal-A"}
  }
end

local function make_rail_accumulator(orientation, name, icon, type, filename)
  local circuit_x = orientation == "horizontal" and 0.65625 or 0.6875
  local circuit_y = orientation == "horizontal" and 0.8125 or 0.0625
  -- local health = 0
  -- if type == "hi" then
  --   health = 300
  -- elseif type == "lo" then
  --   health = 200
  -- end
  return {
    type = "accumulator",
    name = name .. "-" .. orientation,
    icon = icon,
    icon_size = 32,
    localised_name = {"entity-name." .. name},
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = orientation == "horizontal" and {{-1, -0.9}, {1, 0.9}} or {{-0.9, -1}, {0.9, 1}},
    flags = {"player-creation", "not-blueprintable", "not-deconstructable"},
    minable = {mining_time = 0.5, result = name},
    -- max_health = health,
    max_health = 300,
    corpse = "straight-rail-remnants",
    collision_mask = {},
    energy_source =
    {
      type = "electric",
      buffer_capacity = "100J",
      usage_priority = "terciary",
      input_flow_limit = "0W",
      output_flow_limit = "0W"
    },
    charge_cooldown = 30,
    discharge_cooldown = 60,
    picture =
    {
      filename = filename,
      priority = "extra-high",
      width = 64,
      height = 64,
    },
    circuit_wire_connection_point =
    {
      shadow =
      {
        red = {circuit_x, circuit_y},
        green = {circuit_x, circuit_y},
      },
      wire =
      {
        red = {circuit_x, circuit_y},
        green = {circuit_x, circuit_y},
      }
    },
    circuit_connector_sprites = induction_rail_circuit_connector_sprite(orientation),
    circuit_wire_max_distance = 7.5,
    default_output_signal = {type = "virtual", name = "signal-A"}
  }
end

data:extend
{
  make_rail("wireless-charging-lo-power-induction-rail",
            "__wireless-charging-reborn__/graphics/icons/lo-power-induction-rail.png",
            "wireless-charging-lo-power-induction-rail",
            {"horizontal", "backplates", string.format("__wireless-charging-reborn__/graphics/entities/%s-power-induction-rail-%s-%s.png", "lo", "horizontal", "backplates")},
            {"vertical",   "backplates", string.format("__wireless-charging-reborn__/graphics/entities/%s-power-induction-rail-%s-%s.png", "lo", "vertical", "backplates")},
            {"horizontal", "ties",       "__wireless-charging-reborn__/graphics/entities/induction-rail-horizontal-ties.png"},
            {"vertical",   "ties",       "__wireless-charging-reborn__/graphics/entities/induction-rail-vertical-ties.png"}),
  make_rail("wireless-charging-hi-power-induction-rail",
            "__wireless-charging-reborn__/graphics/icons/hi-power-induction-rail.png",
            "wireless-charging-hi-power-induction-rail",
            {"horizontal", "backplates", string.format("__wireless-charging-reborn__/graphics/entities/%s-power-induction-rail-%s-%s.png", "hi", "horizontal", "backplates")},
            {"vertical",   "backplates", string.format("__wireless-charging-reborn__/graphics/entities/%s-power-induction-rail-%s-%s.png", "hi", "vertical", "backplates")},
            {"horizontal", "ties",       "__wireless-charging-reborn__/graphics/entities/induction-rail-horizontal-ties.png"},
            {"vertical",   "ties",       "__wireless-charging-reborn__/graphics/entities/induction-rail-vertical-ties.png"}),
  make_station("wireless-charging-lo-power-induction-station",
               "__wireless-charging-reborn__/graphics/icons/lo-power-induction-station.png",
               "lo",
               "__wireless-charging-reborn__/graphics/entities/lo-power-induction-station.png"),
  make_station("wireless-charging-hi-power-induction-station",
               "__wireless-charging-reborn__/graphics/icons/hi-power-induction-station.png",
               "hi",
               "__wireless-charging-reborn__/graphics/entities/hi-power-induction-station.png"),
  make_rail_accumulator("horizontal",
                        "wireless-charging-lo-power-induction-rail",
                        "__wireless-charging-reborn__/graphics/icons/lo-power-induction-rail.png",
                        "lo",
                        "__wireless-charging-reborn__/graphics/entities/empty64.png"),
  make_rail_accumulator("vertical",
                        "wireless-charging-lo-power-induction-rail",
                        "__wireless-charging-reborn__/graphics/icons/lo-power-induction-rail.png",
                        "lo",
                        "__wireless-charging-reborn__/graphics/entities/empty64.png"),
  make_rail_accumulator("horizontal",
                        "wireless-charging-hi-power-induction-rail",
                        "__wireless-charging-reborn__/graphics/icons/hi-power-induction-rail.png",
                        "hi",
                        "__wireless-charging-reborn__/graphics/entities/empty64.png"),
  make_rail_accumulator("vertical",
                        "wireless-charging-hi-power-induction-rail",
                        "__wireless-charging-reborn__/graphics/icons/hi-power-induction-rail.png",
                        "hi",
                        "__wireless-charging-reborn__/graphics/entities/empty64.png"),
  {
    type = "storage-tank",
    name = "wireless-charging-induction-station-indicator",
    icon = ENERGY_PLACEHOLDER_ICON,
    flags = {"not-blueprintable", "not-deconstructable", "not-on-map", "placeable-off-grid"},
    max_health = 250,
    collision_mask = {},
    window_bounding_box = {{0, 0}, {0.09375, 0.40625}},
    flow_length_in_ticks = 360,
    fluid_box =
    {
      base_area = 10,
      pipe_connections = { },
    },
    pictures =
    {
      picture =
      {
        sheet =
        {
          filename = "__core__/graphics/empty.png",
          priority = "low",
          width = 1,
          height = 1,
          frames = 1,
         },
      },
      window_background =
      {
        filename = "__wireless-charging-reborn__/graphics/entities/induction-station-window-background.png",
        priority = "low",
        width = 3,
        height = 11,
      },
      fluid_background =
      {
        filename = "__wireless-charging-reborn__/graphics/entities/induction-station-fluid-background.png",
        priority = "low",
        width = 3,
        height = 11,
      },
      flow_sprite =
      {
        filename = "__wireless-charging-reborn__/graphics/entities/induction-station-fluid-flow.png",
        priority = "low",
        width = 160,
        height = 3,
      },
      gas_flow = table.deepcopy(data.raw.pipe["pipe"].pictures.gas_flow)
    },
  },
}
