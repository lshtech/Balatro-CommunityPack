--- STEAMODDED HEADER
--- MOD_NAME: Balamod Community Pack
--- MOD_ID: CommunityPack
--- MOD_AUTHOR: [GoldenEpsilon, elbe]
--- MOD_DESCRIPTION: Balamod Community Pack 
--- BADGE_COLOUR: C9A926
--- PREFIX: bcp

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas({
  key = "baba",
  path = "j_baba.png",
  px = 71,
  py = 95,
})
SMODS.Atlas({
  key = "background",
  path = "j_background.png",
  px = 69,
  py = 93,
})
SMODS.Atlas({
  key = "executioner",
  path = "j_executioner.png",
  px = 73,
  py = 96,
})
SMODS.Atlas({
  key = "freesample",
  path = "j_freesample.png",
  px = 69,
  py = 93,
})
SMODS.Atlas({
  key = "inverted",
  path = "j_inverted.png",
  px = 69,
  py = 93,
})
SMODS.Atlas({
  key = "missingtexture",
  path = "j_missingtexture.png",
  px = 71,
  py = 95,
})
SMODS.Atlas({
  key = "notfound",
  path = "j_notfound.png",
  px = 69,
  py = 93,
})
SMODS.Atlas({
  key = "passport",
  path = "j_passport.png",
  px = 69,
  py = 95,
})
SMODS.Atlas({
  key = "ultimace",
  path = "j_ultimace.png",
  px = 68,
  py = 91,
})

