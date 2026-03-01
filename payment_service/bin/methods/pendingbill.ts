import { Body } from "jsr:@oak/oak/body";
import { Context } from "jsr:@oak/oak/context";

export const Pendingbills = async (ctx: Context) => {
  const jsonbody = ctx.request.body.json;
  const {userid} = jsonbody

};
