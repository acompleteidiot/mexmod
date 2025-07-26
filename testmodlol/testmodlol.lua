---@diagnostic disable: undefined-global
SMODS.Atlas {
	--spritesheet
	key = "spr",
	px = 72,
	py = 96,
	path = "spritesheet.png"
}

--[[
hehe i made a silly little comment block for a basic joker example
also this is the part of the code with jokers HEHEHE
i gave up might do later lol
--]]

--[[
SMODS.Joker {
	key = 'cat',
	loc_txt = {
	name = 'cat'
}
	text = {
		"Gives {C:money}+$#1#{}, {C:chips}+#2# Chips{}, {C:mult}+#3# Mult{}, and {C:mult}x#4# Mult for each cat card."
	}
--]]
SMODS.Joker {
	key = 'testcat',
	loc_txt = {
		name = 'testcat',
		text = {
			"Gives 1 chip. Thats it.",
			"{C:inactive,s:0.6}'omg is that inspired by jen walter from hit balatro mod Jen's 'almanac' 'polterworx' Almanac, the one that youtubers frequently made videos about and personal favorite of the mod creator???????????'{}",
			"{C:inactive,s:0.6}(its not inspired by jen walter from hit balatro mod Jen's 'almanac' 'polterworx' Almanac, the one that youtubers frequently made videos about and personal favorite of the mod creator???????????){}"
		}
	},
	config = { extra = { chips = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	rarity = 1,
	blueprint_compat = true,
	atlas = 'spr',
	pos = { x = 0, y = 0 },
	cost = 0,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end
	end
}


SMODS.Joker {
	key = 'thousandyardstare',
	blueprint_compat = true,
	loc_txt = {
		name = 'the Thousand Yard Stare',
		text = {
			"{C:mult}+#1#{} Mult if it is your last hand with no discards left.",
			"{C:inactive}'O_O'{}"
		}
	},
	config = { extra = { mult = 50 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	rarity = 1,
	atlas = 'spr',
	pos = { x = 1, y = 0 },
	cost = 5,
	calculate = function(self, card, context)
		if context.joker_main then
			if G.GAME.current_round.hands_left == 0 and G.GAME.current_round.discards_left == 0 then
				return {
					mult = card.ability.extra.mult,
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'america',
	blueprint_compat = true,
	loc_txt = {
		name = 'America',
		text = {
			"Gains {C:mult}+#2#{} Mult every ante... and something else?",
			"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
			"{C:inactive, s:0.8}'He's on a journey! (bet you 10 bucks nobody gets this reference)'"
		}
	},
	config = { extra = { mult = 15, mult_gain = 15 } },
	rarity = 2,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
if context.end_of_round and context.main_eval and context.beat_boss and not context.blueprint then
  local ret = {{message = localize("k_upgrade_ex"), colour = G.C.MULT, card = card}}
  card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
  if next(SMODS.find_card("j_tmod_sweden")) then
    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
    ret[#ret+1] = {message = "Teamwork!", colour = G.C.CHIPS, card = card}
  end
  return SMODS.merge_effects(ret)
end
end
}

SMODS.Joker {
	key = 'sweden',
	blueprint_compat = true,
	loc_txt = {
		name = 'Sweden',
		text = {
			"Gains {C:chips}+#2#{} Chips every ante... and something else?",
			"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
			"{C:inactive, s:0.8}'Journeying with a friend! (bet you 10 bucks nobody gets this reference)'"
		}
	},
	config = { extra = { chips = 50, chips_gain = 50 } },
	rarity = 2,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end
if context.end_of_round and context.main_eval and context.beat_boss and not context.blueprint then
  local ret = {{message = localize("k_upgrade_ex"), colour = G.C.CHIPS, card = card}}
  card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
  if next(SMODS.find_card("j_tmod_america")) then
    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
    ret[#ret+1] = {message = "Teamwork!", colour = G.C.MULT, card = card}
  end
  return SMODS.merge_effects(ret)
end
end
}