SMODS.Joker{
  key = "ultimace",
  loc_txt = {
      name = "UltimAce",
      text = {
        "When an {C:attention}Enhanced Ace{} is scored,",
        "Retrigger it"
    }
  },
  config = {extra = {repetitions = 1}},
  pos = {x = 0, y = 0},
  rarity = 3,
  cost = 8,
  loc_vars = function(self, info_queue, card)
  return {vars = {}}
  end,
  atlas = "ultimace",
  unlocked = true,
  discovered = false,
  eternal_compat = true,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play then
      if context.other_card:get_id() == 14 and
        (context.other_card.ability.effect ~= "Base" or
        context.other_card.edition or
        context.other_card.seal) then
        return {
          message = 'Again!',
          repetitions = card.ability.extra.repetitions,
          card = card
        }
      end
    end
  end,
  set_sprites = function(self, card, front)
  end,
  set_ability = function(self, card, initial, delay_sprites)
  end,
  load = function(self, card, card_table, other_card)
  end
}
SMODS.Joker{
  key = "baba",
  loc_txt = {
      name = "Baba",
      text = {
        "Gives {X:red,C:white} X#1# {} Mult if played hand is a",
        "{C:attention}#2#{} or {C:attention}#3#{}"
    }
  },
  config = {
    extra = {
        x_mult = 3,
        type1 = "Pair",
        type2 = "High Card"
    }
},
  pos = {x = 0, y = 0},
  rarity = 3,
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return {vars = {
      card.ability.extra.x_mult,
      localize(card.ability.extra.type1, 'poker_hands'),
      localize(card.ability.extra.type2, 'poker_hands')
    }}
  end,
  atlas = "baba",
  unlocked = true,
  discovered = false,
  eternal_compat = true,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.poker_hands and (context.scoring_name == card.ability.extra.type1 or context.scoring_name == card.ability.extra.type2) then
      return {
          message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
          colour = G.C.RED,
          Xmult_mod = card.ability.extra.x_mult
      }
    end
  end,
  set_sprites = function(self, card, front)
  end,
  set_ability = function(self, card, initial, delay_sprites)
  end,
  load = function(self, card, card_table, other_card)
  end
}
SMODS.Joker{
  key = "missingtexture",
  loc_txt = {
      name = "Missing Texture",
      text = {
        "{C:attention}Two Pair{} counts as",
        "{C:attention}Four Of A Kind{}"
    }
  },
  config = {},
  pos = {x = 0, y = 0},
  rarity = 2,
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return {vars = {}}
  end,
  atlas = "missingtexture",
  unlocked = true,
  discovered = false,
  eternal_compat = true,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
  end,
  set_sprites = function(self, card, front)
  end,
  set_ability = function(self, card, initial, delay_sprites)
  end,
  load = function(self, card, card_table, other_card)
  end
}
SMODS.Joker{
  key = "background",
  loc_txt = {
      name = "Background",
      text = {
        "Give mult equal the square of",
        "the number of hands",
        "that can be made out of your scored cards"
    }
  },
  config = {},
  pos = {x = 0, y = 0},
  rarity = 2,
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return {vars = {}}
  end,
  atlas = "background",
  unlocked = true,
  discovered = false,
  eternal_compat = true,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local ret_val = -1;
      for _, v in pairs(context.poker_hands) do
          if next(v) then ret_val = ret_val + 1 end
      end
      if ret_val < 0 then ret_val = 0 end
      return {
          message = localize{type='variable',key='a_mult',vars={ret_val * ret_val}},
          mult_mod = ret_val * ret_val
      }
    end
  end,
  set_sprites = function(self, card, front)
  end,
  set_ability = function(self, card, initial, delay_sprites)
  end,
  load = function(self, card, card_table, other_card)
  end
}
SMODS.Joker{
  key = "inverted",
  loc_txt = {
      name = "Inverted Joker",
      text = {
        "After 3 rounds,",
        "sell this to gain ",
        "a free {C:attention}Negative Tag{}"
    }
  },
  config = {
      extra = {
        counter = 0,
        rounds = 3
      }
  },
  pos = {x = 0, y = 0},
  rarity = 3,
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return {vars = {}}
  end,
  atlas = "inverted",
  unlocked = true,
  discovered = false,
  eternal_compat = true,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition  and not context.blueprint then
      card.ability.extra.counter = card.ability.extra.counter + 1
      if card.ability.extra.counter >= card.ability.extra.rounds and (card.ability.extra.counter - 1) < card.ability.extra.rounds then
        local eval = function(card2) return not card2.REMOVED end
        juice_card_until(card, eval, true)
      end
      return {
        message = (card.ability.extra.counter < card.ability.extra.rounds) and (card.ability.extra.counter..'/'..card.ability.extra.rounds) or localize('k_active_ex'),
        colour = G.C.FILTER
      }
    end
    if context.selling_self and (card.ability.extra.counter >= card.ability.extra.rounds) and not context.blueprint then
      G.E_MANAGER:add_event(Event({
          func = (function()
              add_tag(Tag('tag_negative'))
              play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
              play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
              return true
          end)
      }))
    end
  end,
  set_sprites = function(self, card, front)
  end,
  set_ability = function(self, card, initial, delay_sprites)
  end,
  load = function(self, card, card_table, other_card)
  end
}
SMODS.Joker{
  key = "freesample",
  loc_txt = {
      name = "Free Sample",
      text = {
        "+1 hand if poker hand is a {C:attention}#1#{}",
        "Poker hand changes every hand"
    }
  },
  config = {
      extra = {
          hands = 1,
          poker_hand = "High Card"
      }
  },
  pos = {x = 0, y = 0},
  rarity = 1,
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return {vars = {localize(card.ability.extra.poker_hand, 'poker_hands')}}
  end,
  atlas = "freesample",
  unlocked = true,
  discovered = false,
  eternal_compat = true,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_name == card.ability.extra.poker_hand then
      G.E_MANAGER:add_event(Event({func = function()
          ease_hands_played(card.ability.extra.hands)
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_hands', vars = {card.ability.extra.hands}}})
      return true end }))

      local _poker_hands = {}
      for k, v in pairs(G.GAME.hands) do
          if v.visible then _poker_hands[#_poker_hands+1] = k end
      end
      local old_hand = card.ability.extra.poker_hand
      card.ability.extra.poker_hand  = nil

      while not card.ability.extra.poker_hand  do
        card.ability.extra.poker_hand  = pseudorandom_element(_poker_hands, pseudoseed((card.area and card.area.config.type == 'title') and 'false_freesample' or 'freesample'))
          if card.ability.extra.poker_hand  == old_hand then card.ability.extra.poker_hand  = nil end
      end
    end
  end,
  set_sprites = function(self, card, front)
  end,
  set_ability = function(self, card, initial, delay_sprites)
  end,
  load = function(self, card, card_table, other_card)
  end
}
SMODS.Joker{
  key = "notfound",
  loc_txt = {
      name = "Joker Not Found",
      text = {
        "{C:attention}#1#{} in {C:attention}#2#{} chance to add {C:chips}#3#{} chips" -- should be set chips to 404, but that's hard to do
    }
  },
  config = {
      extra = {
          chip_mod = 404,
          odds = 4
      }
  },
  pos = {x = 0, y = 0},
  rarity = 1,
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return {vars = {
      G.GAME.probabilities.normal,
      card.ability.extra.odds,
      card.ability.extra.chip_mod
    }}
  end,
  atlas = "notfound",
  unlocked = true,
  discovered = false,
  eternal_compat = true,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      if pseudorandom('notfound') < G.GAME.probabilities.normal/card.ability.extra.odds then
        return {
            message = localize{type='variable',key='a_chips',vars={card.ability.extra.chip_mod}},
            chip_mod = card.ability.extra.chip_mod,
        }
    end
    end
  end,
  set_sprites = function(self, card, front)
  end,
  set_ability = function(self, card, initial, delay_sprites)
  end,
  load = function(self, card, card_table, other_card)
  end
}
SMODS.Joker{
  key = "executioner",
  loc_txt = {
      name = "Executioner",
      text = {
        "If first played poker hand of the round is a {C:attention}#1#{},",
        "destroy all cards scored in it.",
        "Poker hand changes every round"
    }
  },
  config = { extra = { hand = "High Card", active = 0 }},
  pos = {x = 0, y = 0},
  rarity = 3,
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return {vars = {
      localize(card.ability.extra.hand, 'poker_hands')
    }}
  end,
  atlas = "executioner",
  unlocked = true,
  discovered = false,
  eternal_compat = true,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.end_of_round then
      local _poker_hands = {}
      for k, v in pairs(G.GAME.hands) do
          if v.visible then _poker_hands[#_poker_hands+1] = k end
      end
      local old_hand = card.ability.extra.hand
      card.ability.extra.hand = nil

      while not card.ability.extra.hand do
        card.ability.extra.hand = pseudorandom_element(_poker_hands, pseudoseed((card.area and card.area.config.type == 'title') and 'false_executioner' or 'executioner'))
          if card.ability.extra.hand == old_hand then card.ability.extra.hand = nil end
      end
    end
    if context.first_hand_drawn and not context.blueprint then
      card.ability.extra.active = true
      local eval = function() return G.GAME.current_round.hands_played == 0 end
      juice_card_until(card, eval, true)
    end
    if context.joker_main and G.GAME.current_round.hands_played == 0 and context.scoring_name == card.ability.extra.hand then
      if G.GAME.current_round.hands_played == 0 and context.scoring_name == card.ability.extra.hand  then
        local destroyed_cards = {}
        for i=1, #context.scoring_hand do
            destroyed_cards[#destroyed_cards + 1] = context.scoring_hand[i]
            if context.scoring_hand[i].ability.name == 'Glass Card' then
                context.scoring_hand[i]:shatter()
            else
                context.scoring_hand[i]:start_dissolve()
            end
        end
        if destroyed_cards[1] then
            for j=1, #G.jokers.cards do
                eval_card(G.jokers.cards[j], {cardarea = G.jokers, remove_playing_cards = true, removed = destroyed_cards})
            end
        end
        return
        {
            message = "Executed!",
            colour = G.C.FILTER,
            delay = 0.45,
            card = card
        }
    end
    end
  end,
  set_sprites = function(self, card, front)
  end,
  set_ability = function(self, card, initial, delay_sprites)
  end,
  load = function(self, card, card_table, other_card)
  end
}
SMODS.Joker{
  key = "passport",
  loc_txt = {
      name = "Passport Joker",
      text = {
        "gives benefits of joker to the right",
        "{C:attention}ignoring{} the condition",
        "{C:attention}#1#{}"
    }
  },
  config = { },
  pos = {x = 0, y = 0},
  rarity = 3,
  cost = 8,
  loc_vars = function(self, info_queue, card)
    local other_joker = nil
    if G.jokers then
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i+1] end
        end
        if other_joker and other_joker ~= card then
            if ((other_joker.ability.t_chips or other_joker.ability.t_mult or other_joker.ability.x_mult) or
            other_joker.ability.extra and (other_joker.extra.chip_mod or other_joker.extra.chips or other_joker.ability.extra.mult or other_joker.ability.extra.x_mult)) then
                return {vars ={other_joker.ability.name .. " is compatible"}}
            end
            return { vars = {other_joker.ability.name .. " is not compatible"}}
        end
    end
    return { vars = {""}}
  end,
  atlas = "passport",
  unlocked = true,
  discovered = false,
  eternal_compat = true,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers then
      if not context.before and not context.after then
        local other_joker = nil
        for i = 1, #G.jokers.cards do
          if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i+1] end
        end
        if other_joker and other_joker ~= card then
          local chips = 0;
          local mult = 0;
          local xmult = 1;
          if other_joker.ability.t_chips then
            chips = chips + other_joker.ability.t_chips;
          end
          if other_joker.ability.t_mult then
            mult = mult + other_joker.ability.t_mult;
          end
          if other_joker.ability.x_mult > 1 then
            xmult = other_joker.ability.x_mult;
          end
          if other_joker.ability.extra and other_joker.ability.extra.chip_mod then
            chips = chips + other_joker.ability.extra.chip_mod;
          end
          if other_joker.ability.extra and other_joker.ability.extra.chips then
            chips = chips + other_joker.ability.extra.chips;
          end
          if other_joker.ability.extra and other_joker.ability.extra.mult then
            mult = mult + other_joker.ability.extra.mult;
          end
          if other_joker.ability.extra and other_joker.ability.extra.x_mult then
            xmult = other_joker.ability.extra.x_mult;
          end
          if chips > 0 or mult > 0 or xmult > 0 then
            local message = "";
            if chips > 0 then
              message = tostring(localize{type='variable',key='a_chips',vars={chips}})
            else
              chips = 0
            end
            if mult > 0 then
              if message then
                message = message .. "\n"
              end
              message = message .. localize{type='variable',key='a_mult',vars={mult}}
            else
              mult = 0
            end
            if xmult > 1 then
              if message then
                message = message .. "\n"
              end
              message = message .. localize{type='variable',key='a_xmult',vars={xmult}}
            else
              xmult = 0
            end
            return {
              message = message,
              colour = G.C.RED,
              chip_mod = chips,
              mult_mod = mult,
              Xmult_mod = xmult
            }
          end
        end
      end
    end
  end,
  set_sprites = function(self, card, front)
  end,
  set_ability = function(self, card, initial, delay_sprites)
  end,
  load = function(self, card, card_table, other_card)
  end
}


local evaluate_poker_hand_ref = evaluate_poker_hand
function evaluate_poker_hand(hand)
  local ret = evaluate_poker_hand_ref(hand)
  if next(find_joker('j_bcp_missingtexture')) then
    if next(ret["Two Pair"]) then
      --ret["Two Pair"] = ret["Four of a Kind"]
      ret["Four of a Kind"] =  ret["Two Pair"]
    end
  end
  return ret
end



----------------------------------------------
------------MOD CODE END----------------------