---@diagnostic disable: undefined-global
SMODS.Atlas {
	--spritesheet
	key = "spr",
	px = 73,
	py = 97,
	path = "spritesheet.png"
}

SMODS.Atlas {
	--for consumables
	key = "consumables",
	px = 75,
	py = 99,
	-- spritesheet is a placeholder, im gonna make a new spritesheet for consumnbables
	path = "consumables.png"
}

--[[
hehe i made a silly little comment block for a basic joker example
also this is the part of the code with jokers HEHEHE
i gave up might do later lol
ITS BEEN HOURS
maybe later
maybe its not gonna happen
herobrine
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
	pools = {
		["cat_shop"] = true,
		["cat"] = true
	},
	blueprint_compat = true,
	atlas = 'spr',
	pos = { x = 9, y = 0 },
	cost = 1,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end
	end
}

SMODS.Joker {
	key = 'catner',
	blueprint_compat = true,
	loc_txt = {
		name = 'catner',
		text = {
			"Gives {C:money}+$1{}, {C:chips}+20 Chips{},",
			"{C:mult}+15 Mult{}, and {C:mult}+x0.2 Mult{}",
			"for each cat joker.",
			"{C:inactive}Currently #1# cats.",
			"{C:inactive, s:0.8}' 'catner catner catner; catns the amount of catners that catn catners in this encatner' when'"
		}
	},
	cost = 5,
	rarity = "cry_epic",
	pools = {
		["cat_shop"] = true,
		["cat"] = true
	},
	atlas = 'spr',
	pos = { x = 3, y = 0, },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cats } }
	end,
	config = { extra = { cats = 0 } },
	calculate = function(self, card, context)
		if context.joker_main then
			local catcount = 0
			for _, J in ipairs(G.jokers.cards) do
				if J.config.center.pools and J.config.center.pools.cat then
					catcount = catcount + 1
				end
			end
			card.ability.extra.cats = catcount
			return {
				dollars = catcount,
				chips = catcount * 20,
				mult = catcount * 15,
				xmult = (catcount / 5) + 1
			}
		end
	end
}

