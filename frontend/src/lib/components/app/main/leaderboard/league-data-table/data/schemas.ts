import { z } from 'zod';

export const leagueLeaderboardSchema = z.object({
	username: z.string(),
	elo: z.number(),
	league: z.string()
});

export type LeagueLeaderboard = z.infer<typeof leagueLeaderboardSchema>;
