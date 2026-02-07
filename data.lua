--data.lua

local explosionEffect = table.deepcopy(data.raw.explosion["big-explosion"])

explosionEffect.name = "bomb-explosion"
explosionEffect.localised_name = { "entity-name.bomb-explosion" }
explosionEffect.icons = {
  { icon = "__base__/graphics/icons/explosion.png" },
}

local bomb = table.deepcopy(data.raw.item["explosives"])
bomb.name = "bomb"
bomb.icons = {
  {
  icon = bomb.icon,
  icon_size = bomb.icon_size,
  tint = {r = 0.5, g = 1, b = 0.5}
  }
}
bomb.stack_size = 1

local recipe = {
  type = "recipe",
  name = "bomb",
  enabled = true,
  energy_required = 8,
  ingredients = {
    {type = "item", name = "explosives", amount = 5},
    {type = "item", name = "electronic-circuit", amount = 1},
  },
  results = {
    {type = "item", name = "bomb", amount = 1},
  }
}

data:extend { explosionEffect, bomb, recipe }

data.raw.item["bomb"].spoil_ticks = 36000
data.raw.item["bomb"].spoil_to_trigger_result = {
  items_per_trigger = 1,
  trigger = {
    type = "direct",
    action_delivery = {
      type = "instant",
      target_effects = {
        {
          type = "create-explosion",
          entity_name = "bomb-explosion",
        },
        {
          type = "nested-result",
          action = {
            type = "area",
            radius = 4,
            target_entities = true,
            action_delivery = {
              type = "instant",
              target_effects = {
                {
                  type = "damage",
                  damage = {
                    amount = 250,
                    type = "explosion",
                  },
                  apply_damage_to_trees = true,
                }
              }
            }
          }
        }
      }
    }
  }
}
