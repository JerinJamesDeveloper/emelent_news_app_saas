import express from "express";
import { authMiddleware } from "../middleware/auth.middleware.js";
import {
  getMe,
  updateMe,
  getUserByUsername,
} from "../controllers/user.controller.js";

const router = express.Router();

router.get("/me", authMiddleware, getMe);
router.put("/me", authMiddleware, updateMe);
router.get("/:username", getUserByUsername);

export default router;
