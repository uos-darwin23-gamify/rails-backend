// import type { Actions, PageServerLoad } from "./$types";
import type { PageServerLoad } from "./$types";
import { superValidate } from "sveltekit-superforms/server";
import { formSchema } from "./schema";
// import { fail } from "@sveltejs/kit";

export const load: PageServerLoad = async () => {
  return {
    form: await superValidate(formSchema),
  };
};

// TODO: This is crashing the app
// See: https://www.shadcn-svelte.com/docs/components/form


// export const actions: Actions = {
//   default: async (event) => {
//     const form = await superValidate(event, formSchema);
//     if (!form.valid) {
//       return fail(400, {
//         form,
//       });
//     }
//     return {
//       form,
//     };
//   },
// };