import { db } from "../config/db.js";

export const createPost = async (req, res) => {
  const { title, content, category } = req.body;

  await db.query(
    `INSERT INTO posts (user_id, title, content, category) VALUES (?, ?, ?, ?)`,
    [req.user.id, title, content, category]
  );

  res.json({ message: "Post created" });
};

export const getPost = async (req, res) => {
  const [rows] = await db.query(`SELECT * FROM posts WHERE id=?`, [
    req.params.id,
  ]);
  res.json(rows[0]);
};

export const confirmPost = async (req, res) => {
  await db.query(
    `INSERT IGNORE INTO confirms (post_id, user_id) VALUES (?, ?)`,
    [req.params.id, req.user.id]
  );

  await db.query(
    `UPDATE posts SET confirm_count = confirm_count + 1 WHERE id=?`,
    [req.params.id]
  );

  res.json({ message: "Confirmed" });
};

export const unconfirmPost = async (req, res) => {
  await db.query(
    `DELETE FROM confirms WHERE post_id=? AND user_id=?`,
    [req.params.id, req.user.id]
  );

  await db.query(
    `UPDATE posts SET confirm_count = confirm_count - 1 WHERE id=? AND confirm_count > 0`,
    [req.params.id]
  );

  res.json({ message: "Unconfirmed" });
};
