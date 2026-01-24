import express from "express";
import {
  signup,
  verifyOtp,
  login,
  getMe,
} from "../controllers/auth.controller.js";
import { authMiddleware } from "../middleware/auth.middleware.js";

const router = express.Router();

/**
 * AUTH
 */
router.post("/signup", signup); 
router.post("/verify-otp", verifyOtp);
router.post("/login", login);
router.get("/me", authMiddleware, getMe);

export default router; 
