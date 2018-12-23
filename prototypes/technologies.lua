data:extend
{
  {
    type = "technology",
    name = "wireless-charging-induction",
    icon = "__wireless-charging-reborn__/graphics/technology/induction.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "wireless-charging-lo-power-induction-coil",
      },
      {
        type = "unlock-recipe",
        recipe = "wireless-charging-lo-power-induction-rail",
      },
      {
        type = "unlock-recipe",
        recipe = "wireless-charging-lo-power-induction-station",
      },
    },
    prerequisites = {"advanced-electronics-2", "electric-energy-distribution-1"},
    unit =
    {
      count = 150,
      ingredients = 
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
      },
      time = 40,
    },
    order = "c-e-d",
  },
  {
    type = "technology",
    name = "wireless-charging-high-power-induction",
    icon = "__wireless-charging-reborn__/graphics/technology/high-power-induction.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "wireless-charging-hi-power-induction-coil",
      },
      {
        type = "unlock-recipe",
        recipe = "wireless-charging-hi-power-induction-rail",
      },
      {
        type = "unlock-recipe",
        recipe = "wireless-charging-hi-power-induction-station",
      },
    },
    prerequisites = {"wireless-charging-induction", "electric-energy-distribution-2", "speed-module-2"},
    unit =
    {
      count = 200,
      ingredients = 
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
      },
      time = 60,
    },
    order = "c-e-e",
  },
}
