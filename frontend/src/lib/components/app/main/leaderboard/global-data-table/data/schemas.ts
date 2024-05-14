import { z } from 'zod';

export const globalLeaderboardSchema = z.object({
	username: z.string(),
	elo: z.number()
});

export type GlobalLeaderboard = z.infer<typeof globalLeaderboardSchema>;
