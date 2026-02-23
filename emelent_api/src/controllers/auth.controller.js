import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { db } from "../config/db.js";

/* -------------------------------- UTIL -------------------------------- */

const generateOtp = () =>
  Math.floor(1000 + Math.random() * 9000).toString();

const generateRandomPhoneNumber = () => {
  // Generate a random 10-digit number
  // First digit should be between 6-9 (typical mobile number starting digits)
  const firstDigit = Math.floor(Math.random() * 4) + 6; // Generates 6,7,8, or 9
  const remainingDigits = Math.floor(Math.random() * 1000000000).toString().padStart(9, '0');
  return `${firstDigit}${remainingDigits}`;
};


/* ------------------------------- SIGNUP -------------------------------- */

export const signup = async (req, res) => {
  try {
    const { first_name, email, password } = req.body;
    const username = first_name;
    const phone = generateRandomPhoneNumber();
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
    try {
      await db.query(
        `INSERT INTO otp_verifications (user_id, otp, expires_at)
       VALUES (?, ?, NOW() + INTERVAL 5 MINUTE)`,
        [result.insertId, otp]
      );
    }
    catch (e) {
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
    const { email, otp } = req.body;

    if (!email || !otp) {
      return res.status(400).json({ message: "OTP required" });
    }

    const [[user]] = await db.query(
      "SELECT * FROM users WHERE email=?",
      [email]
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

    const accessToken  = jwt.sign(
      { id: user.id, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: "7d" }
    );

    res.json({ data: { user, tokens : { accessToken } } });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "OTP verification failed" });
  }
};


/*------------------------------- RESEND OTP -----------------------------*/

export const resendOtp = async (req, res) => {
  try {
    const { email } = req.body;
    const [[user]] = await db.query(
      "SELECT * FROM users WHERE email=?",
      [email]
    );

    await db.query(
      "DELETE FROM otp_verifications WHERE user_id=?",
      [user.id]
    );

    const otp = generateOtp();

    // Store OTP (5 min expiry)
    try {
      await db.query(
        `INSERT INTO otp_verifications (user_id, otp, expires_at)
       VALUES (?, ?, NOW() + INTERVAL 5 MINUTE)`,
        [user.id, otp]
      );
    }
    catch (e) {
      console.log("otp not added in db");
    }

    // TODO: Integrate SMS provider
    console.log("OTP for", email, ":", otp);
  }
  catch(err){
     res.status(500).json({ message: "OTP Resend failed" });
  }
}

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

    const accessToken = jwt.sign(
      { id: user.id, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: "7d" }
    );

    res.json({ data: { user , tokens : { accessToken }} });
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
