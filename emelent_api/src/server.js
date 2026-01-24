// ✅ LOAD ENV FIRST

import app from "./app.js";


console.log("DB_HOST:", process.env.DB_HOST);
console.log("DB_PORT:", process.env.DB_PORT);

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`🚀 Emelent API running on port ${PORT}`);
});
 