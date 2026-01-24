import { db } from "../config/db.js";

export const getFeed = async (req, res) => {
  const { category } = req.query;

  let query = `SELECT * FROM posts WHERE status='approved'`;
  const params = [];

  if (category) {
    query += ` AND category=?`;
    params.push(category);
  }

  const [rows] = await db.query(query, params);
  res.json(rows);
};