SMODS.Joker {
	key = 'kat',
	loc_txt = {
		name = 'cat.',
		text = {
			"I am cat. I am cat. I am cat card. I am only cat.",
			"does NOT give {C:mult}+4 mult{}, trust me",
			"{C:inactive}'help im stuck getting tons of cat. jokers from my box of cats'"
		}
	},
	atlas = 'spr',
	pos = { x = 2, y = 0 },
	cost = 3,
	rarity = 1,
	pools = {
		["cat"] = true,
		["cat_shop"] = true
	},
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
	pos = { x = 10, y = 0 },
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
	config = { extra = { mult = 15, mult_gain = 7.5 } },
	rarity = 3,
	atlas = 'spr',
	pos = { x = 0, y = 0 },
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
			local ret = { { message = localize("k_upgrade_ex"), colour = G.C.MULT, card = card } }
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			if next(SMODS.find_card("j_mexmod_sweden")) then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
				ret[#ret + 1] = { message = "Teamwork!", colour = G.C.CHIPS, card = card }
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
	config = { extra = { chips = 30, chips_gain = 15 } },
	rarity = 3,
	atlas = 'spr',
	pos = { x = 8, y = 0 },
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
			local ret = { { message = localize("k_upgrade_ex"), colour = G.C.CHIPS, card = card } }
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
			if next(SMODS.find_card("j_mexmod_america")) then
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
				ret[#ret + 1] = { message = "Teamwork!", colour = G.C.MULT, card = card }
			end
			return SMODS.merge_effects(ret)
		end
	end
}



SMODS.Joker {
	key = 'burger',
	blueprint_compat = true,
	loc_txt = {
		name = 'burger',
		text = {
			"{C:mult}+4 mult",
			"{C:inactive}'loft likes eating these'"
		}
	},
	rarity = 1,
	config = { extra = { mult = 4 } },
	atlas = 'spr',
	pos = { x = 1, y = 0 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}

SMODS.Joker {
	key = 'eepy',
	blueprint_compat = true,
	loc_txt = {
		name = 'eepy cat',

		text = {
			"Sleeps for 3 antes, then gives  {C:chips}+300 Chips{}.",
			"#2#/3 Antes",
			"{C:inactive}#4#",
			"{C:inactive}'can this little goober WAKE UP ALREADY??????'"
		}
	},
	rarity = 2,
	config = { extra = { chips = 300, antes = 0, antesup = 1 } },
	atlas = 'spr',
	pos = { x = 6, y = 0 },
	pools = {
		["cat"] = true,
		["cat_shop"] = true
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.antes, card.ability.extra.antesup, (card.ability.extra.antes >= 3 and "Active!") or "Inactive!" } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.antes == 3 then
			return {
				chips = card.ability.extra.chips
			}
		end
		if context.end_of_round and context.main_eval and context.beat_boss and not context.blueprint and card.ability.extra.antes ~= 3 then
			card.ability.extra.antes = card.ability.extra.antes + card.ability.extra.antesup
			return {
				message = 'uneepying...',
				colour = G.C.CHIPS,
				card = card
			}
		end
	end
}

SMODS.Joker {
	key = 'hotdog',
	blueprint_compat = true,
	loc_txt = {
		name = 'hotdog',
		text = {
			"{C:chips}+40 chips",
			"{C:inactive}'woft likes eating these'"
		}
	},
	rarity = 1,
	config = { extra = { chips = 40 } },
	atlas = 'spr',
	pos = { x = 7, y = 0 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
	end
}

SMODS.Joker {
	key = 'catofboxes',
	blueprint_compat = true,
	loc_txt = {
		name = 'Cat of Boxes',
		text = {
			"Generates 1 free, {C:dark_edition}Negative{} Box of Cats at end of round.",
			"Also gives 1 joker slot for every cat card, excluding this one.",
			"{C:inactive}'lol thats alot of cats'",
			"{C:inactive} ART BY Astro IN THE BALATRO DISCORD"
		}
	},
	rarity = 4,
	atlas = 'spr',
	pos = { x = 4, y = 0 },
	soul_pos = { x = 5, y = 0 },
	config = { extra = { acard_limit = 0, acard_limit_old = 0 } },
	pools = {
		["cat"] = true,
		["cat_shop"] = true
	},
	loc_vars = function(self, info_queue, card)
		-- im not sure honestly
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			SMODS.add_card {
				key = 'c_mexmod_boxofcats',
				edition = 'e_negative'
			}
		end
		if context.adding_card or context.buying_card or context.selling_card or context.end_of_round and context.main_eval or context.using_consumeable and context.consumeable.config.center.key == 'c_mexmod_boxofcats' then
			if not context.blueprint then
				local catcount = -1
				if context.using_consumeable and context.consumeable.config.center.key == 'c_mexmod_boxofcats' then
					catcount = 0
				end
				if context.selling_card and (context.card.config.center.pools and next(context.card.config.center.pools)) then
					if context.selling_card and context.card.config.center.pools.cat then
						catcount = -2
					end
				end
				for _, J in ipairs(G.jokers.cards) do
					if J.config.center.pools and J.config.center.pools.cat then
						catcount = catcount + 1
					end
				end
				card.ability.extra.acard_limit_old = card.ability.extra.acard_limit
				card.ability.extra.acard_limit = catcount
				G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.acard_limit_old
				G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.acard_limit
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		---@diagnostic disable-next-line: redundant-return-value
		if from_debuff then return nil end
		G.jokers.config.card_limit = G.jokers.config.card_limit + 1 - card.ability.extra.acard_limit_old
	end,

}

-- NOOOOOO YOU CANT JUST START DOING TAROTS RIGHT HERE YOU HAVEN'T MADE ALL THE JOKERS
-- tarot cards go brrr motherfucker

SMODS.Consumable {
	key = 'boxofcats',
	set = 'Tarot',
	loc_txt = {
		name = 'Box of Cats',
		text = {
			"Summons one cat card.",
			"{C:inactive}'You have picked up a cat.'",
			"{C:inactive, s:0.5} 'btw your literally stupid if you dont know what jokers are cats'",
			"{C:inactive} ART BY Astro IN THE BALATRO DISCORD"
		}
	},
	atlas = 'consumables',
	pos = { x = 0, y = 0 },
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('timpani')
				SMODS.add_card({ set = 'cat_shop' })
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		delay(0.6)
	end,
	can_use = function(self, card)
		if not SMODS.find_card("j_mexmod_catofboxes") then
			return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
		end
		return true
	end
}

-- guys there's too many types of objects
-- two lines of comment makes it easier to tell when there's a new category

SMODS.ObjectType {
	key = 'cat',
	cards = {
		j_lucky_cat = true,

	}
}

SMODS.ObjectType {
	key = 'cat_shop',
	default = 'kat',
	cards = {
		j_lucky_cat = true,

	}
}


