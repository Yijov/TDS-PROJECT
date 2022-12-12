import { Request, Response, NextFunction } from "express";
import { Router } from "express";
import userController from "../api/user/UserController";

const router: Router = Router();

//customers  api/v1/auth
//only users
router.get("/", async (req: Request, res: Response) => {
  return res.status(200).json({ success: true });
});
router.get("/auth", userController.GET_SIGNOUT);
router.post("/auth", userController.POST_SIGNIN);

export default router;
