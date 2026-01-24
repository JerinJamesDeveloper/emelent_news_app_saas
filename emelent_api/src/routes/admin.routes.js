import express from "express";
import { authMiddleware } from "../middleware/auth.middleware.js";
import { adminMiddleware } from "../middleware/admin.middleware.js";
import {
  pendingPosts,
  approvePost,
  removePost,
} from "../controllers/admin.controller.js";

const router = express.Router();

router.use(authMiddleware, adminMiddleware);

router.get("/posts/pending", pendingPosts);
router.put("/posts/:id/approve", approvePost);
router.put("/posts/:id/remove", removePost);

export default router;
