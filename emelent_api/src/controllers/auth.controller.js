import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { db } from "../config/db.js";

/* -------------------------------- UTIL -------------------------------- */

const generateOtp = () =>
  Math.floor(100000 + Math.random() * 900000).toString();

/* ------------------------------- SIGNUP -------------------------------- */

export const signup = async (req, res) => {
  try {
    const { first_name, email, password } = req.body;
    const username = first_name;
    const phone = "952234728";
    if (!username || !email || !password || !phone) {
      return res.status(400).json({ message: "All fields are required" });
    }

    // Check if email or phone already exists
    const [existing] = await db.query(
      "SELECT id FROM users WHERE email=? OR phone=?",
      [email, phone]
    );

    if (existing.length > 0) {
      return res
        .status(409)
        .json({ message: "Email or phone already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    // Create user (unverified)
    const [result] = await db.query(
      `INSERT INTO users (username, email, password, phone, is_verified)
       VALUES (?, ?, ?, ?, false)`,
      [username, email, hashedPassword, phone]
    );

    const otp = generateOtp();

    // Store OTP (5 min expiry)
    try{
          await db.query(
      `INSERT INTO otp_verifications (user_id, otp, expires_at)
       VALUES (?, ?, NOW() + INTERVAL 5 MINUTE)`,
      [result.insertId, otp]
    );
    }
  catch(e){
    console.log("otp not added in db");
  }

    // TODO: Integrate SMS provider
    console.log("OTP for", phone, ":", otp);

    res.status(201).json({
      message: "Signup successful. Please verify OTP.",
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Signup failed" });
  }
};

/* ----------------------------- VERIFY OTP ------------------------------ */

export const verifyOtp = async (req, res) => {
  try {
    const { phone, otp } = req.body;

    if (!phone || !otp) {
      return res.status(400).json({ message: "Phone and OTP required" });
    }

    const [[user]] = await db.query(
      "SELECT id, role FROM users WHERE phone=?",
      [phone]
    );

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const [[otpRecord]] = await db.query(
      `SELECT id FROM otp_verifications
       WHERE user_id=? AND otp=? AND expires_at > NOW()`,
      [user.id, otp]
    );

    if (!otpRecord) {
      return res.status(400).json({ message: "Invalid or expired OTP" });
    }

    // Mark verified
    await db.query(
      "UPDATE users SET is_verified=true WHERE id=?",
      [user.id]
    );

    // Delete OTP
    await db.query(
      "DELETE FROM otp_verifications WHERE user_id=?",
      [user.id]
    );

    const token = jwt.sign(
      { id: user.id, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: "7d" }
    );

    res.json({ token });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "OTP verification failed" });
  }
};

/* -------------------------------- LOGIN -------------------------------- */

export const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    const [[user]] = await db.query(
      "SELECT * FROM users WHERE email=?",
      [email]
    );

    if (!user) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    if (!user.is_verified) {
      return res
        .status(403)
        .json({ message: "OTP verification required" });
    }

    const match = await bcrypt.compare(password, user.password);
    if (!match) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    const token = jwt.sign(
      { id: user.id, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: "7d" }
    );

    res.json({ token });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Login failed" });
  }
};

/* ------------------------------- GET ME -------------------------------- */

export const getMe = async (req, res) => {
  const [[user]] = await db.query(
    `SELECT id, username, email, phone, profile_image, bio, role
     FROM users WHERE id=?`,
    [req.user.id]
  );

  res.json(user);
};
