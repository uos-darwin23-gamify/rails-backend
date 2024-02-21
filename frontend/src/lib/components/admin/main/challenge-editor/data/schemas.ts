import { z } from 'zod';

export const challengeOverviewSchema = z.object({
	id: z.string(),
	name: z.string(),
	_type: z.string(),
	difficulty: z.string(),
});

export type ChallengeOverview = z.infer<typeof challengeOverviewSchema>;
