import { Router } from "jsr:@oak/oak/router";
import { Pendingbills } from "../methods/pendingbill.ts";
const router = new Router();

router.get("/payment/pendingbills", Pendingbills);
