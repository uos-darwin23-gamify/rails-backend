import { z } from 'zod';

export const preAuthorizedEmailsSchema = z.object({
	id: z.number(),
	email: z.string(),
	group: z.string()
});

export type PreAuthorizedEmail = z.infer<typeof preAuthorizedEmailsSchema>;
