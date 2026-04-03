local M = {}

M.HOST = "localhost"
M.PORT = 8084
M.GAME_MODE = "arena"
M.LEADERBOARD_ID = "arena_kills"

M.client = nil
M.match_result = nil
M.current_round = 1
M.current_modifier = nil
M.my_boons = {}

-- Shared data for cross-GUI communication (msg.post cannot carry nested tables)
M.boon_data = nil       -- {boon_offers, time_remaining, picks_done}
M.vote_data = nil       -- {vote_id, options, window_ms}
M.vote_tally_data = nil -- {tallies, total_votes, time_remaining_ms}
M.vote_result_data = nil -- {winner}
M.latest_match_state = nil

M.ARENA_WIDTH = 800
M.ARENA_HEIGHT = 600

-- Naval theme colors (asobi.dev palette)
M.COLORS = {
	bg = vmath.vector4(0.051, 0.122, 0.235, 1.0),        -- #0d1f3c
	primary = vmath.vector4(0.788, 0.745, 1.0, 1.0),      -- #c9beff
	secondary = vmath.vector4(0.569, 0.804, 1.0, 1.0),    -- #91cdff
	tertiary = vmath.vector4(0.290, 0.882, 0.514, 1.0),   -- #4ae183
	error = vmath.vector4(1.0, 0.706, 0.671, 1.0),        -- #ffb4ab
	text = vmath.vector4(0.878, 0.882, 0.961, 1.0),       -- #e0e1f5
	text_muted = vmath.vector4(0.576, 0.557, 0.627, 1.0), -- #938ea0
	surface = vmath.vector4(0.110, 0.122, 0.176, 1.0),    -- #1c1f2d
	surface_low = vmath.vector4(0.063, 0.075, 0.133, 1.0),-- #101320
	surface_high = vmath.vector4(0.149, 0.161, 0.220, 1.0),-- #262938
	outline = vmath.vector4(0.282, 0.271, 0.329, 1.0),    -- #484554
	hp_good = vmath.vector4(0.290, 0.882, 0.514, 1.0),    -- #4ae183
	hp_mid = vmath.vector4(0.788, 0.745, 1.0, 1.0),       -- #c9beff
	hp_low = vmath.vector4(1.0, 0.706, 0.671, 1.0),       -- #ffb4ab
	black = vmath.vector4(0, 0, 0, 1),
	btn_primary = vmath.vector4(0.373, 0.255, 0.847, 1.0),-- #5f41d8
	btn_danger = vmath.vector4(0.8, 0.2, 0.2, 1.0),
}

return M
