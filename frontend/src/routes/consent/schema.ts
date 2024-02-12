import { z } from "zod";

export const formSchema = z.object({
    consent1: z.boolean().default(false),
    consent2: z.boolean().default(false),
    consent3: z.boolean().default(false),
    consent4: z.boolean().default(false),
    consent5: z.boolean().default(false),
    consent6: z.boolean().default(false),
    consent7: z.boolean().default(false),
    consent8: z.boolean().default(false),
    consent9: z.boolean().default(false),
    consent10: z.boolean().default(false),
    consent11: z.boolean().default(false),
    consent12: z.boolean().default(false),
    consent13: z.boolean().default(false)
});

export type FormSchema = typeof formSchema;