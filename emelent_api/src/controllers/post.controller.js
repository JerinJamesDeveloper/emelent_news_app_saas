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

export const getBatchPosts = async (req, res) => {
  try {
    const limit = 10;
    const offset = Number(req.query.offset) || 0;

    const [rows] = await db.query(
      `
      SELECT
        id,
        title,
        image_url,
        category,
        verification_status,
        confirm_count,
        report_count,
        created_at
      FROM posts
      WHERE status = 'approved'
      ORDER BY created_at DESC
      LIMIT ? OFFSET ?
      `,
      [limit, offset]
    );

    res.json({
      batchSize: rows.length,
      nextOffset: offset + rows.length,
      data: rows,
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
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
