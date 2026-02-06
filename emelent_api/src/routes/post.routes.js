import express from "express";
import { authMiddleware } from "../middleware/auth.middleware.js";
import {
  createPost,
  getPost,
  getBatchPosts,
  confirmPost,
  unconfirmPost,

} from "../controllers/post.controller.js";

const router = express.Router();

router.post("/", authMiddleware, createPost);
router.get("/:id", getPost);
router.post("/batch", getBatchPosts);
router.post("/:id/confirm", authMiddleware, confirmPost);
router.delete("/:id/confirm", authMiddleware, unconfirmPost);

export default router;
