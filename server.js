const express = require("express");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 80;

// 1) Health endpoint
app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

// 2) Serve the React build
app.use(express.static(path.join(__dirname, "build")));

// 3) SPA fallback
app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "build", "index.html"));
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
});