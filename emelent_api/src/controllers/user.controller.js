import { db } from "../config/db.js";

export const getMe = async (req, res) => {
  const [rows] = await db.query(
    `SELECT id, username, full_name, profile_image, bio, is_verified, trust_score
     FROM users WHERE id=?`,
    [req.user.id]
  );

  res.json(rows[0]);
};

export const updateMe = async (req, res) => {
  const { full_name, bio, profile_image } = req.body;

  await db.query(
    `UPDATE users SET full_name=?, bio=?, profile_image=? WHERE id=?`,
    [full_name, bio, profile_image, req.user.id]
  );

  res.json({ message: "Profile updated" });
};

export const getUserByUsername = async (req, res) => {
  const [rows] = await db.query(
    `SELECT id, username, full_name, profile_image, bio
     FROM users WHERE username=?`,
    [req.params.username]
  );

  res.json(rows[0]);
};
