--- STEAMODDED HEADER
--- MOD_NAME: Balatro Community Pack
--- MOD_ID: CommunityPack
--- MOD_AUTHOR: [GoldenEpsilon, elbe]
--- MOD_DESCRIPTION: Balatro Community Pack 
--- BADGE_COLOUR: C9A926
--- PREFIX: bcp

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas{
  key = "ultimace",
  path = "j_ultimace.png",
  px = 68,
  py = 91,
}
SMODS.Joker{
  key = "ultimace",
  config = {extra = {repetitions = 1}},
  pos = {x = 0, y = 0},
  rarity = 3,
  cost = 8,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "creator_revenge", set = "Other"}
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
}

SMODS.Atlas{
  key = "baba",
  path = "j_baba.png",
  px = 71,
  py = 95,
}
SMODS.Joker{
  key = "baba",
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
    info_queue[#info_queue+1] = {key = "creator_sairya", set = "Other"}
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
}

SMODS.Atlas{
  key = "missingtexture",
  path = "j_missingtexture.png",
  px = 71,
  py = 95,
}
SMODS.Joker{
  key = "missingtexture",
  config = {},
  pos = {x = 0, y = 0},
  rarity = 2,
  cost = 5,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "creator_revenge", set = "Other"}
    return {vars = {}}
  end,
  atlas = "missingtexture",
  unlocked = true,
  discovered = false,
  eternal_compat = true,
  blueprint_compat = true,
  perishable_compat = true,
}

SMODS.Atlas{
  key = "background",
  path = "j_background.png",
  px = 69,
  py = 93,
}
SMODS.Joker{
  key = "background",
  config = {},
  pos = {x = 0, y = 0},
  rarity = 2,
  cost = 5,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "creator_revenge", set = "Other"}
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
}

SMODS.Atlas{
  key = "inverted",
  path = "j_inverted.png",
  px = 69,
  py = 93,
}
SMODS.Joker{
  key = "inverted",
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
    info_queue[#info_queue+1] = {key = "creator_mysticsailbo", set = "Other"}
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
}

SMODS.Atlas{
  key = "freesample",
  path = "j_freesample.png",
  px = 69,
  py = 93,
}
SMODS.Joker{
  key = "freesample",
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
    info_queue[#info_queue+1] = {key = "creator_mysticsailbo", set = "Other"}
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
}

SMODS.Atlas{
  key = "notfound",
  path = "j_notfound.png",
  px = 69,
  py = 93,
}
SMODS.Joker{
  key = "notfound",
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
    info_queue[#info_queue+1] = {key = "creator_mysticsailbo", set = "Other"}
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
        card:juice_up(0.3, 0.5)
        hand_chips.array[1] = 404
    end
    end
  end,
}

SMODS.Atlas{
  key = "executioner",
  path = "j_executioner.png",
  px = 73,
  py = 96,
}
SMODS.Joker{
  key = "executioner",
  config = { extra = { hand = "High Card", active = 0 }},
  pos = {x = 0, y = 0},
  rarity = 3,
  cost = 8,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "creator_deepdawn", set = "Other"}
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
}

SMODS.Atlas{
  key = "passport",
  path = "j_passport.png",
  px = 69,
  py = 95,
}
SMODS.Joker{
  key = "passport",
  config = { },
  pos = {x = 0, y = 0},
  rarity = 3,
  cost = 8,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "creator_assassinchara", set = "Other"}
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
}

SMODS.Atlas{
  key = "stone_mask",
  path = "j_stone_mask.png",
  px = 73,
  py = 96,
}
SMODS.Joker{
  key = "stone_mask",
  config = { },
  pos = {x = 0, y = 0},
  rarity = 2,
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "creator_deepdawn", set = "Other"}
  end,
  atlas = "stone_mask",
  unlocked = true,
  discovered = false,
  eternal_compat = true,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card.ability.effect == "Stone Card" and not context.blueprint and context.other_card:get_edition() == nil then
      local edition = poll_edition('stone_mask', nil, true, true)
      context.other_card:set_edition(edition)
    end
  end,
}

