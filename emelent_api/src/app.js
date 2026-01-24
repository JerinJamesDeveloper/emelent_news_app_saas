import express from "express";
import cors from "cors";

import authRoutes from "./routes/auth.routes.js";
import userRoutes from "./routes/user.routes.js";
import postRoutes from "./routes/post.routes.js";
import feedRoutes from "./routes/feed.routes.js";
import adminRoutes from "./routes/admin.routes.js";

const app = express(); 

app.use(cors());
app.use(express.json());

app.use("/auth", authRoutes);
app.use("/users", userRoutes);
app.use("/posts", postRoutes);
app.use("/feed", feedRoutes);
app.use("/admin", adminRoutes);

export default app;
