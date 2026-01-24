import { db } from "../config/db.js";

export const pendingPosts = async (_, res) => {
  const [rows] = await db.query(
    `SELECT * FROM posts WHERE status='pending'`
  );
  res.json(rows);
};

export const approvePost = async (req, res) => {
  await db.query(
    `UPDATE posts SET status='approved', verification_status='admin' WHERE id=?`,
    [req.params.id]
  );
  res.json({ message: "Approved" });
};

export const removePost = async (req, res) => {
  await db.query(
    `UPDATE posts SET status='removed' WHERE id=?`,
    [req.params.id]
  );
  res.json({ message: "Removed" });
};