SMODS.Atlas{
  key = "clown_pennywise",
  path = "j_pennywise.png",
  px = 73,
  py = 96,
}
SMODS.Joker{
  key = "clown_pennywise",
  config = { extra = { bonus = 2, mult = 2 } },
  pos = {x = 0, y = 0},
  rarity = 2,
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "creator_deepdawn", set = "Other"}
    return { vars = { card.ability.extra.bonus, card.ability.extra.mult }}
  end,
  atlas = "clown_pennywise",
  unlocked = true,
  discovered = false,
  eternal_compat = true,
  blueprint_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}},
      }
    end
    if context.individual and context.cardarea == G.play and not context.blueprint then
      if G.GAME.current_round.hands_played == 0 then
        if context.other_card:get_id() == 2 or
          context.other_card:get_id() == 3 or
          context.other_card:get_id() == 4 or
          context.other_card:get_id() == 5 then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.bonus
            context.other_card:start_dissolve()
        end
      end
    end
  end,
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

----- Suggestions ----
--[[
Card Mechanic
Jokers and playing cards cards cannot be destroyed
Uncommon

Starmapper Deck
Planet cards improve their respective hands by two levels instead of one

Bana-Nana Fruit
+300 Chips. 1 in 5000 chance this card is destroyed at the end of each round. (Only appears in shops if Cavendish was destroyed by its 1 in 1000 effect during this run)

Split
When a Glass card gets destroyed, add 2 copies of it to your deck. (1 in 4 chance to destroy this Joker when it gets triggered) 

Pear
Uncommon
Gains x0.5 mult per discard left at the end of round, resets after boss blind. 1  in 4 chance this card is destroyed at the end of each round
(Currently 1x mult) 

RNjoker
Uncommon
When this joker bought, create a random rare joker

Bluberries
Uncommon
Clubs give +Mult equal to 2x their rank when played. 1 in 4 chance this card is destroyed at the end of each round
(ex: 9 of clubs played gives 18 mult) 

Call-In Joker
Rare
Once per blind, when hand is played and this Joker is selected (click to select) , your hand counts as your most played one.

The Dunce
Common
Per card scored, 1 in 2 chance to destroy it and give 20 chips. 1 in 15 chance this is destroyed at end of round.

Sandwich (uncommon)
Calculate the joker score first and last. (Can only be used by 10 hands)
(In order as follows: Joker > play hands > held in hand > Joker)

This is a common joker called "help wanted"
Effect: all common jokers are forced to have  an addition, that being foil, etched, pallycrome or negative (the chance between the 4 reflects the differences between the normal chances)

Kaizo
Legendary
Each round, destroy all Jokers to it's right. Gain permament xMult equal sell cost of all of them.

Threshold
Rare
$9
A planet card of the least played card inherits the properties of the black hole.
(Current Planet: [insert planet]

Cherries
Uncommon
Hearts give +Mult equal to 2x their rank when played. in 4 chance this card is destroyed at the end of each round

Librarian
Uncommon
Create a tarot card if poker hand contains 3 scoring spades 
(Must have room) 

optical illusion (common)
x2 mult. hearts do not count in scoring. suit changes every round.
cost: $4
(i couldn't figure out how to put the 'joker' text on the sides of the card, so if someone could do that for me that would be great) 

Cursed Joker
Rare
$6
X3 Mult. Give a random scoring card "Cursed" Edition at the end of each round.

Transhumanism [Rare, $5]
If first discard of round is exactly one Heart card, make the card Steel

Hyperinflation [Rare, $1]
Double your money after cashing out
Lose all money when Blind is selected

Rhythm Joker (Common)
Each eighth card scored gives +50 chips 

Calling Card (Rare Joker. basically Jimbo but with Jonkler Persona 5's outfit (he looks just like me I swear))
When you play a card with only one scoring Heart, gain x1 mult. 

Brimstone (uncommon, $5)
x2 mult, every other hand played each round is debuffed
(note that your first hand for each blind is always not debuffed) 

Punk Joker (Uncommon, $5)
Every 3rd hand you play has every scoring card earn +16 more chips permanently.
Resets count if you play a Face Card. 

Name: Mirror Joker
Description: If played hand type is also held in hand, retrigger all played cards
Rarity/cost: Uncommon, 5/6 gold 

Card shark 
Uncommon
{$5)
Makes 5 random enhanced cards on beating the boss blind.

Wizard Tower
Uncommon (maybe rare idk)
$6-$8
Whenever you play a hand that isn't your most played poker hand, upgrade the level of one random poker hand

Ectospasm
Rare
$6
Gain +.3x mult for every negative joker. 

Thorned Tribute [Uncommon $6]
+1  Mult for Every Club Suit Discard 

(Submission) White Deck
-1 Joker Slot
+1 Consumable Slot, Hand and Discards

Abyss Deck (deck submission)
Level up all hands each ante. 
Level up your most played hand another time.
-1 Hand Size

Tourist Trap [Uncommon, $6]
You only skip the Shop when you skip a blind
(note: clearly placeholder art, someone please make a better one (if you want)) 


Lucky Sevens
<Uncommon>
$ 7
This joker gives +7 mult for every 3 cards that have a suit of seven
(Currently plus 5 mult)

Octo-Joker - Common. Give +10 chips for every 8 played, scoring or not. ($4)

Event Horizon - Rare. Each planet card upgrades 2 random other hands. ($8)

LowTierJoker - Uncommon. For each card destroyed, gain +2 mult. (Destroyed, not sold.)($6)

Life Lottery - Uncommon. Gain permament +17 mult for every hand with 3 scoring 7's. ($7)

PowDeathCake - Rare. Gain permament mult equal to lowest rank. ($7)

Serene Midnight - Uncommon. Each played clubs gains a permament +4 chips when played. ($5)

Name: Redprint (blueprints cousin joker) 
Rarity:Rare/legendary (most likely legendary)
 It doesn't blueprint  exactly what  the cards to the right of it. Instead it copy's all cards  multi (either times or addative) and turns it into more mult.... However when negative it turns it into chips .... Can't be blueprinted or copied by brainstorm  (note any cards to the left of it can't be copied)
(I used the art from the game and recoloured it, two varients)
value at sell: 7 coins 

Blue Java
Uncommon, $5
+200 chips. 1 in 8 chance to be destroyed each round.

Godori (Rare)
When Blind is completed, you may choose to continue playing the Blind.

Paint bucket 🪣 (rare)
Will change the poker hand being played by adding a "Flush". 
(Don't change a number of scoring card)
High card , pair , two pair , three of a kind >> Flush
Straight >> straight flush 
Full house >> Flush house
Five of a kind >> Flush five

Paper-mache (uncommon)
Will randomly choose a 1 joker to copy a skill (always choose skill that compatible)
It will change every time the Joker that copy is destroyed or at the end of the round.

Unbeatable
Rare, 7$
1 in 2 chance to discard any cards drawn below 7. (Spiteful Acrid gets credit for effect)

Rare (or even Legendary)
If a joker is destroyed, inherit it's properties.
(Priority: Chips, Mult, Multiplicative Mult, Econ, Effect/Misc)

Copycat
Uncommon
If first played hand contains 2 cards, randomly choose one to turn into the other (including ranks, suits, seals, enhancments, and editions) 

The Dealer
Uncommon
disables a random joker (changes every hand), X3 mult (can't disable itself, and the joker who got disabled on winning hand stays disabled until blind is chosen)

Pocket Joker (Rare)
At the end of the shop,
copy the ability of a
Joker in the shop
(changes each shop)

Name: Solitaire Joker
Effect: Straight Flushes can be made with alternating colors
Rarity: Rare
Cost: 7

My idea for "Fly Trap"  Uncommon, $6
Each round, it requires a different X rank card played to feed it. 
The multiplier grows 1x for each played+scored X card you feed it
Remove 1x multiplier if X rank card is discarded
If you don't feed the joker in a round it will eat a random joker to the left or right 



]]

----------------------------------------------
------------MOD CODE END----------------------